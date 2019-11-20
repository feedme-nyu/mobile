import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:feedme/app/consts.dart';
import 'package:feedme/struct/decision.dart';

class DecisionPage extends StatefulWidget {
  final List<Decision> decisions;
  
  DecisionPage({Key key, this.decisions}) : super(key: key);

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


  Widget decisionCard(Decision decision, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          Container(
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.width * 0.80,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.70,
                height: MediaQuery.of(context).size.width * 0.70,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(decision.recommendation.imageUrl),
                  )
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
            child: Text(decision.recommendation.name, style: TextStyle(fontSize: 24.0),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  if (await canLaunch(decision.recommendation.mapsUrl)) {
                    await launch(decision.recommendation.mapsUrl);
                  }
                  else {
                    Fluttertoast.showToast(
                      msg: "Something went wrong...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 2,
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                  }
                },
                icon: Icon(Icons.map), 
              ),
              Expanded(
                child: Text(decision.recommendation.address, textAlign: TextAlign.left,),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx < 0) {
              // _slideController.forward();
            }
          },
          child: Stack(
            children: <Widget> [
              CarouselSlider(
                height: MediaQuery.of(context).size.height,
                enableInfiniteScroll: false,
                scrollDirection: Axis.vertical,
                items: widget.decisions.map((decision) {
                  return Builder(
                    builder: (BuildContext context) {
                      return decisionCard(decision, context);
                    },
                  );
                }).toList(),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Padding (
                  padding: EdgeInsets.all(16.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
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
