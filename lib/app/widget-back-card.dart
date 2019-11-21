import 'dart:convert';

import 'package:feedme/struct/decision.dart';
import 'package:flutter/material.dart';

import 'consts.dart';

Positioned cardDecisionDummy(
    Decision img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  // Size screenSize=(500.0,200.0);
  // print("dummyCard");
  return new Positioned(
    bottom: 100.0 + bottom,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    //left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: new Container(
        alignment: Alignment.center,
        width: screenSize.width / 1.2 + cardWidth,
        height: screenSize.height / 1.7,
        decoration: new BoxDecoration(
          color: new Color.fromRGBO(240, 240, 240, 1.0),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              width: screenSize.width / 1.2 + cardWidth,
              height: screenSize.height / 2.2,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(8.0),
                    topRight: new Radius.circular(8.0)),
                image: DecorationImage(
                  image: MemoryImage(Base64Decoder().convert(img.recommendation.image)),
                  fit: BoxFit.cover
                ),
              ),
            ),
            new Container(
                width: screenSize.width / 1.2 + cardWidth,
                height: screenSize.height / 1.7 - screenSize.height / 2.2,
                alignment: Alignment.center,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: OutlineButton(
                        padding: new EdgeInsets.all(0.0),
                        onPressed: () {
                        },
                        borderSide: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: new Text(
                              "No thanks...",
                              style: new TextStyle(color: Colors.grey, fontSize: 16.0),
                            ),
                          ),
                        ),
                    ),
                    OutlineButton(
                        padding: new EdgeInsets.all(0.0),
                        onPressed: () {
                        },
                        borderSide: BorderSide(color: primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Looks good!",
                            style: new TextStyle(color: primary, fontSize: 16.0),
                          ),
                        ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ),
  );
}