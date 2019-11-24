import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/app/widget-decision-dialog.dart';
import 'package:feedme/struct/user.dart';
import 'package:flutter/material.dart';

import 'package:feedme/app/consts.dart';
import 'package:feedme/struct/decision.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widget-animated-card.dart';
import 'widget-back-card.dart';

class DecisionPage extends StatefulWidget {
  final List<Decision> decisions;
  final User user;

  DecisionPage(this.decisions, this.user, {Key key}) : super(key: key);

  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage>
    with SingleTickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  bool madeDecision = false;
  Decision chosen;

  void initState() {
    super.initState();

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = widget.decisions.removeLast();
          widget.decisions.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );

    // Sort
    widget.decisions.sort((Decision a, Decision b) {
      return b.score.compareTo(a.score);
    });
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(Decision img) {
    setState(() {
      widget.decisions.remove(img);
    });
  }

  addImg(Decision decision) {
    Firestore.instance.collection('restaurants').document(decision.recommendation.hash)
      .setData({
        "frequency": FieldValue.increment(1.0),
        "categories": decision.recommendation.categories,
        "id": decision.recommendation.hash
      });
    
    widget.user.history.addAll(decision.recommendation.categories);
    
    Firestore.instance.collection('user-trends').document(widget.user.identity.uid)
      .updateData({
        "history": widget.user.history
      });
    
    widget.decisions.remove(decision);
    widget.decisions.add(decision);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        Widget dialog = DecisionDialog(
          decision, 
          () {
            Navigator.of(ctx).pop();
          },
          () async {
            String url = 'https://www.google.com/maps/search/?api=1&query_place_id=' + decision.recommendation.id + 
              '&query=' + Uri.encodeComponent(decision.recommendation.address);
            if (await canLaunch(url)) {
              await launch(url);
              Navigator.of(ctx).popUntil((Route<dynamic> r) => r.isFirst);
            } else {
              final snackBar = SnackBar(content: Text('Opps, something went wrong!'));
              // Find the Scaffold in the widget tree and use it to show a SnackBar.
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          false
        );
        return Stack(
          children: <Widget> [
            Material(
              type: MaterialType.transparency,
            ),
            dialog,
          ] 
        );
      }
    );
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    double initialBottom = 15.0;
    var dataLength = widget.decisions.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    List<Widget> w = [
      Positioned(
        top: 0,
        left: 0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ),
    ];
    w.addAll(widget.decisions.sublist(max(0, widget.decisions.length - 2), widget.decisions.length).map((Decision item) {
        if (widget.decisions.indexOf(item) ==
            dataLength - 1) {
          return cardDecision(
              item,
              bottom.value,
              right.value,
              0.0,
              backCardWidth + 30,
              rotate.value,
              rotate.value < -10 ? 0.1 : 0.0,
              context,
              dismissImg,
              flag,
              addImg,
              swipeRight,
              swipeLeft);
        } else {
          backCardPosition = backCardPosition;
          backCardWidth = backCardWidth;

          return cardDecisionDummy(
              item,
              bottom.value,
              right.value,
              0.0,
              backCardWidth,
              0.0,
              0.0,
              context);
        }
      }).toList());

    return Scaffold(
        backgroundColor: background,
        body: SafeArea(
            child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx < 0) {
                    // _slideController.forward();
                  }
                },
                child: new Container(
                  color: background,
                  alignment: Alignment.center,
                  child: dataLength > 0
                      ? new Stack(
                          alignment: AlignmentDirectional.center,
                          children: w
                        )
                      : new Text("Sorry we couldn't help you...",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 50.0)),
                ))));
  }
}
