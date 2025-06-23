// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: 'tienes 1 dispositivo por vencer', other: 'tienes ${howMany} dispositivos por vencer')}";

  static String m1(ruta) => "Ir a ${ruta}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aceptarMensaje": MessageLookupByLibrary.simpleMessage("Aceptar"),
        "anteayer": MessageLookupByLibrary.simpleMessage("Anteayer"),
        "archivoDescargado":
            MessageLookupByLibrary.simpleMessage("Archivo descargado"),
        "ayer": MessageLookupByLibrary.simpleMessage("Ayer"),
        "bloquear": MessageLookupByLibrary.simpleMessage("Bloquear"),
        "catalan": MessageLookupByLibrary.simpleMessage("Catalán"),
        "center": MessageLookupByLibrary.simpleMessage("Centrar"),
        "consultar": MessageLookupByLibrary.simpleMessage("Consultar"),
        "desbloquear": MessageLookupByLibrary.simpleMessage("Desbloquear"),
        "desbloquearMotor":
            MessageLookupByLibrary.simpleMessage("Desbloquear motor"),
        "descripcion": MessageLookupByLibrary.simpleMessage("Descripción"),
        "errorAlObtenerLosInformes": MessageLookupByLibrary.simpleMessage(
            "Error al obtener los informes"),
        "errorFechaMayor": MessageLookupByLibrary.simpleMessage(
            "La fecha inicial no puede ser mayor que la fecha final"),
        "errorFechaMenor": MessageLookupByLibrary.simpleMessage(
            "La fecha final no puede ser menor que la fecha inicial"),
        "errorMensaje":
            MessageLookupByLibrary.simpleMessage("Datos incorrectos"),
        "errorNoElPrimerDia":
            MessageLookupByLibrary.simpleMessage("No el primer día"),
        "errorSeleccioneUnDocumento":
            MessageLookupByLibrary.simpleMessage("Seleccione un documento"),
        "errorSeleccioneUnInforme":
            MessageLookupByLibrary.simpleMessage("Seleccione un informe"),
        "errorSeleccioneUnVehiculo":
            MessageLookupByLibrary.simpleMessage("Seleccione un vehículo"),
        "errorSinDatos":
            MessageLookupByLibrary.simpleMessage("No se encontraron datos"),
        "espanol": MessageLookupByLibrary.simpleMessage("Español"),
        "etiquetaContrasena":
            MessageLookupByLibrary.simpleMessage("Contraseña"),
        "etiquetaNombreDeUsuario":
            MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
        "generarInforme":
            MessageLookupByLibrary.simpleMessage("Generar informe"),
        "haceSieteDias":
            MessageLookupByLibrary.simpleMessage("Hace siete días"),
        "haceTresDias": MessageLookupByLibrary.simpleMessage("Hace tres días"),
        "hoy": MessageLookupByLibrary.simpleMessage("Hoy"),
        "idioma": MessageLookupByLibrary.simpleMessage("Idioma"),
        "informe": MessageLookupByLibrary.simpleMessage("Informe"),
        "ingles": MessageLookupByLibrary.simpleMessage("Ingles"),
        "ingreseUnValor":
            MessageLookupByLibrary.simpleMessage("Ingrese un valor"),
        "labelAjustarCarretera":
            MessageLookupByLibrary.simpleMessage("Ajustar a carretera"),
        "labelAjustarPerfil":
            MessageLookupByLibrary.simpleMessage("Ajustar perfil"),
        "labelAlaUnidad": MessageLookupByLibrary.simpleMessage("a la unidad"),
        "labelAlerta": MessageLookupByLibrary.simpleMessage("Alerta"),
        "labelAlertas": MessageLookupByLibrary.simpleMessage("Alertas"),
        "labelAltitud": MessageLookupByLibrary.simpleMessage("Altitud"),
        "labelAngulo": MessageLookupByLibrary.simpleMessage("Ángulo"),
        "labelApagado": MessageLookupByLibrary.simpleMessage("Apagado"),
        "labelArribo": MessageLookupByLibrary.simpleMessage("Arribó"),
        "labelBateriaInterna":
            MessageLookupByLibrary.simpleMessage("Bateria interna"),
        "labelBuscar": MessageLookupByLibrary.simpleMessage("Buscar"),
        "labelCambiarClave":
            MessageLookupByLibrary.simpleMessage("Cambiar clave"),
        "labelCancelar": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "labelComando": MessageLookupByLibrary.simpleMessage("Comandos"),
        "labelCombustible": MessageLookupByLibrary.simpleMessage("Combustible"),
        "labelConduccion": MessageLookupByLibrary.simpleMessage("Conducción"),
        "labelConductor": MessageLookupByLibrary.simpleMessage("Conductor"),
        "labelConfirmar": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "labelConfirmarContrasena":
            MessageLookupByLibrary.simpleMessage("Confirmar contraseña"),
        "labelConsumo": MessageLookupByLibrary.simpleMessage("Consumo"),
        "labelContrasenaNoCoincide": MessageLookupByLibrary.simpleMessage(
            "Las contraseñas no coinciden"),
        "labelCorreoElectronico":
            MessageLookupByLibrary.simpleMessage("Correo electrónico"),
        "labelDesconectado":
            MessageLookupByLibrary.simpleMessage("Desconectado"),
        "labelDesde": MessageLookupByLibrary.simpleMessage("Desde"),
        "labelDeseaEnviarElComando":
            MessageLookupByLibrary.simpleMessage("Desea enviar el comando"),
        "labelDetalle": MessageLookupByLibrary.simpleMessage("Detalle"),
        "labelDetenido": MessageLookupByLibrary.simpleMessage("Detenido"),
        "labelDireccion": MessageLookupByLibrary.simpleMessage("Dirección"),
        "labelDispositivo": MessageLookupByLibrary.simpleMessage("Dispositivo"),
        "labelDispositivoPorVencer": m0,
        "labelDispositivos":
            MessageLookupByLibrary.simpleMessage("Dispositivos"),
        "labelDistancia": MessageLookupByLibrary.simpleMessage("Distancia"),
        "labelDuracion": MessageLookupByLibrary.simpleMessage("Duración"),
        "labelDuracionDeParada":
            MessageLookupByLibrary.simpleMessage("Duración de parada"),
        "labelEnLinea": MessageLookupByLibrary.simpleMessage("En línea"),
        "labelEncendido": MessageLookupByLibrary.simpleMessage("Encendido"),
        "labelEvento": MessageLookupByLibrary.simpleMessage("Evento"),
        "labelExpandir": MessageLookupByLibrary.simpleMessage("Expandir"),
        "labelExpiracion": MessageLookupByLibrary.simpleMessage("Expiración"),
        "labelFecha": MessageLookupByLibrary.simpleMessage("Fecha"),
        "labelFechaExpiracion":
            MessageLookupByLibrary.simpleMessage("Fecha de expiración"),
        "labelFinDeConduccion":
            MessageLookupByLibrary.simpleMessage("Fin de conducción"),
        "labelFinalizo": MessageLookupByLibrary.simpleMessage("Finalizado"),
        "labelFueraLinea":
            MessageLookupByLibrary.simpleMessage("Fuera de línea"),
        "labelGenerarLink":
            MessageLookupByLibrary.simpleMessage("Generar link"),
        "labelHasta": MessageLookupByLibrary.simpleMessage("Hasta"),
        "labelHistorial": MessageLookupByLibrary.simpleMessage("Historial"),
        "labelInformacionDeContacto":
            MessageLookupByLibrary.simpleMessage("Información de contacto"),
        "labelIniciarSesion":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "labelInicio": MessageLookupByLibrary.simpleMessage("Inicio"),
        "labelIrA": m1,
        "labelLatitud": MessageLookupByLibrary.simpleMessage("Latitud"),
        "labelLineaAmarilla": MessageLookupByLibrary.simpleMessage(
            "Línea amarilla: velocidad menor a"),
        "labelLineaRoja": MessageLookupByLibrary.simpleMessage(
            "Línea roja: velocidad mayor a"),
        "labelLineaVerde": MessageLookupByLibrary.simpleMessage(
            "Línea verde: velocidad menor a"),
        "labelLineasDeVelocidad":
            MessageLookupByLibrary.simpleMessage("Líneas de velocidad"),
        "labelLongitud": MessageLookupByLibrary.simpleMessage("Longitud"),
        "labelMapa": MessageLookupByLibrary.simpleMessage("Mapa"),
        "labelMapas": MessageLookupByLibrary.simpleMessage("Mapas"),
        "labelMiUbicacion":
            MessageLookupByLibrary.simpleMessage("Mostrar giro"),
        "labelMostrarDia": MessageLookupByLibrary.simpleMessage("Mostrar día"),
        "labelMostrarHistorial":
            MessageLookupByLibrary.simpleMessage("Mostrar Historial"),
        "labelMostrarMas": MessageLookupByLibrary.simpleMessage("Mostrar más"),
        "labelMostrarRecorrido":
            MessageLookupByLibrary.simpleMessage("Mostrar recorrido"),
        "labelMotorInactivo":
            MessageLookupByLibrary.simpleMessage("Motor inactivo"),
        "labelNombre": MessageLookupByLibrary.simpleMessage("Nombre"),
        "labelNuevaContrasena":
            MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
        "labelParada": MessageLookupByLibrary.simpleMessage("Parada"),
        "labelPartio": MessageLookupByLibrary.simpleMessage("Partió"),
        "labelPerfil": MessageLookupByLibrary.simpleMessage("Perfil"),
        "labelPosicion": MessageLookupByLibrary.simpleMessage("Posición"),
        "labelResumen": MessageLookupByLibrary.simpleMessage("Resumen"),
        "labelRutas": MessageLookupByLibrary.simpleMessage("Geocercas"),
        "labelSalir": MessageLookupByLibrary.simpleMessage("Salir"),
        "labelSeleccioneLaFechaVigente": MessageLookupByLibrary.simpleMessage(
            "Seleccione la fecha de vigencia"),
        "labelSeleccioneUnaFecha":
            MessageLookupByLibrary.simpleMessage("Seleccione una fecha"),
        "labelSensores": MessageLookupByLibrary.simpleMessage("Sensores"),
        "labelSinAlertas": MessageLookupByLibrary.simpleMessage("Sin alertas"),
        "labelSinComandos":
            MessageLookupByLibrary.simpleMessage("Sin comandos"),
        "labelTelefono": MessageLookupByLibrary.simpleMessage("Teléfono"),
        "labelTiempo": MessageLookupByLibrary.simpleMessage("Tiempo"),
        "labelTodos": MessageLookupByLibrary.simpleMessage("Todos"),
        "labelUltimaConexion":
            MessageLookupByLibrary.simpleMessage("Últ. Conexión"),
        "labelVelocidad": MessageLookupByLibrary.simpleMessage("Velocidad"),
        "labelVelocidadMaxima":
            MessageLookupByLibrary.simpleMessage("Velocidad Máxima"),
        "labelVerUbicacion":
            MessageLookupByLibrary.simpleMessage("Ver ubicación"),
        "labelVistaDeCalle":
            MessageLookupByLibrary.simpleMessage("Vista de calle"),
        "labelmostrarMenos":
            MessageLookupByLibrary.simpleMessage("Mostrar menos"),
        "labelmostrarRecorrido":
            MessageLookupByLibrary.simpleMessage("Mostrar recorrido"),
        "lockEngine": MessageLookupByLibrary.simpleMessage("Bloquear motor"),
        "manana": MessageLookupByLibrary.simpleMessage("Mañana"),
        "mensaje": MessageLookupByLibrary.simpleMessage("Mensaje"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "problemasAlDescargarElArchivo": MessageLookupByLibrary.simpleMessage(
            "Problemas al descargar el archivo"),
        "prosecat": MessageLookupByLibrary.simpleMessage(
            "Sistema de Rastreo Satelital"),
        "puntosDeInteres":
            MessageLookupByLibrary.simpleMessage("Puntos de interés"),
        "seHaEnviadoElComando":
            MessageLookupByLibrary.simpleMessage("Se ha enviado el comando"),
        "seleccioneUnValor":
            MessageLookupByLibrary.simpleMessage("Seleccione un valor"),
        "si": MessageLookupByLibrary.simpleMessage("Si"),
        "tipoDeDocumento":
            MessageLookupByLibrary.simpleMessage("Tipo de documento"),
        "tipoDeInforme":
            MessageLookupByLibrary.simpleMessage("Tipo de informe"),
        "tituloCompartir": MessageLookupByLibrary.simpleMessage("Compartir"),
        "validacionContrasena": MessageLookupByLibrary.simpleMessage(
            "La contraseña debe ser mayor a 6 caracteres"),
        "validacionIdioma":
            MessageLookupByLibrary.simpleMessage("Selecciona una opción"),
        "validacionNombreDeUsuario": MessageLookupByLibrary.simpleMessage(
            "El valor ingresado no es un correo"),
        "vehiculos": MessageLookupByLibrary.simpleMessage("vehículo(s)")
      };
}
