import 'package:flutter/material.dart';

class GlobalVariables {
  static final GlobalVariables _instance = GlobalVariables._internal();

  // Variables globales
  String appName = "V2 Cliente GPS";
  String fotterName = "V2 Cliente GPS";
  String apiUrl = "version2.gpsplataforma.net";
  String urlLogin = "/api/login";
  String urlGetDevices = '/api/get_devices';
  String urlCheckVideo = '/api/check_video';
  String urlGeoAddres = '/api/geo_address';
  String urlGetDeviceCommands = '/api/get_device_commands';
  String urlShareDevice = '/api/sharing';
  String urlSendGprsCommand = '/api/send_gprs_command';
  String urlSendSmsCommand = '/api/send_sms_command';
  String urlPostFcmToken = '/api/fcm_token';
  String urlGetEvents = '/api/get_events';
  String urlChangePassword = '/api/change_password';
  String urlGetHistory = '/api/get_history';
  String urlGetGeofences = '/api/get_geofences';
  String urlGetUserData = '/api/get_user_data';
  String urlGetUserLogo = '/api/get_logo';
  String urlAlerts = '/api/get_alerts';
  String urlChangeActiveAlert = '/api/change_active_alert';
  String urlGetUserMapIcons = '/api/get_user_map_icons';
  String urlGetReports = '/api/get_reports';
  String urlGenerateReport = '/api/generate_report';
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory GlobalVariables() {
    return _instance;
  }

  GlobalVariables._internal();
}
