import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/app/page-survey.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:feedme/app/page-signin.dart';
import 'package:feedme/app/page-home.dart';
import 'package:feedme/struct/user.dart';
import 'package:splashscreen/splashscreen.dart';

import 'app/consts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<dynamic> _showLoginPage() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      return LoginPage();
    }
    try {
      DocumentSnapshot db = await Firestore.instance.collection('user-trends').document(user.uid).get();
      return MyHomePage(user: User(user, db["history"]));
    }
    catch (error) {
      Firestore.instance.collection('user-trends').document(user.uid).setData({"history": []});
      return SurveyPage(user: User(user, []));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FeedMe',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(
        navigateAfterFuture: _showLoginPage(),
        // seconds: 10,
        title: Text(""),
        image: Image.asset('assets/launcher/icon-old.png'),
        backgroundColor: background,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: primary
      )
    );
  }
}