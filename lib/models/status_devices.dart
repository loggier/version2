import 'package:prosecat/models/models.dart';

class StatusDevice {
  Map<String, List<Item>> devicesOnline;
  Map<String, List<Item>> devicesOffline;
  Map<String, List<Item>> devices;

  StatusDevice({
    required this.devicesOnline,
    required this.devicesOffline,
    required this.devices,
  });
}