import 'package:flutter/material.dart';

import 'package:feedme/app/consts.dart';
import 'package:feedme/app/page-decisions.dart';
import 'package:feedme/app/page-profile.dart';

import 'package:feedme/struct/user.dart';
import 'package:feedme/struct/decision.dart';
import 'package:feedme/struct/restaurant.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final User user;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
  with SingleTickerProviderStateMixin {
  
  bool showMenu = false;
  AnimationController menuAnimationController;
  Animation<double> scaleAnimation;

  List <Decision> _getDecisions () {
    return <Decision> [
      Decision(
        recommendation: Restaurant(
          imageUrl: "https://lh5.googleusercontent.com/p/AF1QipOkvxJ12kb6bAkfdMWpVLQ1rIOtuI3rwvcL4k33=w203-h135-k-no",
          name: "Yaso Tangbao",
          address: "148 Lawrence St, Brooklyn, NY 11201",
          mapsUrl: "https://goo.gl/maps/ySp9Lz1avZcjFmA39",
        )
      ),
      Decision(
        recommendation: Restaurant(
          imageUrl: "https://lh5.googleusercontent.com/p/AF1QipNGZhzPJ_OhRyYxRfdPHdHtn7KXgDCGlRQ78UD9=w203-h270-k-no",
          name: "Golden Fried Dumpling",
          address: "192 Duffield St, Brooklyn, NY 11201",
          mapsUrl: "https://goo.gl/maps/z5UGnAJWE8edX61e7",
        )
      ),
      Decision(
        recommendation: Restaurant(
          imageUrl: "https://lh5.googleusercontent.com/p/AF1QipM3KjHPcWdzT-0uETX5F-WshJXtWNCUKqo64axY=w203-h152-k-no",
          name: "Kind Dumpling",
          address: "74 Hester St, New York, NY 10002",
          mapsUrl: "https://goo.gl/maps/SoMWEBeCd6Jv9g6QA",
        )
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    menuAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));
    scaleAnimation = CurvedAnimation(parent: menuAnimationController, curve: Curves.easeIn, ); 
  }

  @override
  void dispose() {
    menuAnimationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (showMenu == true) {
      menuAnimationController.forward();
    }
    else {
      menuAnimationController.reverse();
    }

    return GestureDetector (
      onTap: () {
        setState(() => showMenu = false);
      },
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0, 
                left: 0.0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showMenu = true;              
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container (
                      width: 54.0,
                      height: 54.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.user.identity.photoUrl),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned (
                top: 10.0,
                left: 64.0 + 32.0,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  alignment: Alignment(-1.0, -0.85), 
                  child: _ShapedWidget(
                    height: null,
                    width: 200.0,
                    padding: 0,
                    children: <Widget> [
                      Container(
                        height: 50.0,
                        width: 150.0,
                        child: FlatButton (
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) { 
                                showMenu = false;
                                return ProfilePage(user: widget.user,);
                              })
                            );
                          }, 
                          child: Text("My Profile"),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 150.0,
                        child: FlatButton (
                          onPressed: () {}, 
                          child: Text("App Settings"),
                        ),
                      ),
                    ],
                  ),
                )
              ),
              Positioned (
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding (
                      padding: EdgeInsets.all(24.0),
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) { 
                              return DecisionPage(decisions: _getDecisions(),);
                            })
                          );
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        borderSide: BorderSide(color: primary),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            "FEED ME", 
                            style: TextStyle(
                              fontSize: 42.0, 
                              fontWeight: FontWeight.bold, 
                              fontFamily: 'Fredoka',
                              color: primary,
                            ),
                          ),
                        ), 
                      ),
                    ),
                    Image.asset(
                      "assets/images/fork-anim.gif",
                      height: MediaQuery.of(context).size.height * 0.45,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShapedWidget extends StatelessWidget {
  _ShapedWidget({ this.width, this.height, this.children, this.padding });
  final double padding;
  final double width;
  final double height;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape:
        _ShapedWidgetBorder(borderRadius: BorderRadius.all(Radius.circular(padding)), padding: padding),
        elevation: 4.0,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}

class _ShapedWidgetBorder extends RoundedRectangleBorder {
  _ShapedWidgetBorder({
    @required this.padding,
    side = BorderSide.none,
    borderRadius = BorderRadius.zero,
  }) : super(side: side, borderRadius: borderRadius);
  final double padding;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left, rect.top + 16.0)
      ..lineTo(rect.left - 8.0, rect.top + 26.0)
      ..lineTo(rect.left, rect.top + 38.0)
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height - padding)));
  }
}
