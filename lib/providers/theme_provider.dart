import 'package:flutter/material.dart';
import 'package:prosecat/preferences/preference.dart';

//Cambiar y devolver tipos de temas, oscuro o claro
class ThemeAppProvider extends ChangeNotifier{
  setTheme(){
    Preferences.setAppTheme = !Preferences.getAppTheme;
    notifyListeners();
  }
  getTheme(){
    return Preferences.getAppTheme;
  }
}
