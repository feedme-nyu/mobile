import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/app/widget-get-started.dart';
import 'package:feedme/app/widget-survey.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:feedme/app/consts.dart';
import 'package:feedme/app/page-home.dart';

import 'package:feedme/struct/user.dart';
import 'package:feedme/struct/preference.dart';

class SurveyPage extends StatefulWidget {
  SurveyPage({ this.user });

  final User user;

  @override
  _SurveyPageState createState() => _SurveyPageState(); 
}

class _SurveyPageState extends State<SurveyPage> {
  int state = 0;
  int display = 1;
  String distance = "";
  List<String> _cuisines = List<String>();

  @override
  void initState() {
    super.initState();
  }

  void updateDistance(String _distance) {
    setState(() => distance = _distance);
  }

  void updateCuisine(List<String> c) {
    setState(() {
      _cuisines.clear();
      _cuisines.addAll(c);
    });
  }

  void saveAnswers(BuildContext context) {
    if (_cuisines.length == 0) {
      final snackBar = SnackBar(content: Text('You have to specify at least one cuisine'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
    else if (distance.length == 0) {
      final snackBar = SnackBar(content: Text('You have to specify a mode of travel'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
    else {
      setState(() {
        List<String> translated = List<String>();
        for (String formal in _cuisines) {
          translated.add(cuisines[formal]);
        }
        Firestore.instance.collection('user-trends').document(widget.user.identity.uid)
        .updateData({
          "history": translated
        });
        state += 1;
      });
    }
  }

  Widget ending () {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Thank you for your responses. You can change them anytime via the profile page.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: OutlineButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) { 
                  return MyHomePage(title: "Feed Me", user: widget.user);
                }));
              }
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            borderSide: BorderSide(color: primary),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Continue", 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primary,
                  fontSize: 24.0,
                ),
              ),
            ), 
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: <Widget> [
            Navigator.of(context).canPop() ?
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    Text("Your Preferences", style: TextStyle(fontSize: 18.0),)
                  ],
                ),
              ) : Padding(padding:EdgeInsets.all(0)),
            state == 0 ? getStarted(context, display, <Widget>[
              startCard(() {
                setState(() => state += 1);
              }, () {
                setState(() => display = 2);
              }),
              learnMore()
            ]) : 
                (state == 1 ? SurveyWidget(
                  context,
                  saveAnswers,
                  updateDistance,
                  updateCuisine,
                  _cuisines,
                  distance) : ending()),
          ]
        ),
      )
    );
  }
}