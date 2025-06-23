// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: 'You have 1 device to expire', other: 'You have ${howMany} devices to expire')}";

  static String m1(ruta) => "Go to ${ruta}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aceptarMensaje": MessageLookupByLibrary.simpleMessage("Ok"),
        "anteayer":
            MessageLookupByLibrary.simpleMessage("The day before yesterday"),
        "archivoDescargado":
            MessageLookupByLibrary.simpleMessage("Downloaded file"),
        "ayer": MessageLookupByLibrary.simpleMessage("Yesterday"),
        "bloquear": MessageLookupByLibrary.simpleMessage("Lock"),
        "catalan": MessageLookupByLibrary.simpleMessage("Catalan"),
        "center": MessageLookupByLibrary.simpleMessage("Center"),
        "consultar": MessageLookupByLibrary.simpleMessage("Consult"),
        "desbloquear": MessageLookupByLibrary.simpleMessage("Unlock"),
        "desbloquearMotor":
            MessageLookupByLibrary.simpleMessage("Unlock engine"),
        "descripcion": MessageLookupByLibrary.simpleMessage("Description"),
        "errorAlObtenerLosInformes":
            MessageLookupByLibrary.simpleMessage("Error getting reports"),
        "errorFechaMayor": MessageLookupByLibrary.simpleMessage(
            "The start date cannot be greater than the end date"),
        "errorFechaMenor": MessageLookupByLibrary.simpleMessage(
            "The end date cannot be less than the start date"),
        "errorMensaje": MessageLookupByLibrary.simpleMessage("Incorrect data"),
        "errorNoElPrimerDia":
            MessageLookupByLibrary.simpleMessage("Please not the first day"),
        "errorSeleccioneUnDocumento":
            MessageLookupByLibrary.simpleMessage("Select a document"),
        "errorSeleccioneUnInforme":
            MessageLookupByLibrary.simpleMessage("Select a report"),
        "errorSeleccioneUnVehiculo":
            MessageLookupByLibrary.simpleMessage("Select a vehicle"),
        "errorSinDatos": MessageLookupByLibrary.simpleMessage("No data found"),
        "espanol": MessageLookupByLibrary.simpleMessage("Spanish"),
        "etiquetaContrasena": MessageLookupByLibrary.simpleMessage("Password"),
        "etiquetaNombreDeUsuario":
            MessageLookupByLibrary.simpleMessage("Username"),
        "generarInforme":
            MessageLookupByLibrary.simpleMessage("Generate report"),
        "haceSieteDias": MessageLookupByLibrary.simpleMessage("Seven days ago"),
        "haceTresDias": MessageLookupByLibrary.simpleMessage("Three days ago"),
        "hoy": MessageLookupByLibrary.simpleMessage("Today"),
        "idioma": MessageLookupByLibrary.simpleMessage("Language"),
        "informe": MessageLookupByLibrary.simpleMessage("Report"),
        "ingles": MessageLookupByLibrary.simpleMessage("English"),
        "ingreseUnValor": MessageLookupByLibrary.simpleMessage("Enter a value"),
        "labelAjustarCarretera":
            MessageLookupByLibrary.simpleMessage("Adjust to road"),
        "labelAjustarPerfil":
            MessageLookupByLibrary.simpleMessage("Set up profile"),
        "labelAlaUnidad": MessageLookupByLibrary.simpleMessage("to the unit"),
        "labelAlerta": MessageLookupByLibrary.simpleMessage("Alerta"),
        "labelAlertas": MessageLookupByLibrary.simpleMessage("Alerts"),
        "labelAltitud": MessageLookupByLibrary.simpleMessage("Altitude"),
        "labelAngulo": MessageLookupByLibrary.simpleMessage("Angle"),
        "labelApagado": MessageLookupByLibrary.simpleMessage("Off"),
        "labelArribo": MessageLookupByLibrary.simpleMessage("Arrival"),
        "labelBateriaInterna":
            MessageLookupByLibrary.simpleMessage("Internal battery"),
        "labelBuscar": MessageLookupByLibrary.simpleMessage("Search"),
        "labelCambiarClave":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "labelCancelar": MessageLookupByLibrary.simpleMessage("Cancel"),
        "labelComando": MessageLookupByLibrary.simpleMessage("Commands"),
        "labelCombustible": MessageLookupByLibrary.simpleMessage("Fuel"),
        "labelConduccion": MessageLookupByLibrary.simpleMessage("Driving"),
        "labelConductor": MessageLookupByLibrary.simpleMessage("Driver"),
        "labelConfirmar": MessageLookupByLibrary.simpleMessage("Ok"),
        "labelConfirmarContrasena":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "labelConsumo": MessageLookupByLibrary.simpleMessage("Consumption"),
        "labelContrasenaNoCoincide":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "labelCorreoElectronico": MessageLookupByLibrary.simpleMessage("Email"),
        "labelDesconectado":
            MessageLookupByLibrary.simpleMessage("Disconnected"),
        "labelDesde": MessageLookupByLibrary.simpleMessage("From"),
        "labelDeseaEnviarElComando": MessageLookupByLibrary.simpleMessage(
            "You want to send the command"),
        "labelDetalle": MessageLookupByLibrary.simpleMessage("Detail"),
        "labelDetenido": MessageLookupByLibrary.simpleMessage("Stopped"),
        "labelDireccion": MessageLookupByLibrary.simpleMessage("Address"),
        "labelDispositivo": MessageLookupByLibrary.simpleMessage("Device"),
        "labelDispositivoPorVencer": m0,
        "labelDispositivos": MessageLookupByLibrary.simpleMessage("Devices"),
        "labelDistancia": MessageLookupByLibrary.simpleMessage("Distance"),
        "labelDuracion": MessageLookupByLibrary.simpleMessage("Duration"),
        "labelDuracionDeParada":
            MessageLookupByLibrary.simpleMessage("Stop Duration"),
        "labelEnLinea": MessageLookupByLibrary.simpleMessage("Online"),
        "labelEncendido": MessageLookupByLibrary.simpleMessage("Ignition"),
        "labelEvento": MessageLookupByLibrary.simpleMessage("Event"),
        "labelExpandir": MessageLookupByLibrary.simpleMessage("Expand"),
        "labelExpiracion": MessageLookupByLibrary.simpleMessage("Expiration"),
        "labelFecha": MessageLookupByLibrary.simpleMessage("Date"),
        "labelFechaExpiracion":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "labelFinDeConduccion":
            MessageLookupByLibrary.simpleMessage("End of driving"),
        "labelFinalizo": MessageLookupByLibrary.simpleMessage("Finalized"),
        "labelFueraLinea": MessageLookupByLibrary.simpleMessage("Offline"),
        "labelGenerarLink":
            MessageLookupByLibrary.simpleMessage("Generate link"),
        "labelHasta": MessageLookupByLibrary.simpleMessage("To"),
        "labelHistorial": MessageLookupByLibrary.simpleMessage("History"),
        "labelInformacionDeContacto":
            MessageLookupByLibrary.simpleMessage("Contact information"),
        "labelIniciarSesion": MessageLookupByLibrary.simpleMessage("Log In"),
        "labelInicio": MessageLookupByLibrary.simpleMessage("Start"),
        "labelIrA": m1,
        "labelLatitud": MessageLookupByLibrary.simpleMessage("Latitude"),
        "labelLineaAmarilla": MessageLookupByLibrary.simpleMessage(
            "Yellow line: speed less than"),
        "labelLineaRoja": MessageLookupByLibrary.simpleMessage(
            "Red line: speed greater than"),
        "labelLineaVerde":
            MessageLookupByLibrary.simpleMessage("Green line: speed less than"),
        "labelLineasDeVelocidad":
            MessageLookupByLibrary.simpleMessage("Speed lines"),
        "labelLongitud": MessageLookupByLibrary.simpleMessage("Length"),
        "labelMapa": MessageLookupByLibrary.simpleMessage("Map"),
        "labelMapas": MessageLookupByLibrary.simpleMessage("Maps"),
        "labelMiUbicacion": MessageLookupByLibrary.simpleMessage("Show spin"),
        "labelMostrarDia": MessageLookupByLibrary.simpleMessage("Show day"),
        "labelMostrarHistorial":
            MessageLookupByLibrary.simpleMessage("Show History"),
        "labelMostrarMas": MessageLookupByLibrary.simpleMessage("Show more"),
        "labelMostrarRecorrido":
            MessageLookupByLibrary.simpleMessage("Show tour"),
        "labelMotorInactivo":
            MessageLookupByLibrary.simpleMessage("Motor inactive"),
        "labelNombre": MessageLookupByLibrary.simpleMessage("Name"),
        "labelNuevaContrasena":
            MessageLookupByLibrary.simpleMessage("New password"),
        "labelParada": MessageLookupByLibrary.simpleMessage("Stop"),
        "labelPartio": MessageLookupByLibrary.simpleMessage("Departed"),
        "labelPerfil": MessageLookupByLibrary.simpleMessage("Profile"),
        "labelPosicion": MessageLookupByLibrary.simpleMessage("Position"),
        "labelResumen": MessageLookupByLibrary.simpleMessage("Summary"),
        "labelRutas": MessageLookupByLibrary.simpleMessage("Geofences"),
        "labelSalir": MessageLookupByLibrary.simpleMessage("Exit"),
        "labelSeleccioneLaFechaVigente":
            MessageLookupByLibrary.simpleMessage("Select the current date"),
        "labelSeleccioneUnaFecha":
            MessageLookupByLibrary.simpleMessage("Select a date"),
        "labelSensores": MessageLookupByLibrary.simpleMessage("Sensors"),
        "labelSinAlertas": MessageLookupByLibrary.simpleMessage("No alerts"),
        "labelSinComandos": MessageLookupByLibrary.simpleMessage("Co commands"),
        "labelTelefono": MessageLookupByLibrary.simpleMessage("Phone"),
        "labelTiempo": MessageLookupByLibrary.simpleMessage("Time"),
        "labelTodos": MessageLookupByLibrary.simpleMessage("All"),
        "labelUltimaConexion":
            MessageLookupByLibrary.simpleMessage("Last connection"),
        "labelVelocidad": MessageLookupByLibrary.simpleMessage("Speed"),
        "labelVelocidadMaxima":
            MessageLookupByLibrary.simpleMessage("Maximum Speed"),
        "labelVerUbicacion":
            MessageLookupByLibrary.simpleMessage("See location"),
        "labelVistaDeCalle":
            MessageLookupByLibrary.simpleMessage("Street view"),
        "labelmostrarMenos": MessageLookupByLibrary.simpleMessage("Show less"),
        "labelmostrarRecorrido":
            MessageLookupByLibrary.simpleMessage("Show tour"),
        "lockEngine": MessageLookupByLibrary.simpleMessage("Lock engine"),
        "manana": MessageLookupByLibrary.simpleMessage("Tomorrow"),
        "mensaje": MessageLookupByLibrary.simpleMessage("Message"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "problemasAlDescargarElArchivo": MessageLookupByLibrary.simpleMessage(
            "Problems downloading the file"),
        "prosecat":
            MessageLookupByLibrary.simpleMessage("Satellite Tracking System"),
        "puntosDeInteres":
            MessageLookupByLibrary.simpleMessage("Points of interest"),
        "seHaEnviadoElComando":
            MessageLookupByLibrary.simpleMessage("The command has been sent"),
        "seleccioneUnValor":
            MessageLookupByLibrary.simpleMessage("Select a value"),
        "si": MessageLookupByLibrary.simpleMessage("Yes"),
        "tipoDeDocumento":
            MessageLookupByLibrary.simpleMessage("Document type"),
        "tipoDeInforme": MessageLookupByLibrary.simpleMessage("Report type"),
        "tituloCompartir": MessageLookupByLibrary.simpleMessage("Share"),
        "validacionContrasena": MessageLookupByLibrary.simpleMessage(
            "The password must be longer than 6 characters"),
        "validacionIdioma":
            MessageLookupByLibrary.simpleMessage("Select an option"),
        "validacionNombreDeUsuario": MessageLookupByLibrary.simpleMessage(
            "The value entered is not an email"),
        "vehiculos": MessageLookupByLibrary.simpleMessage("Vehicle(s)")
      };
}
