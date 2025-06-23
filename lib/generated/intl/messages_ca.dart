// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: 'té 1 dispositiu per vèncer', other: 'té ${howMany} dispositius per vèncer')}";

  static String m1(ruta) => "Anar a ${ruta}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aceptarMensaje": MessageLookupByLibrary.simpleMessage("Acceptar"),
        "anteayer": MessageLookupByLibrary.simpleMessage("Abans-d\'ahir"),
        "archivoDescargado":
            MessageLookupByLibrary.simpleMessage("Arxiu descarregat"),
        "ayer": MessageLookupByLibrary.simpleMessage("Ahir"),
        "bloquear": MessageLookupByLibrary.simpleMessage("Bloquejar"),
        "catalan": MessageLookupByLibrary.simpleMessage("Català"),
        "center": MessageLookupByLibrary.simpleMessage("Centrar"),
        "consultar": MessageLookupByLibrary.simpleMessage("Consultar"),
        "desbloquear": MessageLookupByLibrary.simpleMessage("Desbloquejar"),
        "desbloquearMotor":
            MessageLookupByLibrary.simpleMessage("Desbloquejar motor"),
        "descripcion": MessageLookupByLibrary.simpleMessage("Descripció"),
        "errorAlObtenerLosInformes": MessageLookupByLibrary.simpleMessage(
            "Error en obtenir els informes"),
        "errorFechaMayor": MessageLookupByLibrary.simpleMessage(
            "La data inicial no pot ser més gran que la data final"),
        "errorFechaMenor": MessageLookupByLibrary.simpleMessage(
            "La data final no pot ser menor que la data inicial"),
        "errorMensaje":
            MessageLookupByLibrary.simpleMessage("Dades incorrectes"),
        "errorNoElPrimerDia":
            MessageLookupByLibrary.simpleMessage("No el primer dia"),
        "errorSeleccioneUnDocumento":
            MessageLookupByLibrary.simpleMessage("Seleccioneu un document"),
        "errorSeleccioneUnInforme":
            MessageLookupByLibrary.simpleMessage("Seleccioneu un informe"),
        "errorSeleccioneUnVehiculo":
            MessageLookupByLibrary.simpleMessage("Seleccioneu un vehicle"),
        "errorSinDatos":
            MessageLookupByLibrary.simpleMessage("No es van trobar dades"),
        "espanol": MessageLookupByLibrary.simpleMessage("Espanyol"),
        "etiquetaContrasena":
            MessageLookupByLibrary.simpleMessage("Contrasenya"),
        "etiquetaNombreDeUsuario":
            MessageLookupByLibrary.simpleMessage("Nom d\'usuari"),
        "generarInforme":
            MessageLookupByLibrary.simpleMessage("Generar informe"),
        "haceSieteDias": MessageLookupByLibrary.simpleMessage("Fa set dies"),
        "haceTresDias": MessageLookupByLibrary.simpleMessage("Fa tres dies"),
        "hoy": MessageLookupByLibrary.simpleMessage("Avui"),
        "idioma": MessageLookupByLibrary.simpleMessage("Idioma"),
        "informe": MessageLookupByLibrary.simpleMessage("Informe"),
        "ingles": MessageLookupByLibrary.simpleMessage("Angles"),
        "ingreseUnValor":
            MessageLookupByLibrary.simpleMessage("Introduïu un valor"),
        "labelAjustarCarretera":
            MessageLookupByLibrary.simpleMessage("Ajustar a carretera"),
        "labelAjustarPerfil":
            MessageLookupByLibrary.simpleMessage("Ajustar perfil"),
        "labelAlaUnidad": MessageLookupByLibrary.simpleMessage("a la unitat"),
        "labelAlerta": MessageLookupByLibrary.simpleMessage("alerta"),
        "labelAlertas": MessageLookupByLibrary.simpleMessage("Alertes"),
        "labelAltitud": MessageLookupByLibrary.simpleMessage("Altitud"),
        "labelAngulo": MessageLookupByLibrary.simpleMessage("Angle"),
        "labelApagado": MessageLookupByLibrary.simpleMessage("Apagat"),
        "labelArribo": MessageLookupByLibrary.simpleMessage("Sortida"),
        "labelBateriaInterna":
            MessageLookupByLibrary.simpleMessage("Bateria interna"),
        "labelBuscar": MessageLookupByLibrary.simpleMessage("Cerca"),
        "labelCambiarClave":
            MessageLookupByLibrary.simpleMessage("Canviar clau"),
        "labelCancelar": MessageLookupByLibrary.simpleMessage("Cancel·lar"),
        "labelComando": MessageLookupByLibrary.simpleMessage("Ordres"),
        "labelCombustible": MessageLookupByLibrary.simpleMessage("Combustible"),
        "labelConduccion": MessageLookupByLibrary.simpleMessage("Conducció"),
        "labelConductor": MessageLookupByLibrary.simpleMessage("Conductor"),
        "labelConfirmar": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "labelConfirmarContrasena":
            MessageLookupByLibrary.simpleMessage("Confirmar contrasenya"),
        "labelConsumo": MessageLookupByLibrary.simpleMessage("Consum"),
        "labelContrasenaNoCoincide": MessageLookupByLibrary.simpleMessage(
            "Les contrasenyes no coincideixen"),
        "labelCorreoElectronico":
            MessageLookupByLibrary.simpleMessage("Correu electronic"),
        "labelDesconectado":
            MessageLookupByLibrary.simpleMessage("Desconnectat"),
        "labelDesde": MessageLookupByLibrary.simpleMessage("Des de"),
        "labelDeseaEnviarElComando":
            MessageLookupByLibrary.simpleMessage("Voleu enviar l\'ordre"),
        "labelDetalle": MessageLookupByLibrary.simpleMessage("Detall"),
        "labelDetenido": MessageLookupByLibrary.simpleMessage("Detingut"),
        "labelDireccion": MessageLookupByLibrary.simpleMessage("Direcció"),
        "labelDispositivo": MessageLookupByLibrary.simpleMessage("Dispositiu"),
        "labelDispositivoPorVencer": m0,
        "labelDispositivos":
            MessageLookupByLibrary.simpleMessage("Dispositius"),
        "labelDistancia": MessageLookupByLibrary.simpleMessage("Distància"),
        "labelDuracion": MessageLookupByLibrary.simpleMessage("Durada"),
        "labelDuracionDeParada":
            MessageLookupByLibrary.simpleMessage("Duració de parada"),
        "labelEnLinea": MessageLookupByLibrary.simpleMessage("En línia"),
        "labelEncendido": MessageLookupByLibrary.simpleMessage("Encès"),
        "labelEvento": MessageLookupByLibrary.simpleMessage("Esdeveniment"),
        "labelExpandir": MessageLookupByLibrary.simpleMessage("Expandir"),
        "labelExpiracion": MessageLookupByLibrary.simpleMessage("Expiració"),
        "labelFecha": MessageLookupByLibrary.simpleMessage("data"),
        "labelFechaExpiracion":
            MessageLookupByLibrary.simpleMessage("Data d\'expiració"),
        "labelFinDeConduccion":
            MessageLookupByLibrary.simpleMessage("Fi de la conducció"),
        "labelFinalizo": MessageLookupByLibrary.simpleMessage("Finalitzat"),
        "labelFueraLinea":
            MessageLookupByLibrary.simpleMessage("Fora de línia"),
        "labelGenerarLink":
            MessageLookupByLibrary.simpleMessage("Generar link"),
        "labelHasta": MessageLookupByLibrary.simpleMessage("Fins a"),
        "labelHistorial": MessageLookupByLibrary.simpleMessage("Historial"),
        "labelInformacionDeContacto":
            MessageLookupByLibrary.simpleMessage("Informació de contacte"),
        "labelIniciarSesion":
            MessageLookupByLibrary.simpleMessage("Iniciar sessió"),
        "labelInicio": MessageLookupByLibrary.simpleMessage("Inici"),
        "labelIrA": m1,
        "labelLatitud": MessageLookupByLibrary.simpleMessage("Latitud"),
        "labelLineaAmarilla": MessageLookupByLibrary.simpleMessage(
            "Línia groga: velocitat menor a"),
        "labelLineaRoja": MessageLookupByLibrary.simpleMessage(
            "Línia vermella: velocitat major a"),
        "labelLineaVerde": MessageLookupByLibrary.simpleMessage(
            "Línia verda: velocitat menor a"),
        "labelLineasDeVelocidad":
            MessageLookupByLibrary.simpleMessage("Línies de velocitat"),
        "labelLongitud": MessageLookupByLibrary.simpleMessage("Longitud"),
        "labelMapa": MessageLookupByLibrary.simpleMessage("Mapa"),
        "labelMapas": MessageLookupByLibrary.simpleMessage("Mapes"),
        "labelMiUbicacion": MessageLookupByLibrary.simpleMessage("Mostra gir"),
        "labelMostrarDia": MessageLookupByLibrary.simpleMessage("Mostrar dia"),
        "labelMostrarHistorial":
            MessageLookupByLibrary.simpleMessage("Mostrar històric"),
        "labelMostrarMas": MessageLookupByLibrary.simpleMessage("Mostrar més"),
        "labelMostrarRecorrido":
            MessageLookupByLibrary.simpleMessage("Mostra recorregut"),
        "labelMotorInactivo":
            MessageLookupByLibrary.simpleMessage("Motor inactiu"),
        "labelNombre": MessageLookupByLibrary.simpleMessage("nom"),
        "labelNuevaContrasena":
            MessageLookupByLibrary.simpleMessage("Nova contrasenya"),
        "labelParada": MessageLookupByLibrary.simpleMessage("Parada"),
        "labelPartio": MessageLookupByLibrary.simpleMessage("Arribada"),
        "labelPerfil": MessageLookupByLibrary.simpleMessage("Perfil"),
        "labelPosicion": MessageLookupByLibrary.simpleMessage("posició"),
        "labelResumen": MessageLookupByLibrary.simpleMessage("Resum"),
        "labelRutas": MessageLookupByLibrary.simpleMessage("Geoprop"),
        "labelSalir": MessageLookupByLibrary.simpleMessage("Sortir"),
        "labelSeleccioneLaFechaVigente":
            MessageLookupByLibrary.simpleMessage("Seleccioneu la data vigent"),
        "labelSeleccioneUnaFecha":
            MessageLookupByLibrary.simpleMessage("Seleccioneu una data"),
        "labelSensores": MessageLookupByLibrary.simpleMessage("Sensors"),
        "labelSinAlertas":
            MessageLookupByLibrary.simpleMessage("Sense alertes"),
        "labelSinComandos":
            MessageLookupByLibrary.simpleMessage("Sense ordres"),
        "labelTelefono": MessageLookupByLibrary.simpleMessage("Telèfon"),
        "labelTiempo": MessageLookupByLibrary.simpleMessage("Temps"),
        "labelTodos": MessageLookupByLibrary.simpleMessage("Tots"),
        "labelUltimaConexion":
            MessageLookupByLibrary.simpleMessage("Ultima connexio"),
        "labelVelocidad": MessageLookupByLibrary.simpleMessage("velocitat"),
        "labelVelocidadMaxima":
            MessageLookupByLibrary.simpleMessage("Velocitat Maxima"),
        "labelVerUbicacion":
            MessageLookupByLibrary.simpleMessage("Veure ubicació"),
        "labelVistaDeCalle":
            MessageLookupByLibrary.simpleMessage("Vista de carrer"),
        "labelmostrarMenos":
            MessageLookupByLibrary.simpleMessage("Mostrar menys"),
        "labelmostrarRecorrido":
            MessageLookupByLibrary.simpleMessage("Mostra recorregut"),
        "lockEngine": MessageLookupByLibrary.simpleMessage("Bloquejar motor"),
        "manana": MessageLookupByLibrary.simpleMessage("Demà"),
        "mensaje": MessageLookupByLibrary.simpleMessage("Missatge"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "problemasAlDescargarElArchivo": MessageLookupByLibrary.simpleMessage(
            "Problemes en descarregar l\'arxiu"),
        "prosecat": MessageLookupByLibrary.simpleMessage(
            "Sistema de Rastreig Satelital"),
        "puntosDeInteres":
            MessageLookupByLibrary.simpleMessage("Punts d\'interès"),
        "seHaEnviadoElComando":
            MessageLookupByLibrary.simpleMessage("S\'ha enviat l\'ordre"),
        "seleccioneUnValor":
            MessageLookupByLibrary.simpleMessage("Seleccioneu un valor"),
        "si": MessageLookupByLibrary.simpleMessage("Si"),
        "tipoDeDocumento":
            MessageLookupByLibrary.simpleMessage("Tipus de document"),
        "tipoDeInforme":
            MessageLookupByLibrary.simpleMessage("Tipus d\'informe"),
        "tituloCompartir": MessageLookupByLibrary.simpleMessage("Compartir"),
        "validacionContrasena": MessageLookupByLibrary.simpleMessage(
            "La contrasenya ha de ser superior a 6 caràcters"),
        "validacionIdioma":
            MessageLookupByLibrary.simpleMessage("Selecciona una opció"),
        "validacionNombreDeUsuario": MessageLookupByLibrary.simpleMessage(
            "El valor ingressat no és un correu"),
        "vehiculos": MessageLookupByLibrary.simpleMessage("Vehicle(s)")
      };
}
