import 'package:flutter/material.dart';

class AppThemes {
  final fontFamily = 'Roboto';

  final TextTheme textTheme = const TextTheme(
    //En el subtitulo de drawer y los detalles dentro de la pantalla de Dispositivos
    bodySmall: TextStyle(fontSize: 12),
    bodyMedium: TextStyle(fontSize: 14),
    bodyLarge: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
  );

  final AppBarTheme appBarTheme = AppBarTheme(
      // color: Colors.red, //Color de appbar
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        color: Colors.grey.shade800,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ));

  ThemeData get themeData => ThemeData(
        //Con colorScheme se cambia todos los colores,
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.dark,
        //   primary: Colors.red,
        //   onPrimary: Colors.red,
        //   secondary: Colors.red,
        //   onSecondary: Colors.red,
        //   error: Colors.red,
        //   onError: Colors.red,
        //   background: Colors.red,
        //   onBackground: Colors.red,
        //   surface: Colors.red,
        //   onSurface: Colors.red
        // ),
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: fontFamily,
        textTheme: textTheme,

        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (dynamic _) => const FadeUpwardsPageTransitionsBuilder(),
          ),
        ),

        appBarTheme: appBarTheme,
      );

  ThemeData get themeLightData => ThemeData.light(useMaterial3: true).copyWith(
      // primaryColorLight: Colors.amber,
      // colorScheme: ColorScheme(
      //   brightness: Brightness.light,
      //   primary:  Color(0xff6200ee),
      //   onPrimary: Colors.white,
      //   secondary: Color(0xff03dac6),
      //   onSecondary: Colors.black,
      //   error: Color(0xffb00020),
      //   onError: Colors.white,
      //   background: Colors.white,
      //   onBackground: Colors.grey,
      //   surface: Colors.white,
      //   onSurface: Colors.black,
      // ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      brightness: themeData.brightness,
      textTheme: themeData.textTheme,
      pageTransitionsTheme: themeData.pageTransitionsTheme,
      appBarTheme: appBarTheme
      // scaffoldBackgroundColor: Colors.red
      // appBarTheme: themeData.appBarTheme.copyWith(
      //   backgroundColor: Colors.red
      // ),
      // drawerTheme: DrawerThemeData(
      //   backgroundColor: Colors.red
      // )
      );

  ThemeData get themeDarkData => ThemeData(
      useMaterial3: true,
      // colorSchemeSeed: Colors.green,
      // colorScheme: ColorScheme.dark(
      //   primary: Colors.grey.shade900
      // ),
      brightness: Brightness.dark,
      textTheme: textTheme.copyWith(
          bodyLarge: textTheme.bodyLarge!.copyWith(color: Colors.white)),
      appBarTheme: appBarTheme.copyWith(
          titleTextStyle:
              appBarTheme.titleTextStyle!.copyWith(color: Colors.white)));
}
