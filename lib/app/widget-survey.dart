import 'package:carousel_slider/carousel_slider.dart';
import 'package:feedme/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class SurveyWidget extends StatelessWidget {
  BuildContext context; 
  Function done;
  Function addDistance; 
  Function addCuisine;
  List<String> _cuisines;
  String _distance;

  SurveyWidget(this.context, this.done, this.addDistance, this.addCuisine, this._cuisines, this._distance);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        CarouselSlider(
          height: MediaQuery.of(context).size.height * 0.75,
          enableInfiniteScroll: false,
          autoPlay: false,
          items: <Widget> [
            DistanceQuestion(
              distance: _distance,
              callback: addDistance
            ),
            CuisineQuestion(
              cuisines: _cuisines,
              callback: addCuisine,
            ),
          ],
        ),
        FlatButton.icon(
          onPressed: () {
            done(context);
          },
          icon: Icon(Icons.check, color: primary),
          label: Text("All Done", style: TextStyle(color: primary),),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(50)
          ),
        )
      ],
    );   
  }
}

class DistanceQuestion extends StatefulWidget {
  final String distance;
  final Function callback;

  DistanceQuestion({this.distance, this.callback});

  @override
  DistanceQuestionState createState() => DistanceQuestionState(); 
}

class DistanceQuestionState extends State<DistanceQuestion> {
  String selectedButton;
  Map<String, IconData> methods = {
    "Automobile": MdiIcons.car,
    "Walking": MdiIcons.walk,
    "Transit": MdiIcons.bus,
    "Quick Walk": MdiIcons.run
  };

  @override
  void initState() {
    selectedButton = widget.distance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "How do you usually travel when you eat out?",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.only(top: 16.0)),
                  Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    spacing: 2.5,
                    children: methods.keys.map((i) {
                      return Builder(
                        builder: (BuildContext c) {
                          Color c, tc;
                          if (selectedButton == i) {
                            c = primary;
                            tc = Colors.white;
                          }
                          else {
                            c = Colors.transparent;
                            tc = Colors.black;
                          }
                          return FlatButton.icon(
                            onPressed: () {
                              setState(
                                () {
                                  widget.callback(i);
                                  selectedButton = i;
                                });
                            },
                            icon: Icon(methods[i], color: tc,),
                            label: Text(i, style: TextStyle(color: tc),),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            color: c,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              )
          )
        )
      )
    );
  }
}

class CuisineQuestion extends StatefulWidget {
  final List<String> cuisines;
  final Function callback;

  CuisineQuestion({this.cuisines, this.callback});

  @override
  CuisineQuestionState createState() => CuisineQuestionState(); 
}

class CuisineQuestionState extends State<CuisineQuestion> {
  List<String> selected = List<String>();

  List<String> getCuisines(String pattern) {
    List<String> output = List<String>();

    for (String c in cuisines.keys) {
      if (selected.contains(c)) {
        continue;
      }
      if (c.contains(pattern)) {
        output.add(c);
      }
    }
    return output;
  }

  @override
  void initState() {
    selected.addAll(widget.cuisines);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Tell us what kind of food you like!",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.only(top: 16.0)),
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.italic
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder()
                      )
                    ),
                    suggestionsCallback: (pattern) {
                      return getCuisines(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion)
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        selected.add(suggestion);
                        widget.callback(selected);
                      });
                    },
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    spacing: 2.5,
                    children: selected.map((i) {
                      return Builder(
                        builder: (BuildContext c) {
                          return ActionChip(
                            onPressed: () {
                              setState(() {
                                selected.remove(i);
                                widget.callback(selected);
                              });
                            },
                            avatar: Icon(Icons.close),
                            label: Text(i),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              )
          )
        )
      )
    );
  }
}