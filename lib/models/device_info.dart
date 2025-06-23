import 'package:prosecat/generated/l10n.dart';

class DeviceInfo{
  final String time;
  final String distance;
  final String distanceUnitHour;
  final String stopDuration;
  final String imei;
  final String angle;
  final Map<String, dynamic> propertyNames;
  final String? driver;

  DeviceInfo(
    this.time, 
    this.distance, 
    this.distanceUnitHour, 
    this.stopDuration, 
    this.imei,
    this.angle,{
      this.driver
    }     
  )
      : propertyNames = {
          S.current.labelTiempo: time,
          S.current.labelDistancia: '$distance $distanceUnitHour',          
          S.current.labelDuracionDeParada: stopDuration,
          'IMEI': imei,
          S.current.labelAngulo: angle, 
          if (driver != null) S.current.labelConductor : driver,         
        };

  Map<String, dynamic> toMap() {
    return propertyNames;
  }
}