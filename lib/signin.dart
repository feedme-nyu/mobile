import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'homepage.dart';
import 'consts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> _signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount;
    try {
      googleSignInAccount = await googleSignIn.signIn();
    }
    on PlatformException {
      throw "Login Cancelled";
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset("assets/images/profile-anim.gif", height: 125.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                child: Text("Welcome to Feed Me", textAlign: TextAlign.center, style: TextStyle(fontSize: 32.0, fontFamily: 'Fredoka',)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25.0),
                child: Text("Ready to get fed?", style: TextStyle(fontSize: 20.0)),
              ),
              OutlineButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                borderSide: BorderSide(color: Colors.grey),
                highlightElevation: 0,
                onPressed: () {
                  _signInWithGoogle().then((value) {

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) { 
                        return MyHomePage(title: "Feed Me");
                      })
                    );
                  }).catchError((error) {});
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 15.0, 0, 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Image.asset("assets/images/g.png", width: 28.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                        child: Text("Sign in with Google", style: TextStyle(fontSize: 18.0),), 
                      ),
                    ],
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