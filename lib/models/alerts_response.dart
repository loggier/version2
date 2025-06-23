import 'dart:convert';

class AlertResponse {
    int status;
    Items items;

    AlertResponse({
        required this.status,
        required this.items,
    });

    factory AlertResponse.fromJson(String str) => AlertResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AlertResponse.fromMap(Map<String, dynamic> json) => AlertResponse(
        status: json["status"],
        items: Items.fromMap(json["items"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "items": items.toMap(),
    };
}

class Items {
   
    List<Datum> data;
    int lastPage;

    Items({        
        required this.data,
        required this.lastPage,        
    });

    factory Items.fromJson(String str) => Items.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Items.fromMap(Map<String, dynamic> json) => Items(
       
      data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      lastPage: json["last_page"] ?? 1
    );

    Map<String, dynamic> toMap() => {
        
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        
    };
}

class Datum {
    int id;
    int deviceId;
    String message;
    String? address;
    double latitude;
    double longitude;
    double? altitude;
    int speed;
    String time;
    String deviceName;
    String name;

    Datum({
        required this.id,
        required this.deviceId,
        required this.message,
        this.address,
        required this.latitude,
        required this.longitude,
        this.altitude,
        required this.speed,
        required this.time,
        required this.deviceName,
        required this.name,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        deviceId: int.parse(json["device_id"].toString()),
        message: json["message"],
        address: json["address"],
        latitude: double.parse(json["latitude"].toString()),
        longitude: double.parse(json["longitude"].toString()),
        altitude: json["altitude"] != null ? double.parse(json["altitude"].toString()) : 0,
        speed: json["speed"],
        time: json["time"],
        deviceName: json["device_name"],
        name: json["name"].toString(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "device_id": deviceId,
        "message": message,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "altitude": altitude,
        "speed": speed,
        "time": time,
        "device_name": deviceName,
        "name": name,
    };
}

