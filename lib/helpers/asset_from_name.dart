import 'package:prosecat/generated/l10n.dart';

String assetFromName(String name){
  if (name == S.current.labelTiempo) {
    return 'assets/icon/sensors/info/clock.svg';
  }else if(name.toLowerCase() == S.current.labelDistancia.toLowerCase()){
    return 'assets/icon/sensors/info/route.svg';
    
  }else if(name.toLowerCase() == S.current.labelDuracionDeParada.toLowerCase()){
    return 'assets/icon/sensors/info/chronometer.svg';    
  }else if(name.toLowerCase() == S.current.labelAngulo.toLowerCase()){
    return 'assets/icon/sensors/info/angle.svg';    
  }else if(name.toLowerCase() == 'imei'){
    return 'assets/images/imei.svg';    
  }else if(name.toLowerCase() == S.current.labelConductor.toLowerCase()){
    return 'assets/icon/sensors/info/user.svg';    
  }
  else{
    return 'assets/icon/sensors/info/terrestrial.svg';
  }

}