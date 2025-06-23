import 'package:prosecat/models/models.dart';

//Dividir y devolver los vehiculos por su estatus, 1.- Todos 2.- En linea y 3.- Fuera de liena
StatusDevice getStatusDevice(List<DeviceResponse> devicesResponse) {
  // Crear un mapa para almacenar las listas de vehículos encendidos y apagados por grupo
  Map<String, List<Item>> devicesOnline = {};
  Map<String, List<Item>> devicesOffline = {};
  Map<String, List<Item>> devices = {};

  // Recorrer los grupos de vehículos en el JSON
  for (var group in devicesResponse) {
    String groupTitle = group.title;
    List<Item> deviceItems = group.items;

    // Crear listas para almacenar los vehículos encendidos y apagados
    List<Item> devicesOn = [];
    List<Item> devicesOff = [];
    List<Item> devicesAll = [];

    // Filtrar los vehículos según los criterios
    for (var device in deviceItems) {
      if (device.online == 'offline') {
        devicesOff.add(device);
      } else {
        devicesOn.add(device);
      }
      devicesAll.add(device);
    }

    // Agregar las listas de vehículos encendidos y apagados al mapa por grupo
    devicesOnline[groupTitle] = devicesOn;
    devicesOffline[groupTitle] = devicesOff;
    devices[groupTitle] = devicesAll;
  }

  return StatusDevice(
      devicesOnline: devicesOnline,
      devicesOffline: devicesOffline,
      devices: devices);
}
