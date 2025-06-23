import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/models/alerts_list.dart';
import 'package:prosecat/models/alerts_response.dart';
import 'package:prosecat/models/api_response.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/models/tour.dart';
import 'package:prosecat/services/auth_services.dart';
import 'package:prosecat/system/global.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DeviceProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final globalVariables = GlobalVariables();
  final String _apiUrl = GlobalVariables().apiUrl;
  final AuthService _authService = AuthService();

  GlobalKey<FormState> recordKey = GlobalKey();
  String userEmail = '';

  DeviceDetails? deviceDetails;
  UserData? userData;

  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();

  get getDate => selectedDate;
  get getTime => selectedTime;

  set setDate(DateTime value) {
    selectedDate = value;
    notifyListeners();
  }

  set setTime(DateTime value) {
    selectedTime = value;
    notifyListeners();
  }

  //Pantalla de historial
  DateTime dateFrom = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    0, // Hora
    0, // Minuto
    0, // Segundo
  );
  DateTime dateTo = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    23, // Hora
    59, // Minuto
    59, // Segundo
  );
  String? deviceSelected;
  String daySelected = '3';
  bool isSetToRoad = false;
  bool isLoading = false;

  get getDeviceSelected => deviceSelected;
  get getDaySelected => daySelected;
  bool get getIsSetToRoad => isSetToRoad;
  bool get getIsLoading => isLoading;
  getDateFrom() {
    return DateHelper.dateTimeToString(dateFrom);
  }

  getHourFrom() {
    return DateHelper.timeToString(dateFrom);
  }

  getDateOnlyFrom() {
    return DateHelper.dateToString(dateFrom);
  }

  getDateTo() {
    return DateHelper.dateTimeToString(dateTo);
  }

  getDateOnlyTo() {
    return DateHelper.dateToString(dateTo);
  }

  getHourTo() {
    return DateHelper.timeToString(dateTo);
  }

  set setDaySelected(String value) {
    daySelected = value;
    DateTime? date;
    switch (value) {
      case '0':
        date = DateTime.now().subtract(const Duration(days: 7));
        break;
      case '1':
        date = DateTime.now().subtract(const Duration(days: 3));
        break;
      case '2':
        date = DateTime.now().subtract(const Duration(days: 1));
        break;
      case '3':
        date = DateTime.now();
        break;
      default:
        date = null;
    }
    if (date != null) {
      setDateFrom = date;
      setDateTo = DateTime.now();
    }
    notifyListeners();
  }

  set setDateFrom(DateTime value) {
    dateFrom = value;
    notifyListeners();
  }

  set setDateTo(DateTime value) {
    dateTo = value;
    notifyListeners();
  }

  set setDeviceSelected(String id) {
    deviceSelected = id;
    notifyListeners();
  }

  set setIsSetToRoad(String value) {
    if (value == '0') {
      isSetToRoad = false;
    } else {
      isSetToRoad = true;
    }
    notifyListeners();
  }

  set setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  bool isValidForm() {
    return recordKey.currentState?.validate() ?? false;
  }

  AlertResponse? alertsReponse;

  List<DeviceResponse> devicesResponse = [];
  String address = '';

  final StreamController<List<DeviceResponse>> _deviceStreamController =
      StreamController<List<DeviceResponse>>.broadcast();
  Stream<List<DeviceResponse>> get deviceStream =>
      _deviceStreamController.stream;

  bool _isPaused = false;

  void pause() {
    if (!_isPaused) {
      _isPaused = true;
    }
  }

  void resume() {
    if (_isPaused) {
      _isPaused = false;
      notifyListeners();
    }
  }

  //Obtener todos los dispositivos
  Future<List<DeviceResponse>> getAllDevice({bool reload = false}) async {
    if (!_isPaused || reload) {
      userEmail = await _authService.readEmail();
      final userApiHash = await _authService.readToken();
      final url = Uri.https(_apiUrl, globalVariables.urlGetDevices,
          {'lang': 'en', 'user_api_hash': userApiHash});
      final response = await http.get(url);

      final List<dynamic> jsonData = json.decode(response.body);

      devicesResponse =
          jsonData.map((jsonItem) => DeviceResponse.fromMap(jsonItem)).toList();

      devicesResponse.sort((a, b) => a.title.compareTo(b.title));

      _deviceStreamController.add(devicesResponse);

      notifyListeners();

      reload = false;
      return devicesResponse;
    }

    return devicesResponse;
  }

  //Liberar recursos
  close() {
    devicesResponse.clear();
    notifyListeners();
  }

  //Obtener dirección, a partir de lat y long
  Future<String> getGeocoder(lat, lng) async {
    final userApiHash = await _authService.readToken();

    final headers = {
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };

    final url = Uri.https(_apiUrl, globalVariables.urlGeoAddres, {
      'lat': lat.toString(),
      'lon': lng.toString(),
      'user_api_hash': userApiHash
    });

    final response = await http.get(url, headers: headers);

    address = response.body;

    return response.body;
  }

  //Obtener comandos de cada dispositivo
  Future<List<CommandsResponse>> getCommandDevices(dynamic id) async {
    final userApiHash = await _authService.readToken();

    final url = Uri.https(_apiUrl, globalVariables.urlGetDeviceCommands, {
      'user_api_hash': userApiHash,
      'device_id': [id.toString()]
    });

    final response = await http.get(url);

    final List<dynamic> jsonData = json.decode(response.body);

    final List<CommandsResponse> commandsResponseList = jsonData
        .map((jsonItem) => CommandsResponse.fromMap(jsonItem))
        .where((element) => element.type != 'custom')
        .toList();

    return commandsResponseList;
  }

  //Obtener Disponibilidad de camara
  Future<Map<String, dynamic>> checkCameraAvailability(dynamic id) async {
    final userApiHash = await _authService.readToken();

    final url = Uri.https(_apiUrl, globalVariables.urlCheckVideo, {
      'user_api_hash': userApiHash,
      'device_id': [id.toString()]
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parsear la respuesta como un Map<String, dynamic>
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception("Error en la solicitud: ${response.statusCode}");
    }
  }

  //Enviar comando a la bd
  postCommandDevices(
      String type, String id, String commandType, String defaultData) async {
    final userApiHash = await _authService.readToken();

    final String urlApi;
    if (type == 'GPRS') {
      urlApi = globalVariables.urlSendGprsCommand;
    } else {
      urlApi = globalVariables.urlSendSmsCommand;
    }

    final url = Uri.https(_apiUrl, urlApi, {
      'user_api_hash': userApiHash,
      'type': commandType,
      'device_id': id,
      'data': defaultData,
      'devices[]': id
    });

    await http.get(url);
  }

  //Obtener direccion url de un vehiculo a partir de su id, fecha y hora
  shareDevice(int id) async {
    final userApiHash = await _authService.readToken();

    final date = DateFormat('yyyy-MM-dd').format(getDate);
    final time = DateFormat.Hm().format(getTime);

    final url = Uri.https(_apiUrl, globalVariables.urlShareDevice, {
      'user_api_hash': userApiHash,
      'expiration_by': 'date',
      'expiration_date': '$date $time',
      'devices[]': id.toString(),
      'duration': '1',
      'delete_after_expiration': '1',
      'send_sms': '0',
      'send_email': '0',
      'name': 'APP',
      'active': '1'
    });

    final response = await http.post(url);

    final jsonData = json.decode(response.body);

    String hash = jsonData['data']['hash'];

    final link = 'https://$_apiUrl/sharing/$hash';
    return link;
  }

  //Mandar token de usuario a la base de datos
  updateUserToken() async {
    final String? token = await FirebaseMessaging.instance.getToken();
    final userApiHash = await _authService.readToken();

    if (token != null && userApiHash.isNotEmpty) {
      final url = Uri.https(_apiUrl, globalVariables.urlPostFcmToken, {
        'user_api_hash': userApiHash,
        'token': token,
      });

      await http.get(url);
    }
  }

  int page = 1;
  //Obtener todas las alertas
  Future<AlertResponse> getAlerts(
      {final from, final to, final deviceId, int page = 1}) async {
    final userApiHash = await _authService.readToken();
    Uri url = Uri.http('');
    if (from != null && to != null && deviceId != null) {
      final String newDate = DateHelper.addValueToDate(to, day: 1);

      url = Uri.https(_apiUrl, globalVariables.urlGetEvents, {
        'lang': 'en',
        'user_api_hash': userApiHash,
        'page': page.toString(),
        'device_id': [deviceId],
        'date_from': from,
        'date_to': newDate,
      });
    } else {
      url = Uri.https(_apiUrl, globalVariables.urlGetEvents, {
        'lang': 'en',
        'user_api_hash': userApiHash,
        'page': page.toString()
      });
    }

    final response = await http.get(url);

    final Map<String, dynamic> jsonData = json.decode(response.body);

    alertsReponse = AlertResponse.fromMap(jsonData);

    return alertsReponse!;
  }

  //Actualizar contraseña del usuario
  updatePassword(String password, String passwordConfirmation) async {
    final userApiHash = await _authService.readToken();
    final userEmail = await _authService.readEmail();

    final url = Uri.https(_apiUrl, globalVariables.urlChangePassword, {
      'email': userEmail,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'user_api_hash': userApiHash
    });

    final response = await http.get(url);

    final jsonData = jsonDecode(response.body);

    int status = jsonData['status'];

    if (status == 0) {
      return status;
    }

    return status;
  }

  //Obtener historial por vehiculo
  getRecordByDevice(String dateFrom, String hourFrom, String dateTo,
      String hourTo, String deviceId) async {
    final userApiHash = await _authService.readToken();
    final headers = {
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };

    // DateTime now = DateTime.now();
    // DateTime initialDateTime = DateTime(now.year, now.month, now.day, 0, 0);
    // DateTime finalDateTime = DateTime(now.year, now.month, now.day, 23, 0);
    // String formattedInitialTime = DateFormat.Hm().format(initialDateTime);
    // String formattedFinalTime = DateFormat.Hm().format(finalDateTime);

    final url = Uri.https(_apiUrl, globalVariables.urlGetHistory, {
      'user_api_hash': userApiHash,
      'from_date': dateFrom,
      'from_time': hourFrom,
      'to_date': dateTo,
      'to_time': hourTo,
      'device_id': [deviceId],
      'snap_to_road': getIsSetToRoad.toString(),
    });
    var response = await http.get(url, headers: headers);

    final jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 0) return null;

    final mapResponse = DeviceDetails.fromJson(response.body);

    if (mapResponse.items!.length <= 1) return null;

    if (mapResponse.items!.isNotEmpty) {
      deviceDetails = mapResponse;
      notifyListeners();
      return deviceDetails;
    }
    notifyListeners();
    return mapResponse;
  }

  //Obtener geocercas
  Future<Map<int, Map<String, dynamic>>> getGeofences() async {
    final userApiHash = await _authService.readToken();
    Map<int, Map<String, dynamic>> cordinates = {};
    int index = 0;

    final url = Uri.https(_apiUrl, globalVariables.urlGetGeofences, {
      'user_api_hash': userApiHash,
    });

    final response = await http.get(url);

    final jsonData = jsonDecode(response.body);

    final geofenceResponse = GeofenceResponse.fromMap(jsonData);

    if (geofenceResponse.items.geofences!.isNotEmpty) {
      for (var element in geofenceResponse.items.geofences!) {
        List<Map<String, dynamic>> coordinateList =
            List<Map<String, dynamic>>.from(jsonDecode(element.coordinates));
        List<LatLng> latLngList = [];

        // Ahora puedes trabajar con la lista de coordenadas
        for (var coordinate in coordinateList) {
          double lat = coordinate['lat']!;
          double lng = coordinate['lng']!;

          latLngList.add(LatLng(lat, lng));
        }

        cordinates[index] = {
          'name': element.name,
          'cordinates': latLngList,
          'color': element.polygonColor,
          'id': element.id
        };
        index++;
      }
    }

    return cordinates;
  }

  //Obtener datos de la empresa del usuario
  Future<UserData> getUserData() async {
    final userApiHash = await _authService.readToken();

    final url = Uri.https(_apiUrl, globalVariables.urlGetUserData, {
      'lang': 'en',
      'user_api_hash': userApiHash,
    });

    final response = await http.get(url);

    final jsonData = json.decode(response.body);

    final String logo = await getUserLogo(userApiHash);

    final userDataResponse = UserData.fromMap(jsonData);

    userDataResponse.logo = logo;

    userData = userDataResponse;

    return userDataResponse;
  }

  //Obtener el logo de la empresa
  Future<String> getUserLogo(String userApiHash) async {
    final url = Uri.https(_apiUrl, globalVariables.urlGetUserLogo, {
      'lang': 'en',
      'user_api_hash': userApiHash,
    });

    final response = await http.get(url);

    final jsonData = json.decode(response.body);

    if (jsonData['status'] != 1) {
      return 'https://${GlobalVariables().apiUrl}/assets/logo.php?id=1393&type=logo-main&t=m1621966108';
    }
    return jsonData['url'];
  }

  //Obtener la cantidad de vehiculos que estan por expirar
  Future<int> getCountDevicesToExpire() async {
    List<DateTime> expirationDate = [];
    final List<DeviceResponse> device = await getAllDevice();
    final DateTime currentDate = DateTime.now();
    Duration difference;
    DateTime expiration;
    int differenceDays;

    for (var element in device) {
      for (var element in element.items) {
        if (element.deviceData.expirationDate != null) {
          expiration =
              DateFormat("yyyy-MM-dd").parse(element.deviceData.expirationDate);
          difference = currentDate.difference(expiration);
          differenceDays = difference.inDays.abs();

          if (differenceDays <= 10) {
            expirationDate.add(expiration);
          }
        }
      }
    }
    return expirationDate.length;
  }

  //Obtener lista de alertas
  Future<Alerts> getAlertsList() async {
    final userApiHash = await _authService.readToken();

    final url = Uri.https(_apiUrl, globalVariables.urlAlerts, {
      'lang': 'en',
      'user_api_hash': userApiHash,
    });

    final response = await http.get(url);

    final jsonData = json.decode(response.body);

    final userDataResponse = Alerts.fromMap(jsonData);

    notifyListeners();

    return userDataResponse;
  }

  //Obtener lista de alertas
  changeActiveAlert(int id, int active) async {
    final userApiHash = await _authService.readToken();

    final url = Uri.https(_apiUrl, globalVariables.urlChangeActiveAlert, {
      'lang': 'en',
      'user_api_hash': userApiHash,
      'id': [id.toString()],
      'active': [active.toString()]
    });

    final response = await http.get(url);

    final jsonData = json.decode(response.body);

    return jsonData['status'];
  }

  //Obtener lista de alertas
  Future<Tour> getTours() async {
    final userApiHash = await _authService.readToken();

    final url = Uri.https(_apiUrl, globalVariables.urlGetUserMapIcons, {
      'lang': 'en',
      'user_api_hash': userApiHash,
    });

    final response = await http.get(url);

    final jsonData = json.decode(response.body);

    final userDataResponse = Tour.fromMap(jsonData);

    return userDataResponse;
  }

  //Obtener tipos de informe
  Future<Report> getReports() async {
    final userApiHash = await _authService.readToken();

    final url = Uri.https(_apiUrl, globalVariables.urlGetReports, {
      'lang': 'es',
      'user_api_hash': userApiHash,
    });

    final response = await http.get(url);

    final jsonData = json.decode(response.body);

    final reportModelResponse = Report.fromMap(jsonData);

    return reportModelResponse;
  }

  //Generar informe
  Future<ApiResponse> generateReports(String deviceId, DateTime dateFrom,
      DateTime dateTo, String type, String documentTypeSelected,
      {String? speedLimit, String? geofence}) async {
    final userApiHash = await _authService.readToken();

    final dateFromToString = DateHelper.dateTimeToString(dateFrom);
    final dateToToString = DateHelper.dateTimeToString(dateTo);

    Map<String, String> queryParameters = {
      'user_api_hash': userApiHash,
      'devices[]': deviceId,
      'date_from': dateFromToString,
      'date_to': dateToToString,
      'format': documentTypeSelected.toLowerCase(),
      'type': type,
    };

    if (type == '5') {
      queryParameters['speed_limit'] = speedLimit.toString();
    } else if (type == '31') {
      queryParameters['geofences[]'] = geofence.toString();
    }

    final url =
        Uri.https(_apiUrl, globalVariables.urlGenerateReport, queryParameters);

    final response = await http.post(url);

    final jsonData = json.decode(response.body);

    final apiResponse = ApiResponse(jsonData['status'], jsonData['status'],
        jsonData['url'] ?? '', response.bodyBytes);
    return apiResponse;
  }
}
