import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:feedme/app/page-signin.dart';
import 'package:feedme/app/page-home.dart';
import 'package:feedme/struct/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<User> _showLoginPage() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      throw "No registered user";
    }
    return User(user);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FeedMe',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder<User>(
        future: _showLoginPage(),
        builder: (buildContext, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage(title: 'Feed Me', user: snapshot.data);
          }
          else {
            return LoginPage();
          }
        }
      )
    );
  }
}