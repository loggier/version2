import 'package:flutter/material.dart';
import 'package:prosecat/screens/screens.dart';

Map<String, WidgetBuilder> appRoutes = {
  'login': (_) => const LoginScreen(),
  'map_screen': (_) => const MapScreen(),
  'set_profile': (_) => const SetProfile(),
  'devices': (_) => const Devices(),
  'history': (_) => const History(),
  'alerts': (_) => const Alerts(),
  'history_details': (_) => const HistoryDetails(),
  'check_auth': (_) => const CheckAuthScreen(),
  'home_screen': (_) => const HomeScreen(),
  'check_alert': (_) => const CheckAlert(),
  'reports_screen': (_) => const ReportsScreen(),
};

Widget get initialRoute => const HomeScreen();