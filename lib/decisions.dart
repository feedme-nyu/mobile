import 'dart:ui' as prefix0;

import 'package:feedme/consts.dart';
import 'package:flutter/material.dart';

class DecisionPage extends StatefulWidget {
  DecisionPage({Key key}) : super(key: key);

  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage>
  with SingleTickerProviderStateMixin {
  
  static final double translation = 200.0;
  final RelativeRectTween rectAnimation = RelativeRectTween(
    begin: RelativeRect.fromLTRB(10, 0.0, 10.0, 0.0),
    end: RelativeRect.fromLTRB(10.0 - translation, 0.0, 10.0 + translation, 0.0),
  );

  AnimationController _slideController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx < 0) {
              _slideController.forward();
            }
          },
          child: Stack(
            children: <Widget> [
              Positioned(
                top: 0,
                left: 0,
                child: Padding (
                  padding: EdgeInsets.all(16.0),
                  child: ClipOval(
                    child: Material(
                      color: Color.fromARGB(0, 0, 0, 0),
                      child: InkWell(
                        splashColor: Colors.grey,
                        child: SizedBox(width: 36, height: 36, child: Icon(Icons.arrow_back)),
                        onTap: () { Navigator.of(context).pop(); },
                      )
                    ),
                  )
                ),
              ),
              PositionedTransition(
                rect: rectAnimation.animate(_slideController),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.width * 0.90,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: MediaQuery.of(context).size.width * 0.80,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage("https://lh5.googleusercontent.com/p/AF1QipNchU26CAHyMHPJcEgB-aW3lfzAaU62Om3E7w8I=w203-h135-k-no"),
                        )
                      ),
                    ),
                  ),
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}