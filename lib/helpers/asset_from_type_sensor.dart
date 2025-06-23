//Asignar un icono local dependiendo el tipo de sensor y si se encuentra encendido o apagado
String assetFromTypeSensor(String typeSensor, {String value = ''}) {
  switch (typeSensor) {
    case 'ENCENDIDO':
      if(value == 'true'){
        return 'assets/icon/sensors/on/acc-on.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/acc-off.png';
      }
      return 'assets/icon/sensors/off/acc-off.png';      
    case 'KILOMETRAJE':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-dashboard-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-dashboard-50.png';
      }
      return 'assets/icon/sensors/on/icons8-dashboard-50.png';   
    case 'ALIMENTACION':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-car-battery-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-car-battery-50.png';
      }
      return 'assets/icon/sensors/on/icons8-car-battery-50.png';
    case 'BATERIA RESPALDO':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-car-battery-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-car-battery-50.png';
      }
      return 'assets/icon/sensors/on/icons8-car-battery-50.png';
    case 'GPS':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-satellite-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-satellite-50.png';
      }
      return 'assets/icon/sensors/on/icons8-satellite-50.png';
    case 'HORAS DE MOTOR':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-cruise-control-on-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/on/icons8-cruise-control-on-50.png';
      }
      return 'assets/icon/sensors/on/icons8-cruise-control-on-50.png';
    case 'MOVIMIENTO':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-steering-lock-warning-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-steering-lock-warning-50.png';
      }
      return 'assets/icon/sensors/off/icons8-steering-lock-warning-50.png'; 
    case 'VOLTAJE':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-automatic-gearbox-warning-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-automatic-gearbox-warning-50.png';
      }
      return 'assets/icon/sensors/on/icons8-automatic-gearbox-warning-50.png';
    case 'CORTE MOTOR':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-steering-lock-warning-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-steering-lock-warning-50.png';
      }
      return 'assets/icon/sensors/off/icons8-steering-lock-warning-50.png';   
    case 'GSM':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-gps-signal-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-gps-signal-50.png';
      }
      return 'assets/icon/sensors/on/icons8-gps-signal-50.png'; 
    case 'KILOMETROS':
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-dashboard-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/off/icons8-dashboard-50.png';
      }
      return 'assets/icon/sensors/on/icons8-dashboard-50.png'; 
    default:
      if(value == 'true'){
        return 'assets/icon/sensors/on/icons8-steering-wheel-50.png';
      }else if(value == 'false'){
        return 'assets/icon/sensors/on/icons8-steering-wheel-50.png';
      }
      return 'assets/icon/sensors/on/icons8-steering-wheel-50.png';  
  }
}