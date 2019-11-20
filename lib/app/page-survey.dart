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
  List<SurveyQuestion> surveyQuestions;

  @override
  void initState() {
    surveyQuestions = _getPreferences();
    super.initState();
  }

  List<SurveyQuestion> _getPreferences() {
    // TODO: get defined preferences from server, rather than hardcoded
    List<Preference> prefs = [
      Preference("peanut-allergy", PreferenceCategory.allergy),
      Preference("shellfish-allergy", PreferenceCategory.allergy),
      Preference("soy-allergy", PreferenceCategory.allergy),
    ];
    List<SurveyQuestion> questions = [
      SurveyQuestion("Do you have any allergies?", PreferenceCategory.allergy),
      SurveyQuestion("Do you have any dietary restrictions?", PreferenceCategory.restriction),
    ];
    for (int i = 0; i < prefs.length; ++i) {
      for (int j = 0; j < questions.length; ++j) {
        if (questions[j].addPreference(prefs[i])) break;
      }
    }
    return questions;
  }

  Widget getStarted () {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Before we can feed you, you need to feed our match making algorithm with some data.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: OutlineButton(
            onPressed: () {
              setState(() => state = 1);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            borderSide: BorderSide(color: primary),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Let's go!", 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primary,
                  fontSize: 24.0,
                ),
              ),
            ), 
          ),
        ),
        Padding(
          padding: EdgeInsets.only(),
          child: FlatButton(
            onPressed: () { },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Learn More", 
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0
                ),
              ),
            ), 
          ),
        )
      ],
    );
  }

  Widget survey (BuildContext context) {
    return CarouselSlider(
      height: MediaQuery.of(context).size.height * 0.75,
      enableInfiniteScroll: false,
      autoPlay: false,
      items: surveyQuestions,
    );
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
              Row(
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
              ) : Container(),
            Center(
              child: state == 0 ? getStarted() : 
                (state == 1 ? survey(context) : ending()),
            ),
          ]
        ),
      )
    );
  }
}

class SurveyQuestion extends StatefulWidget{
  final List<Preference> options = List();
  final String prompt;
  final PreferenceCategory category;
  
  SurveyQuestion(this.prompt, this.category);
  
  bool addPreference (Preference preference) {
    if (preference.category == this.category) {
      options.add(preference);
      return true;
    }
    return false;
  }

  @override
  SurveyQuestionState createState() => SurveyQuestionState();
}

class SurveyQuestionState extends State<SurveyQuestion> {
  @override
  Widget build(BuildContext context) {
    List<Widget> choiceWidgets = List(); 
    
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          child: Text(widget.prompt, textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: choiceWidgets,
        ),
      ],
    );
  }
}