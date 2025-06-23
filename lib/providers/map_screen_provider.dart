import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/preferences/preference.dart';

class MapScreenProvider extends ChangeNotifier{
  List<MapType> listMaps = [MapType.normal, MapType.hybrid, MapType.satellite];

  //Mapa principal 
  MapType get getMapType => listMaps[Preferences.getMapType];

  //Cambiar el tipo de mapa
  setMapType(){
    if (Preferences.getMapType == 2) {
      Preferences.setMapType = 0;
      notifyListeners();
      return;
    }
    Preferences.setMapType = Preferences.getMapType + 1;        
    notifyListeners();
  }


  //Mapa en deviceOverview
  int count = 0;  
  List<MapType> get getMapTypeOverview => listMaps;
  handlerMapTypeInOverview(){
    if (count == 2) {
      count = 0;
      notifyListeners();
      return;
    }
    count++;
    notifyListeners();
  }
}
