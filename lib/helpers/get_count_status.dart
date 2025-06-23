import 'package:prosecat/models/device_response.dart';

//Devolver la cantidad de vehiculos en linea, en pausa y fuera de linea
Map<String, int> getCountStatus(List<DeviceResponse> devicesResponse) {
  Map<String, int> countStatus = {
    'green': 0, // online
    'yellow': 0, // pause
    'red': 0, // offline
  };

  for (var element in devicesResponse) {
    for (var item in element.items) {
      if (countStatus.containsKey(item.iconColor)) {
        countStatus[item.iconColor] = countStatus[item.iconColor]! + 1; // Incrementar el contador correspondiente
      }
    }
  }

  return countStatus;
}