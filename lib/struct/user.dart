import 'package:firebase_auth/firebase_auth.dart';
import 'package:feedme/struct/preference.dart';

class User {
  final FirebaseUser identity;  
  List<Preference> prefs = List<Preference>();

  User(this.identity);

  void addPreference(Preference newPref) {
    prefs.add(newPref);
  }
}