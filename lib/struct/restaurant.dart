// This class represents a restaurant choice for the user
import 'dart:convert';

import 'package:crypto/crypto.dart';

class Restaurant {
  final String address;
  final String name;
  final double score;
  final String image;
  final double distance;
  final String id;
  final int price;
  final double rating;
  final int ratingN;
  String hash;

  Restaurant({this.distance, this.id, this.price, this.rating, this.ratingN, this.address, this.name, this.score, this.image});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    Restaurant r = Restaurant(
      address: List<String>.from(json["address"]).join(" "),
      name: json["name"],
      distance: json["distance"],
      rating: json["rating"],
      ratingN: json["rating_n"],
      image: json["photo"],
      score: json["score"],
      id: json["place_id"],
      price: json["price"]
    );
    var bytes = utf8.encode(r.name.toLowerCase() + r.address.toLowerCase());
    Digest digest = md5.convert(bytes);
    r.hash = digest.toString();
  }
}