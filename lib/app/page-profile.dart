import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:feedme/app/consts.dart';
import 'package:feedme/app/page-signin.dart';
import 'package:feedme/app/page-survey.dart';

import 'package:feedme/struct/user.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text("Your Profile", style: TextStyle(fontSize: 18.0),)
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container (
                  width: 84.0,
                  height: 84.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.user.identity.photoUrl),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(widget.user.identity.displayName, style: TextStyle(fontSize: 24.0, fontFamily: "Fredoka")),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(widget.user.identity.email, style: TextStyle(fontSize: 16.0)),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: OutlineButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SurveyPage();
                    }));
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  borderSide: BorderSide(color: primary),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "Update your preferences", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ), 
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: OutlineButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((success) {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) { 
                        return LoginPage();
                      }), (Route<dynamic> route) => false);
                    }).catchError((err) {
                      Fluttertoast.showToast(
                        msg: "Something went wrong...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 2,
                        textColor: Colors.white,
                        fontSize: 16.0
                      );
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  borderSide: BorderSide(color: Colors.redAccent),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "Logout", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ), 
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}