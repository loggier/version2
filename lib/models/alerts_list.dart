// To parse this JSON data, do
//
//     final alerts = alertsFromMap(jsonString);

import 'dart:convert';

class Alerts {
  int status;
  Items items;

  Alerts({
    required this.status,
    required this.items,
  });

  factory Alerts.fromJson(String str) => Alerts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alerts.fromMap(Map<String, dynamic> json) => Alerts(
        status: json["status"],
        items: Items.fromMap(json["items"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "items": items.toMap(),
      };
}

class Items {
  List<Alert> alerts;

  Items({
    required this.alerts,
  });

  factory Items.fromJson(String str) => Items.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Items.fromMap(Map<String, dynamic> json) => Items(
        alerts: List<Alert>.from(json["alerts"].map((x) => Alert.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "alerts": List<dynamic>.from(alerts.map((x) => x.toMap())),
      };
}

class Alert {
  int id;
  int userId;
  int active;
  String name;
  String type;

  Alert({
    required this.id,
    required this.userId,
    required this.active,
    required this.name,
    required this.type,
  });

  factory Alert.fromJson(String str) => Alert.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alert.fromMap(Map<String, dynamic> json) => Alert(
        id: json["id"],
        userId: int.parse(json["user_id"].toString()),
        active: int.parse(json["active"].toString()),
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "active": active,
        "name": name,
        "type": type,
      };
}
