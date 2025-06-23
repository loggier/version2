import 'package:flutter/material.dart';
import 'package:prosecat/helpers/date_to_string.dart';

class ReportsProvider extends ChangeNotifier {
  GlobalKey<FormState> recordKey = GlobalKey();
  String? _reportTypeSelected;
  String _documentTypeSelected = 'PDF';
  String _speedLimit = '100';
  String? _geofence;
  String? _deviceSelected;
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now();
  bool isLoading = false;
  // Map<int, bool> checkBoxValues = {};
  // bool selectAll = false;

  String? get getReportTypeSelected => _reportTypeSelected;
  get getDocumentTypeSelected => _documentTypeSelected;
  get getDeviceSelected => _deviceSelected;
  get getSpeedLimit => _speedLimit;
  get getGeofence => _geofence;
  bool get getIsLoading => isLoading;

  getDateFrom() {
    return DateHelper.dateTimeToString(dateFrom);
  }

  getDateTo() {
    return DateHelper.dateTimeToString(dateTo);
  }

  set reportTypeSelected(String value) {
    _reportTypeSelected = value;
    notifyListeners();
  }

  set documentTypeSelected(String value) {
    if (value == '0') {
      _documentTypeSelected = 'PDF';
    } else {
      _documentTypeSelected = 'HTML';
    }
    notifyListeners();
  }

  set deviceSelected(String value) {
    _deviceSelected = value;
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

  set setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  set setSpeedLimit(String speed) {
    _speedLimit = speed;
    notifyListeners();
  }

  set setGeofence(String? id) {
    _geofence = id;
    notifyListeners();
  }

  // setCheckBoxValue(int id, bool value){
  //   checkBoxValues[id] = value;
  //   notifyListeners();
  // }

  // setSelectAllCheckBoxValue(bool value){
  //   selectAll = value;

  //   checkBoxValues.forEach((key, _) {
  //     checkBoxValues[key] = value;
  //   });

  //   notifyListeners();
  // }

  bool isValidForm() {
    return recordKey.currentState?.validate() ?? false;
  }
}
