import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signin.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<bool> _showLoginPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = !prefs.getBool("loggedin");
    return isLoggedIn;
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FeedMe',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder<bool>(
        future: _showLoginPage(),
        builder: (buildContext, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return MyHomePage(title: 'Feed Me');
          }
          else {
            return LoginPage();
          }
        }
      )
    );
  }
}