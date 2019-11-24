import 'dart:convert';

import 'package:feedme/struct/decision.dart';
import 'package:flutter/material.dart';

Widget DecisionDialog(
  Decision decision,
  Function onDismiss,
  Function onChoose,
  bool end,
  ) {
  return AnimatedPositioned(
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    duration: Duration(seconds: 1),
    child: Card(
        color: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.grey, width: 1.0)
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (!end) ? Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Have a good meal!")
              ) : null,
              Container (
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(Base64Decoder().convert(decision.recommendation.image)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                child: Text(decision.recommendation.name, style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,)
              ),
              Padding (
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: decision.recommendation.categories.map((c) {
                    return Padding(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Chip (
                        backgroundColor: Color.fromARGB(255, 200, 200, 200),
                        label: Text(c),
                      )
                    );
                  }).toList()
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.map
                    ),
                  ),
                  Expanded (
                    child: Text(
                      decision.recommendation.address,
                      style: TextStyle(fontSize: 16.0), 
                      textAlign: TextAlign.left,
                    )
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Row(
                children: <Widget>[
                  Padding (
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.directions
                    ),
                  ),
                  Expanded (
                    child: Text(
                      (decision.recommendation.distance / 1609.34).toStringAsFixed(2) + " miles away",
                      style: TextStyle(fontSize: 16.0), 
                      textAlign: TextAlign.left,
                    )
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Row(
                children: <Widget>[
                  Padding (
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.timer
                    ),
                  ),
                  Expanded (
                    child: Text(
                      "Expect a " + decision.recommendation.estimated.toString() + " minute wait",
                      style: TextStyle(fontSize: 16.0), 
                      textAlign: TextAlign.left,
                    )
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {
                          onDismiss();
                        },
                        splashColor: Color.fromARGB(255, 190, 190, 190),
                        color: Color.fromARGB(255, 200, 190, 190),
                        focusColor: Color.fromARGB(255, 100, 100, 100),
                        child: Text("I'm not feeling it.", style: TextStyle(color: Color.fromARGB(255, 100, 100, 100),)),
                      ),
                      Padding(padding: EdgeInsets.only(right: 8.0),),
                      IconButton(
                        onPressed: () {
                          onChoose();
                        },
                        icon: Icon(Icons.check),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
    ),
  );
}