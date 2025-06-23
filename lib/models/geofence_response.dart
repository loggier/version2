// To parse this JSON data, do
//
//     final geofenceResponse = geofenceResponseFromMap(jsonString);

import 'dart:convert';

class GeofenceResponse {
  Items items;
  int status;

  GeofenceResponse({
    required this.items,
    required this.status,
  });

  factory GeofenceResponse.fromJson(String str) =>
      GeofenceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeofenceResponse.fromMap(Map<String, dynamic> json) =>
      GeofenceResponse(
        items: Items.fromMap(json["items"]),
        status: 1,
      );

  Map<String, dynamic> toMap() => {
        "items": items.toMap(),
        "status": 1,
      };
}

class Items {
  List<Geofence>? geofences;

  Items({
    this.geofences,
  });

  factory Items.fromJson(String str) => Items.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Items.fromMap(Map<String, dynamic> json) => Items(
        geofences: json["geofences"] == null
            ? []
            : List<Geofence>.from(
                json["geofences"]!.map((x) => Geofence.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "geofences": geofences == null
            ? []
            : List<dynamic>.from(geofences!.map((x) => x.toMap())),
      };
}

class Geofence {
  int id;
  String name;
  String coordinates;
  String polygonColor;

  Geofence({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.polygonColor,
  });

  factory Geofence.fromJson(String str) => Geofence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geofence.fromMap(Map<String, dynamic> json) => Geofence(
        id: json["id"],
        name: json["name"],
        coordinates: json["coordinates"],
        polygonColor: json["polygon_color"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "coordinates": coordinates,
        "polygon_color": polygonColor,
      };
}
