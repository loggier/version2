import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place with ClusterItem {
  @override
  LatLng location;
  final String id;
  final String? path;
  final String? asset;
  final double rotation;
  final String name;
  final int speed;
  final String distanceUnitHour;
  final double imageRotate;
  final String iconColor;
  final String time;

  Place(this.name, this.speed, this.distanceUnitHour, this.imageRotate, this.iconColor, this.time, {required this.location, required this.id, this.path, required this.rotation, this.asset});

  LatLng get position => location;
}

