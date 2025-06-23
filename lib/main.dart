import 'package:flutter/material.dart';
import 'package:prosecat/controllers/controllers.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:prosecat/routes/routes.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/preferences/preference.dart';
import 'package:prosecat/system/global.dart';
import 'package:prosecat/theme/theme_data.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'helpers/navigator_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ThemeAppProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginFormProvider()),
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => DeviceProvider()),
          ChangeNotifierProvider(create: (_) => MapScreenProvider()),
          ChangeNotifierProvider(create: (_) => MapController()),
          ChangeNotifierProvider(create: (_) => MapAlertsController()),
          ChangeNotifierProvider(create: (_) => SetProfileProvider()),
          ChangeNotifierProvider(create: (_) => MapRecordController()),
          ChangeNotifierProvider(create: (_) => PagesProvider()),
          ChangeNotifierProvider(create: (_) => ReportsProvider()),
        ],
        child: MaterialApp(
            home: initialRoute,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: GlobalVariables().appName,
            initialRoute: 'check_auth',
            routes: appRoutes,
            // theme: AppThemes().themeLightData,
            // theme: Provider.of<ThemeAppProvider>(context).getTheme() ?  AppThemes().themeDarkData : AppThemes().themeLightData,
            theme: AppThemes().themeLightData,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: (Preferences.idioma == '')
                ? S.delegate.supportedLocales
                : [Locale(Preferences.idioma)]));
  }
}
