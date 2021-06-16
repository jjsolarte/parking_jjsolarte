// To parse this JSON data, do
//
//     final ciudad = ciudadFromJson(jsonString);

import 'dart:convert';

List<Ciudad> ciudadFromJson(String str) => List<Ciudad>.from(json.decode(str).map((x) => Ciudad.fromJson(x)));

String ciudadToJson(List<Ciudad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ciudad {
  Ciudad({
    this.title,
    this.locationType,
    this.woeid,
    this.lattLong,
  });

  String title;
  LocationType locationType;
  int woeid;
  String lattLong;

  factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
    title: json["title"],
    locationType: locationTypeValues.map[json["location_type"]],
    woeid: json["woeid"],
    lattLong: json["latt_long"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "location_type": locationTypeValues.reverse[locationType],
    "woeid": woeid,
    "latt_long": lattLong,
  };
}

enum LocationType { CITY }

final locationTypeValues = EnumValues({
  "City": LocationType.CITY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
