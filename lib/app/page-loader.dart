import 'dart:async';
import 'dart:convert';

import 'package:feedme/app/page-decisions.dart';
import 'package:feedme/struct/decision.dart';
import 'package:feedme/struct/restaurant.dart';
import 'package:feedme/struct/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:feedme/app/consts.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage(this.decisions, this.user, {Key key}) : super(key: key);

  final Future<http.Response> decisions;
  final User user;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  StreamSubscription sub;

  @override
  void initState() {
    sub = widget.decisions.asStream().listen((http.Response response) {
      print("Responsy");
      print(response.statusCode);
      if (response.statusCode != 200) {
        print("Failed");
        Fluttertoast.showToast(
          msg: "Oops, something went wrong, try again in a couple seconds...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3,
          textColor: Colors.white,
          fontSize: 16.0
        );
        throw "network";
      }
      else {
        print(response.body);
        Map<String, dynamic> results = json.decode(response.body);
        List<Map <String, dynamic>> decisions = List<Map <String, dynamic>>.from(results["decisions"]);
        
        List<Decision> output = List<Decision>();
        for (int i = 0; i < decisions.length; ++i) {
          Map<String, dynamic> m = decisions[i];
          output.add(Decision(
            recommendation: Restaurant.fromJson(m),
          ));
        }
        print("done");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) { 
            return DecisionPage(output, widget.user);
          })
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget> [
                  Positioned(
                    left: 0, 
                    height: MediaQuery.of(context).size.width * 0.75 + 2,  
                    width: MediaQuery.of(context).size.width * 0.75,
                    bottom: 0,
                    child: CircularProgressIndicator(strokeWidth: 10.0)
                  ),
                  Image.asset(
                    "assets/images/load.png",
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                ],
              ),
              Padding(
                child: Text("Please wait as we find you something to eat!", style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,),
                padding: EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0),
              ),
              Padding(
                padding: EdgeInsets.all(32.0),
                child: OutlineButton.icon(
                  label: Text("Cancel Search"),
                  icon: Icon(Icons.close),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    sub.cancel();
                    Navigator.of(context).pop();
                  },
                )
              )
            ],
          ),
        ),
      )
    );
  }
}