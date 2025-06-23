import 'dart:convert';

class DeviceDetails {
  List<DeviceDetailsItem>? items;
  List<Sensor>? sensor;
  Device device;
  String distanceSum;
  String topSpeed;
  String moveDuration;
  String stopDuration;

  DeviceDetails({
    this.items,
    this.sensor,
    required this.device,
    required this.distanceSum,
    required this.topSpeed,
    required this.moveDuration,
    required this.stopDuration,
  });

  factory DeviceDetails.fromJson(String str) =>
      DeviceDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeviceDetails.fromMap(Map<String, dynamic> json) => DeviceDetails(
        items: json["items"] == null
            ? []
            : List<DeviceDetailsItem>.from(
                json["items"].map((x) => DeviceDetailsItem.fromMap(x))),
        sensor: json["sensors"] == null
            ? []
            : List<Sensor>.from(json["sensors"].map((x) => Sensor.fromMap(x))),
        device: Device.fromMap(json["device"]),
        distanceSum: json["distance_sum"],
        topSpeed: json["top_speed"],
        moveDuration: json["move_duration"],
        stopDuration: json["stop_duration"],
      );

  Map<String, dynamic> toMap() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
        "device": device.toMap(),
        "distance_sum": distanceSum,
        "top_speed": topSpeed,
        "move_duration": moveDuration,
        "stop_duration": stopDuration,
      };
}

class Sensor {
  String id;
  String? name;
  String? sufix;

  Sensor({
    required this.id,
    required this.name,
    required this.sufix,
  });

  factory Sensor.fromJson(String str) => Sensor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sensor.fromMap(Map<String, dynamic> json) => Sensor(
        id: json["id"],
        name: json["name"],
        sufix: json["sufix"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "sufix": sufix,
      };
}

class Device {
  String name;
  Device({
    required this.name,
  });

  factory Device.fromJson(String str) => Device.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class DeviceSensor {
  String name;

  DeviceSensor({
    required this.name,
  });

  factory DeviceSensor.fromJson(String str) =>
      DeviceSensor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeviceSensor.fromMap(Map<String, dynamic> json) => DeviceSensor(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class DeviceDetailsItem {
  int status;
  String? time;
  String show;
  String? left;
  String rawTime;
  String? driver;
  double distance;
  List<ItemItem> items;
  String? message;

  DeviceDetailsItem(
      {required this.status,
      this.time,
      this.left,
      required this.show,
      required this.rawTime,
      required this.distance,
      required this.items,
      this.driver,
      this.message});

  factory DeviceDetailsItem.fromJson(String str) =>
      DeviceDetailsItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeviceDetailsItem.fromMap(Map<String, dynamic> json) =>
      DeviceDetailsItem(
        status: json["status"],
        time: json["time"],
        left: json["left"],
        show: json["show"],
        rawTime: json["raw_time"],
        driver: json["driver"],
        distance: double.parse(json["distance"].toString()),
        items:
            List<ItemItem>.from(json["items"].map((x) => ItemItem.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "time": time,
        "left": left,
        "show": show,
        "raw_time": rawTime,
        "driver": driver,
        "distance": distance,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "message": message,
      };
}

class ItemItem {
  int? id;
  int? deviceId;
  String rawTime;
  int speed;
  double lat;
  double lng;
  double? altitude;
  double? course;

  ItemItem(
      {this.id,
      this.deviceId,
      required this.rawTime,
      required this.speed,
      required this.lat,
      required this.lng,
      this.altitude,
      this.course});

  factory ItemItem.fromJson(String str) => ItemItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemItem.fromMap(Map<String, dynamic> json) => ItemItem(
        id: json["id"],
        deviceId: json["device_id"] != null
            ? int.parse(json["device_id"].toString())
            : 0,
        rawTime: json["raw_time"],
        speed: json["speed"],
        lat: double.parse(json["lat"].toString()),
        lng: double.parse(json["lng"].toString()),
        altitude: (json.containsKey("altitude") && json["altitude"] != null)
            ? double.parse(json["altitude"].toString())
            : 0.0,
        course: double.parse(
            json["course"] != null ? json["course"].toString() : '0.0'),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "device_id": deviceId,
        "raw_time": rawTime,
        "speed": speed,
        "lat": lat,
        "lng": lng,
        "altitude": altitude,
        "course": course
      };
}
