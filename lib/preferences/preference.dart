import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static late SharedPreferences _prefs;

  static String _idioma = '';
  static int _mapType = 0;
  static bool _theme = false;//false == Theme.light & true == Theme.dark

  static Future init()async{
    _prefs = await SharedPreferences.getInstance();
  }

  static String get idioma {
    return _prefs.getString('idioma') ?? _idioma;
  }

  static int get getMapType {
    return _prefs.getInt('maptype') ?? _mapType;    
  }
  
  static bool get getAppTheme{
    return _prefs.getBool('appTheme') ?? _theme;
  }

  static set idioma(String value){
    _idioma = value;
    _prefs.setString('idioma', value);
  }

  static set setMapType(int mapType){
    _mapType = mapType;
    _prefs.setInt('maptype', mapType);
  }

  static set setAppTheme(bool val){
    _theme = val;
    _prefs.setBool('appTheme', _theme);
  }

}