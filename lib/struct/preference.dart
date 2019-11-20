enum PreferenceCategory {
  allergy,
  restriction,
  diet,
  cuisine,
}

class Preference {
  final String name;
  final PreferenceCategory category;

  Preference(this.name, this.category);
}