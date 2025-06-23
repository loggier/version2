// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Username`
  String get etiquetaNombreDeUsuario {
    return Intl.message(
      'Username',
      name: 'etiquetaNombreDeUsuario',
      desc: '',
      args: [],
    );
  }

  /// `The command has been sent`
  String get seHaEnviadoElComando {
    return Intl.message(
      'The command has been sent',
      name: 'seHaEnviadoElComando',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get etiquetaContrasena {
    return Intl.message(
      'Password',
      name: 'etiquetaContrasena',
      desc: '',
      args: [],
    );
  }

  /// `The value entered is not an email`
  String get validacionNombreDeUsuario {
    return Intl.message(
      'The value entered is not an email',
      name: 'validacionNombreDeUsuario',
      desc: '',
      args: [],
    );
  }

  /// `The password must be longer than 6 characters`
  String get validacionContrasena {
    return Intl.message(
      'The password must be longer than 6 characters',
      name: 'validacionContrasena',
      desc: '',
      args: [],
    );
  }

  /// `Select an option`
  String get validacionIdioma {
    return Intl.message(
      'Select an option',
      name: 'validacionIdioma',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get idioma {
    return Intl.message(
      'Language',
      name: 'idioma',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get espanol {
    return Intl.message(
      'Spanish',
      name: 'espanol',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get ingles {
    return Intl.message(
      'English',
      name: 'ingles',
      desc: '',
      args: [],
    );
  }

  /// `Catalan`
  String get catalan {
    return Intl.message(
      'Catalan',
      name: 'catalan',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get labelIniciarSesion {
    return Intl.message(
      'Log In',
      name: 'labelIniciarSesion',
      desc: '',
      args: [],
    );
  }

  /// `Satellite Tracking System`
  String get prosecat {
    return Intl.message(
      'Satellite Tracking System',
      name: 'prosecat',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get mensaje {
    return Intl.message(
      'Message',
      name: 'mensaje',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect data`
  String get errorMensaje {
    return Intl.message(
      'Incorrect data',
      name: 'errorMensaje',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get aceptarMensaje {
    return Intl.message(
      'Ok',
      name: 'aceptarMensaje',
      desc: '',
      args: [],
    );
  }

  /// `Maps`
  String get labelMapas {
    return Intl.message(
      'Maps',
      name: 'labelMapas',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get labelMapa {
    return Intl.message(
      'Map',
      name: 'labelMapa',
      desc: '',
      args: [],
    );
  }

  /// `Expand`
  String get labelExpandir {
    return Intl.message(
      'Expand',
      name: 'labelExpandir',
      desc: '',
      args: [],
    );
  }

  /// `Geofences`
  String get labelRutas {
    return Intl.message(
      'Geofences',
      name: 'labelRutas',
      desc: '',
      args: [],
    );
  }

  /// `Show spin`
  String get labelMiUbicacion {
    return Intl.message(
      'Show spin',
      name: 'labelMiUbicacion',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get labelDispositivos {
    return Intl.message(
      'Devices',
      name: 'labelDispositivos',
      desc: '',
      args: [],
    );
  }

  /// `Alerts`
  String get labelAlertas {
    return Intl.message(
      'Alerts',
      name: 'labelAlertas',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get labelHistorial {
    return Intl.message(
      'History',
      name: 'labelHistorial',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get labelPerfil {
    return Intl.message(
      'Profile',
      name: 'labelPerfil',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get labelSalir {
    return Intl.message(
      'Exit',
      name: 'labelSalir',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get labelResumen {
    return Intl.message(
      'Summary',
      name: 'labelResumen',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get labelDetalle {
    return Intl.message(
      'Detail',
      name: 'labelDetalle',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Speed`
  String get labelVelocidadMaxima {
    return Intl.message(
      'Maximum Speed',
      name: 'labelVelocidadMaxima',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get labelDistancia {
    return Intl.message(
      'Distance',
      name: 'labelDistancia',
      desc: '',
      args: [],
    );
  }

  /// `Motor inactive`
  String get labelMotorInactivo {
    return Intl.message(
      'Motor inactive',
      name: 'labelMotorInactivo',
      desc: '',
      args: [],
    );
  }

  /// `Driver`
  String get labelConductor {
    return Intl.message(
      'Driver',
      name: 'labelConductor',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get labelDireccion {
    return Intl.message(
      'Address',
      name: 'labelDireccion',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get labelTiempo {
    return Intl.message(
      'Time',
      name: 'labelTiempo',
      desc: '',
      args: [],
    );
  }

  /// `Stop Duration`
  String get labelDuracionDeParada {
    return Intl.message(
      'Stop Duration',
      name: 'labelDuracionDeParada',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get labelTodos {
    return Intl.message(
      'All',
      name: 'labelTodos',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get labelEnLinea {
    return Intl.message(
      'Online',
      name: 'labelEnLinea',
      desc: '',
      args: [],
    );
  }

  /// `Stopped`
  String get labelDetenido {
    return Intl.message(
      'Stopped',
      name: 'labelDetenido',
      desc: '',
      args: [],
    );
  }

  /// `Disconnected`
  String get labelDesconectado {
    return Intl.message(
      'Disconnected',
      name: 'labelDesconectado',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get labelFueraLinea {
    return Intl.message(
      'Offline',
      name: 'labelFueraLinea',
      desc: '',
      args: [],
    );
  }

  /// `Show day`
  String get labelMostrarDia {
    return Intl.message(
      'Show day',
      name: 'labelMostrarDia',
      desc: '',
      args: [],
    );
  }

  /// `Seven days ago`
  String get haceSieteDias {
    return Intl.message(
      'Seven days ago',
      name: 'haceSieteDias',
      desc: '',
      args: [],
    );
  }

  /// `Three days ago`
  String get haceTresDias {
    return Intl.message(
      'Three days ago',
      name: 'haceTresDias',
      desc: '',
      args: [],
    );
  }

  /// `The day before yesterday`
  String get anteayer {
    return Intl.message(
      'The day before yesterday',
      name: 'anteayer',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get ayer {
    return Intl.message(
      'Yesterday',
      name: 'ayer',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get hoy {
    return Intl.message(
      'Today',
      name: 'hoy',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get manana {
    return Intl.message(
      'Tomorrow',
      name: 'manana',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get labelDesde {
    return Intl.message(
      'From',
      name: 'labelDesde',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get labelHasta {
    return Intl.message(
      'To',
      name: 'labelHasta',
      desc: '',
      args: [],
    );
  }

  /// `Adjust to road`
  String get labelAjustarCarretera {
    return Intl.message(
      'Adjust to road',
      name: 'labelAjustarCarretera',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get si {
    return Intl.message(
      'Yes',
      name: 'si',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Show History`
  String get labelMostrarHistorial {
    return Intl.message(
      'Show History',
      name: 'labelMostrarHistorial',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get labelCancelar {
    return Intl.message(
      'Cancel',
      name: 'labelCancelar',
      desc: '',
      args: [],
    );
  }

  /// `Please not the first day`
  String get errorNoElPrimerDia {
    return Intl.message(
      'Please not the first day',
      name: 'errorNoElPrimerDia',
      desc: '',
      args: [],
    );
  }

  /// `Set up profile`
  String get labelAjustarPerfil {
    return Intl.message(
      'Set up profile',
      name: 'labelAjustarPerfil',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get labelCorreoElectronico {
    return Intl.message(
      'Email',
      name: 'labelCorreoElectronico',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get labelNuevaContrasena {
    return Intl.message(
      'New password',
      name: 'labelNuevaContrasena',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get labelConfirmarContrasena {
    return Intl.message(
      'Confirm password',
      name: 'labelConfirmarContrasena',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get labelCambiarClave {
    return Intl.message(
      'Change password',
      name: 'labelCambiarClave',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get tituloCompartir {
    return Intl.message(
      'Share',
      name: 'tituloCompartir',
      desc: '',
      args: [],
    );
  }

  /// `Select the current date`
  String get labelSeleccioneLaFechaVigente {
    return Intl.message(
      'Select the current date',
      name: 'labelSeleccioneLaFechaVigente',
      desc: '',
      args: [],
    );
  }

  /// `Generate link`
  String get labelGenerarLink {
    return Intl.message(
      'Generate link',
      name: 'labelGenerarLink',
      desc: '',
      args: [],
    );
  }

  /// `Commands`
  String get labelComando {
    return Intl.message(
      'Commands',
      name: 'labelComando',
      desc: '',
      args: [],
    );
  }

  /// `Co commands`
  String get labelSinComandos {
    return Intl.message(
      'Co commands',
      name: 'labelSinComandos',
      desc: '',
      args: [],
    );
  }

  /// `You want to send the command`
  String get labelDeseaEnviarElComando {
    return Intl.message(
      'You want to send the command',
      name: 'labelDeseaEnviarElComando',
      desc: '',
      args: [],
    );
  }

  /// `to the unit`
  String get labelAlaUnidad {
    return Intl.message(
      'to the unit',
      name: 'labelAlaUnidad',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get labelBuscar {
    return Intl.message(
      'Search',
      name: 'labelBuscar',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get labelNombre {
    return Intl.message(
      'Name',
      name: 'labelNombre',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get labelFecha {
    return Intl.message(
      'Date',
      name: 'labelFecha',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get labelPosicion {
    return Intl.message(
      'Position',
      name: 'labelPosicion',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get labelVelocidad {
    return Intl.message(
      'Speed',
      name: 'labelVelocidad',
      desc: '',
      args: [],
    );
  }

  /// `Alerta`
  String get labelAlerta {
    return Intl.message(
      'Alerta',
      name: 'labelAlerta',
      desc: '',
      args: [],
    );
  }

  /// `Driving`
  String get labelConduccion {
    return Intl.message(
      'Driving',
      name: 'labelConduccion',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get labelInicio {
    return Intl.message(
      'Start',
      name: 'labelInicio',
      desc: '',
      args: [],
    );
  }

  /// `Finalized`
  String get labelFinalizo {
    return Intl.message(
      'Finalized',
      name: 'labelFinalizo',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get labelParada {
    return Intl.message(
      'Stop',
      name: 'labelParada',
      desc: '',
      args: [],
    );
  }

  /// `End of driving`
  String get labelFinDeConduccion {
    return Intl.message(
      'End of driving',
      name: 'labelFinDeConduccion',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get labelEvento {
    return Intl.message(
      'Event',
      name: 'labelEvento',
      desc: '',
      args: [],
    );
  }

  /// `Sensors`
  String get labelSensores {
    return Intl.message(
      'Sensors',
      name: 'labelSensores',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get labelDispositivo {
    return Intl.message(
      'Device',
      name: 'labelDispositivo',
      desc: '',
      args: [],
    );
  }

  /// `The start date cannot be greater than the end date`
  String get errorFechaMayor {
    return Intl.message(
      'The start date cannot be greater than the end date',
      name: 'errorFechaMayor',
      desc: '',
      args: [],
    );
  }

  /// `The end date cannot be less than the start date`
  String get errorFechaMenor {
    return Intl.message(
      'The end date cannot be less than the start date',
      name: 'errorFechaMenor',
      desc: '',
      args: [],
    );
  }

  /// `No data found`
  String get errorSinDatos {
    return Intl.message(
      'No data found',
      name: 'errorSinDatos',
      desc: '',
      args: [],
    );
  }

  /// `Select a vehicle`
  String get errorSeleccioneUnVehiculo {
    return Intl.message(
      'Select a vehicle',
      name: 'errorSeleccioneUnVehiculo',
      desc: '',
      args: [],
    );
  }

  /// `See location`
  String get labelVerUbicacion {
    return Intl.message(
      'See location',
      name: 'labelVerUbicacion',
      desc: '',
      args: [],
    );
  }

  /// `Select a date`
  String get labelSeleccioneUnaFecha {
    return Intl.message(
      'Select a date',
      name: 'labelSeleccioneUnaFecha',
      desc: '',
      args: [],
    );
  }

  /// `Street view`
  String get labelVistaDeCalle {
    return Intl.message(
      'Street view',
      name: 'labelVistaDeCalle',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get labelLatitud {
    return Intl.message(
      'Latitude',
      name: 'labelLatitud',
      desc: '',
      args: [],
    );
  }

  /// `Length`
  String get labelLongitud {
    return Intl.message(
      'Length',
      name: 'labelLongitud',
      desc: '',
      args: [],
    );
  }

  /// `Altitude`
  String get labelAltitud {
    return Intl.message(
      'Altitude',
      name: 'labelAltitud',
      desc: '',
      args: [],
    );
  }

  /// `Arrival`
  String get labelArribo {
    return Intl.message(
      'Arrival',
      name: 'labelArribo',
      desc: '',
      args: [],
    );
  }

  /// `Departed`
  String get labelPartio {
    return Intl.message(
      'Departed',
      name: 'labelPartio',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get labelDuracion {
    return Intl.message(
      'Duration',
      name: 'labelDuracion',
      desc: '',
      args: [],
    );
  }

  /// `Consumption`
  String get labelConsumo {
    return Intl.message(
      'Consumption',
      name: 'labelConsumo',
      desc: '',
      args: [],
    );
  }

  /// `Fuel`
  String get labelCombustible {
    return Intl.message(
      'Fuel',
      name: 'labelCombustible',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get labelConfirmar {
    return Intl.message(
      'Ok',
      name: 'labelConfirmar',
      desc: '',
      args: [],
    );
  }

  /// `No alerts`
  String get labelSinAlertas {
    return Intl.message(
      'No alerts',
      name: 'labelSinAlertas',
      desc: '',
      args: [],
    );
  }

  /// `Speed lines`
  String get labelLineasDeVelocidad {
    return Intl.message(
      'Speed lines',
      name: 'labelLineasDeVelocidad',
      desc: '',
      args: [],
    );
  }

  /// `Green line: speed less than`
  String get labelLineaVerde {
    return Intl.message(
      'Green line: speed less than',
      name: 'labelLineaVerde',
      desc: '',
      args: [],
    );
  }

  /// `Yellow line: speed less than`
  String get labelLineaAmarilla {
    return Intl.message(
      'Yellow line: speed less than',
      name: 'labelLineaAmarilla',
      desc: '',
      args: [],
    );
  }

  /// `Red line: speed greater than`
  String get labelLineaRoja {
    return Intl.message(
      'Red line: speed greater than',
      name: 'labelLineaRoja',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get labelTelefono {
    return Intl.message(
      'Phone',
      name: 'labelTelefono',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get labelInformacionDeContacto {
    return Intl.message(
      'Contact information',
      name: 'labelInformacionDeContacto',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one{You have 1 device to expire} other{You have {howMany} devices to expire}}`
  String labelDispositivoPorVencer(num howMany) {
    return Intl.plural(
      howMany,
      one: 'You have 1 device to expire',
      other: 'You have $howMany devices to expire',
      name: 'labelDispositivoPorVencer',
      desc: '',
      args: [howMany],
    );
  }

  /// `Expiration`
  String get labelExpiracion {
    return Intl.message(
      'Expiration',
      name: 'labelExpiracion',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get labelFechaExpiracion {
    return Intl.message(
      'Expiration date',
      name: 'labelFechaExpiracion',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get labelContrasenaNoCoincide {
    return Intl.message(
      'Passwords do not match',
      name: 'labelContrasenaNoCoincide',
      desc: '',
      args: [],
    );
  }

  /// `Show tour`
  String get labelMostrarRecorrido {
    return Intl.message(
      'Show tour',
      name: 'labelMostrarRecorrido',
      desc: '',
      args: [],
    );
  }

  /// `Angle`
  String get labelAngulo {
    return Intl.message(
      'Angle',
      name: 'labelAngulo',
      desc: '',
      args: [],
    );
  }

  /// `Go to {ruta}`
  String labelIrA(Object ruta) {
    return Intl.message(
      'Go to $ruta',
      name: 'labelIrA',
      desc: '',
      args: [ruta],
    );
  }

  /// `Last connection`
  String get labelUltimaConexion {
    return Intl.message(
      'Last connection',
      name: 'labelUltimaConexion',
      desc: '',
      args: [],
    );
  }

  /// `Ignition`
  String get labelEncendido {
    return Intl.message(
      'Ignition',
      name: 'labelEncendido',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get labelApagado {
    return Intl.message(
      'Off',
      name: 'labelApagado',
      desc: '',
      args: [],
    );
  }

  /// `Internal battery`
  String get labelBateriaInterna {
    return Intl.message(
      'Internal battery',
      name: 'labelBateriaInterna',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get labelMostrarMas {
    return Intl.message(
      'Show more',
      name: 'labelMostrarMas',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get labelmostrarMenos {
    return Intl.message(
      'Show less',
      name: 'labelmostrarMenos',
      desc: '',
      args: [],
    );
  }

  /// `Show tour`
  String get labelmostrarRecorrido {
    return Intl.message(
      'Show tour',
      name: 'labelmostrarRecorrido',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descripcion {
    return Intl.message(
      'Description',
      name: 'descripcion',
      desc: '',
      args: [],
    );
  }

  /// `Points of interest`
  String get puntosDeInteres {
    return Intl.message(
      'Points of interest',
      name: 'puntosDeInteres',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get informe {
    return Intl.message(
      'Report',
      name: 'informe',
      desc: '',
      args: [],
    );
  }

  /// `Report type`
  String get tipoDeInforme {
    return Intl.message(
      'Report type',
      name: 'tipoDeInforme',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle(s)`
  String get vehiculos {
    return Intl.message(
      'Vehicle(s)',
      name: 'vehiculos',
      desc: '',
      args: [],
    );
  }

  /// `Consult`
  String get consultar {
    return Intl.message(
      'Consult',
      name: 'consultar',
      desc: '',
      args: [],
    );
  }

  /// `Select a report`
  String get errorSeleccioneUnInforme {
    return Intl.message(
      'Select a report',
      name: 'errorSeleccioneUnInforme',
      desc: '',
      args: [],
    );
  }

  /// `Error getting reports`
  String get errorAlObtenerLosInformes {
    return Intl.message(
      'Error getting reports',
      name: 'errorAlObtenerLosInformes',
      desc: '',
      args: [],
    );
  }

  /// `Select a document`
  String get errorSeleccioneUnDocumento {
    return Intl.message(
      'Select a document',
      name: 'errorSeleccioneUnDocumento',
      desc: '',
      args: [],
    );
  }

  /// `Document type`
  String get tipoDeDocumento {
    return Intl.message(
      'Document type',
      name: 'tipoDeDocumento',
      desc: '',
      args: [],
    );
  }

  /// `Generate report`
  String get generarInforme {
    return Intl.message(
      'Generate report',
      name: 'generarInforme',
      desc: '',
      args: [],
    );
  }

  /// `Enter a value`
  String get ingreseUnValor {
    return Intl.message(
      'Enter a value',
      name: 'ingreseUnValor',
      desc: '',
      args: [],
    );
  }

  /// `Select a value`
  String get seleccioneUnValor {
    return Intl.message(
      'Select a value',
      name: 'seleccioneUnValor',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded file`
  String get archivoDescargado {
    return Intl.message(
      'Downloaded file',
      name: 'archivoDescargado',
      desc: '',
      args: [],
    );
  }

  /// `Problems downloading the file`
  String get problemasAlDescargarElArchivo {
    return Intl.message(
      'Problems downloading the file',
      name: 'problemasAlDescargarElArchivo',
      desc: '',
      args: [],
    );
  }

  /// `Center`
  String get center {
    return Intl.message(
      'Center',
      name: 'center',
      desc: '',
      args: [],
    );
  }

  /// `Lock engine`
  String get lockEngine {
    return Intl.message(
      'Lock engine',
      name: 'lockEngine',
      desc: '',
      args: [],
    );
  }

  /// `Unlock engine`
  String get desbloquearMotor {
    return Intl.message(
      'Unlock engine',
      name: 'desbloquearMotor',
      desc: '',
      args: [],
    );
  }

  /// `Unlock`
  String get desbloquear {
    return Intl.message(
      'Unlock',
      name: 'desbloquear',
      desc: '',
      args: [],
    );
  }

  /// `Lock`
  String get bloquear {
    return Intl.message(
      'Lock',
      name: 'bloquear',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
