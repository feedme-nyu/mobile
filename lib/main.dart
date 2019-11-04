import 'package:flutter/material.dart';

// Color constants
final Color primary = Color.fromARGB(255, 229, 130, 0);
final Color background = Color.fromARGB(255, 235, 235, 235);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FeedMe',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'FeedMe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/profile.png",
                      width: 72.0,
                    )
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "FEED ME",
                  style: TextStyle(
                    fontSize: 42.0, 
                    fontWeight: FontWeight.bold, 
                    fontFamily: 'Fredoka',
                    color: primary,
                  ),
                ),
                Image.asset(
                  "assets/images/up-fork.png",
                  height: MediaQuery.of(context).size.height * 0.50,
                  repeat: ImageRepeat.noRepeat,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
