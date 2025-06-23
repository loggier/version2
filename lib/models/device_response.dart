// To parse this JSON data, do
//
//     final deviceResponse = deviceResponseFromMap(jsonString);

import 'dart:convert';

class DeviceResponse {
  DeviceResponse({
    required this.id,
    required this.title,
    required this.items,
  });

  int id;
  String title;
  List<Item> items;

  factory DeviceResponse.fromJson(String str) =>
      DeviceResponse.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory DeviceResponse.fromMap(Map<String, dynamic> json) => DeviceResponse(
        id: int.parse(json["id"].toString()),
        title: json["title"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Item {
  Item({
    required this.id,
    required this.name,
    this.driver,
    required this.time,
    required this.online,
    required this.lat,
    required this.lng,
    required this.course,
    required this.speed,
    required this.iconColor,
    required this.icon,
    this.sensors,
    required this.tail,
    required this.distanceUnitHour,
    required this.stopDuration,
    required this.totalDistance,
    required this.deviceData,
  });

  int id;
  String name;
  String? driver;
  String time;
  String online;
  double lat;
  double lng;
  int course;
  int speed;
  String iconColor;
  Icon icon;
  List<ItemSensor>? sensors;
  List<Tail> tail;
  String distanceUnitHour;
  String stopDuration;
  double totalDistance;
  DeviceData deviceData;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: int.parse(json["id"].toString()),
        name: json["name"].toString(),
        driver: json["driver"],
        time: json["time"],
        online: json["online"],
        lat:
            json["lat"]?.toDouble() != 0 ? json["lat"]?.toDouble() : -31.227249,
        lng: json["lng"]?.toDouble() != 0 ? json["lng"]?.toDouble() : 11.072400,
        course: json["course"] ?? 0,
        speed: json["speed"],
        iconColor: json["icon_color"],
        icon: Icon.fromMap(json["icon"]),
        sensors: json["sensors"] == null
            ? []
            : List<ItemSensor>.from(
                json["sensors"].map((x) => ItemSensor.fromMap(x))),
        tail: List<Tail>.from(json["tail"].map((x) => Tail.fromMap(x))),
        distanceUnitHour: json["distance_unit_hour"],
        stopDuration: json["stop_duration"],
        totalDistance: json["total_distance"]?.toDouble(),
        deviceData: DeviceData.fromMap(json["device_data"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "time": time,
        "lat": lat,
        "lng": lng,
        "course": course,
        "speed": speed,
        "icon_color": iconColor,
        "icon": icon.toMap(),
        "sensors": sensors == null
            ? []
            : List<dynamic>.from(sensors!.map((x) => x.toMap())),
        "tail": List<dynamic>.from(tail.map((x) => x.toMap())),
        "distance_unit_hour": distanceUnitHour,
        "stop_duration": stopDuration,
        "total_distance": totalDistance,
        "device_data": deviceData.toMap(),
      };
}

class DeviceData {
  DeviceData({
    required this.id,
    required this.name,
    required this.imei,
    this.expirationDate,
    required this.tailColor,
    required this.idMdvr,
  });

  int id;
  String name;
  String imei;
  dynamic expirationDate;
  String tailColor;
  List<dynamic> idMdvr;

  factory DeviceData.fromJson(String str) =>
      DeviceData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeviceData.fromMap(Map<String, dynamic> json) => DeviceData(
        id: json["id"],
        name: json["name"],
        imei: json["imei"],
        expirationDate: json["expiration_date"],
        tailColor: json["tail_color"],
        idMdvr: json["idMdvr"] != null
            ? List<dynamic>.from(json["idMdvr"])
            : [], // Si "idMdvr" no existe, asigna una lista vacía
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "imei": imei,
        "expiration_date": expirationDate,
        "tail_color": tailColor,
        "idMdvr": idMdvr,
      };
}

class Icon {
  Icon({
    required this.id,
    required this.type,
    required this.path,
  });

  int id;
  String type;
  String path;

  factory Icon.fromJson(String str) => Icon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Icon.fromMap(Map<String, dynamic> json) => Icon(
        id: json["id"],
        type: json["type"],
        path: json["path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "path": path,
      };
}

class ItemSensor {
  ItemSensor({
    required this.id,
    required this.type,
    required this.name,
    required this.value,
    required this.val,
  });

  int id;
  String type;
  String name;
  String value;
  dynamic val;

  factory ItemSensor.fromJson(String str) =>
      ItemSensor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemSensor.fromMap(Map<String, dynamic> json) => ItemSensor(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        value: json["value"],
        val: json["val"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "value": value,
        "val": val,
      };
}

class Tail {
  Tail({
    required this.lat,
    required this.lng,
  });

  String lat;
  String lng;

  factory Tail.fromJson(String str) => Tail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tail.fromMap(Map<String, dynamic> json) => Tail(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}
