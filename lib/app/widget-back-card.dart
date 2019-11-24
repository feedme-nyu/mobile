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
    bottom: 50.0 + bottom,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    //left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Card(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.grey, width: 1.0)
      ),
      child: new Container(
        alignment: Alignment.center,
        width: screenSize.width / 1.2 + cardWidth,
        height: screenSize.height / 1.4,
        decoration: new BoxDecoration(
          color: new Color.fromRGBO(225, 225, 225, 1.0),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              width: screenSize.width / 1.2 + cardWidth,
              height: screenSize.height / 2.0,
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
                height: screenSize.height / 1.7 - screenSize.height / 2.0,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Padding (
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: img.recommendation.categories.map((c) {
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
                    Expanded (
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(right: 24),
                            child: OutlineButton(
                              padding: new EdgeInsets.all(0.0),
                              onPressed: () {},
                              borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100), width: 2.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "No thanks...",
                                  style: TextStyle(color: Color.fromARGB(255, 100, 100, 100), fontSize: 16.0, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          OutlineButton(
                            padding: EdgeInsets.all(0.0),
                            onPressed: () {},
                            borderSide: BorderSide(color: primary, width: 2.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Looks good!",
                                style: TextStyle(color: primary, fontSize: 16.0, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    ),
  );
}