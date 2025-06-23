import 'dart:convert';

class Tour {
    final Items? items;
    final int? status;

    Tour({
        this.items,
        this.status,
    });

    factory Tour.fromMap(Map<String, dynamic> json) => Tour(
        items: json["items"] == null ? null : Items.fromMap(json["items"]),
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "items": items?.toMap(),
        "status": status,
    };
}

class Items {
    final List<MapIcon>? mapIcons;

    Items({
        this.mapIcons,
    });

    factory Items.fromMap(Map<String, dynamic> json) => Items(
        mapIcons: json["mapIcons"] == null ? [] : List<MapIcon>.from(json["mapIcons"]!.map((x) => MapIcon.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "mapIcons": mapIcons == null ? [] : List<dynamic>.from(mapIcons!.map((x) => x.toMap())),
    };
}

class MapIcon {
    final int? id;
    final int? userId;
    final int? mapIconId;
    final int? active;
    final String? name;
    final String? description;
    final Map<String, dynamic>? coordinates;
    final String? createdAt;
    final String? updatedAt;
    final MapIconClass? mapIcon;

    MapIcon({
        this.id,
        this.userId,
        this.mapIconId,
        this.active,
        this.name,
        this.description,
        this.coordinates,
        this.createdAt,
        this.updatedAt,
        this.mapIcon,
    });

    factory MapIcon.fromMap(Map<String, dynamic> json) => MapIcon(
        id: json["id"],
        userId: json["user_id"],
        mapIconId: json["map_icon_id"],
        active: json["active"],
        name: json["name"],
        description: json["description"],
        coordinates: jsonDecode(json["coordinates"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        mapIcon: json["map_icon"] == null ? null : MapIconClass.fromMap(json["map_icon"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "map_icon_id": mapIconId,
        "active": active,
        "name": name,
        "description": description,
        "coordinates": coordinates,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "map_icon": mapIcon?.toMap(),
    };
}

class MapIconClass {
    final int? id;
    final int? width;
    final int? height;
    final String? path;
    final String? url;

    MapIconClass({
        this.id,
        this.width,
        this.height,
        this.path,
        this.url,
    });

    factory MapIconClass.fromMap(Map<String, dynamic> json) => MapIconClass(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        path: json["path"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "width": width,
        "height": height,
        "path": path,
        "url": url,
    };
}
