import 'package:feedme/app/consts.dart';
import 'package:flutter/material.dart';

Widget getStarted (BuildContext context, int state, List<Widget> children) {  
  return Expanded(
    child: ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: state,
      itemBuilder: (_context, index) {
        return children[index];
      },
    )
  );
}


Widget startCard(Function yes, Function no) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
          child: Text(
            "Before we can feed you, you need to feed our match making algorithm with some data.",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(),
                child: FlatButton(
                  onPressed: () { 
                    no();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "Learn More", 
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0
                      ),
                    ),
                  ), 
                ),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: OutlineButton(
                  onPressed: () {
                    yes();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  borderSide: BorderSide(color: primary),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "Let's go!", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primary,
                        fontSize: 14.0,
                      ),
                    ),
                  ), 
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget learnMore () {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 0.0),
          child: Text(
            "Feed Me Data Collection",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 24.0),
          child: Text(
            disclaimer,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ],
    ),
  );
}