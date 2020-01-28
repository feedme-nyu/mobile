// This class represents a restaurant choice for the user
import 'dart:convert';

import 'package:crypto/crypto.dart';

class Restaurant {
  String address;
  String name;
  final String image;
  final double distance;
  final String id;
  final int price;
  final double rating;
  final int ratingN;
  final int estimated;
  final List<String> categories;
  String hash;


  Restaurant({this.estimated, this.categories, this.distance, this.id, this.price, this.rating, this.ratingN, this.address, this.name, this.image});

  factory Restaurant.fromJson(Map<String, dynamic> json) {    
    Restaurant r = Restaurant(
      address: List<String>.from(json["address"]).join(","),
      name: json["name"],
      distance: json["distance"],
      rating: json["rating"],
      ratingN: json["rating_n"],
      image: json["photo"],
      id: json["place_id"],
      price: json["price"],
      estimated: json["time"],
      categories: List<String>.from(json["categories"])
    );
    var bytes = utf8.encode(r.name.toLowerCase() + List<String>.from(json["address"])[0].toLowerCase());
    Digest digest = md5.convert(bytes);
    r.hash = digest.toString();
    print(r.name[0]);
    if (r.name[0] == "b" && (r.name[1] == "\'" || r.name[1] == "\"")) {
      r.name = r.name.substring(2, r.name.length - 1);
    }
    if (r.address[0] == "b" && (r.address[1] == "\'" || r.address[1] == "\"")) {
      r.address = r.address.substring(2, r.address.length - 1);
    }
    return r;
  }
}