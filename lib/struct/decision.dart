import 'package:feedme/struct/restaurant.dart';

class Decision {
  final Restaurant recommendation;
  final double score;

  Decision({this.score, this.recommendation});
}