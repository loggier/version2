import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  // Reproductor de audio
  static AudioPlayer _audioPlayer = AudioPlayer()
    ..setLoopMode(LoopMode.off) // Desactiva el loop
    ..setVolume(1.0); // Volumen al máximo

  // Texto a voz
  static FlutterTts flutterTts = FlutterTts();

  set messageStream(String msg) {
    _messageStream.add(msg);
  }

  @pragma('vm:entry-point')
  static Future<void> backgroundNotificationHandler(
      RemoteMessage message) async {
    print('Notificación en segundo plano: ${message.data}');
    // Llama a la función de la clase para reproducir el sonido
    await PushNotificationService.playCustomNotificationSound(
        message.data['message'] ?? 'Alerta personalizada');
  }

  // Cuando la app está minimizada
  @pragma('vm:entry-point')
  static Future _backgroundHandler(RemoteMessage message) async {
    print('Notificación en segundo plano: ${message.data}');
    await playCustomNotificationSound(
        message.data['message'] ?? 'Alerta personalizada');
  }

  // Cuando la app está abierta
  static Future _onMessageHandler(RemoteMessage message) async {
    _messageStream.add(message.notification?.title ?? 'No title');
    await playCustomNotificationSound(
        message.data['message'] ?? 'Alerta personalizada');
  }

  // Cuando la app está cerrada completamente
  static Future _onMessageOpenApp(RemoteMessage message) async {
    _messageStream.add(message.notification?.title ?? 'No title');
    await playCustomNotificationSound(
        message.data['message'] ?? 'Alerta personalizada');
  }

  // Inicialización de Firebase y notificaciones
  static Future initializeApp() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

    token = await FirebaseMessaging.instance.getToken();
    final permissionGranted = await _getNotificationPermission();

    if (permissionGranted == AuthorizationStatus.authorized ||
        permissionGranted == AuthorizationStatus.provisional) {
      FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
      FirebaseMessaging.onMessage.listen(_onMessageHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

      // Inicializa notificaciones locales
      await initializeLocalNotifications();
    } else if (permissionGranted == AuthorizationStatus.notDetermined) {
      _getNotificationPermission();
    }

    // Manejar errores de reproducción
    _audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      print('Error en reproducción: $e');
    });
  }

  // Cerrar streams y liberar el reproductor
  static closeStreams() {
    _messageStream.close();
    _audioPlayer.dispose();
  }

  // Obtener permisos de notificaciones
  static Future _getNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      provisional: true,
      sound: true,
    );
    return settings.authorizationStatus;
  }

  // Obtener preferencia de alerta de voz
  static Future<bool> getVoiceAlertPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('voiceAlertEnabled') ?? false;
  }

  // Reproducir sonido personalizado y TTS
  static Future<void> playCustomNotificationSound(String text) async {
    try {
      //  bool isVoiceAlertEnabled = await getVoiceAlertPreference();

      // Reproducir sonido personalizado
      /*  await _audioPlayer
          .setAsset('assets/sounds/alert.mp3'); // Ruta del archivo

      // Esperar 2 segundos antes del TTS (si lo necesitas)
      await Future.delayed(const Duration(seconds: 2));

      // Reproducir TTS si está habilitado
      if (isVoiceAlertEnabled && text.isNotEmpty) {
        await flutterTts.setLanguage("es-ES");
        await flutterTts.speak(text);
      } else {
        await _audioPlayer.play();
      }*/
    } catch (e) {
      print('Error al reproducir sonido: $e');
    }
  }

  // Detener la reproducción
  static Future<void> stopNotificationSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.dispose();
      _audioPlayer = AudioPlayer(); // Reiniciar instancia
    } catch (e) {
      print('Error deteniendo sonido: $e');
    }
  }

  // Notificaciones locales
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  // Inicializar notificaciones locales
  static Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // ID que debe coincidir con el configurado en AndroidManifest.xml (si es que lo usas)
      'Rastreo', // Nombre visible del canal
      description: 'App de rastreo', // Descripción opcional
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('alarm'),
    );
    // Define un canal personalizado

    final List<AndroidNotificationChannel> channels = [
      const AndroidNotificationChannel(
        'device_subscription_expired', // ID
        'Device Subscription Expired', // Nombre visible
        description:
            'Canal para notificaciones de device_subscription_expired', // Descripción
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound:
            RawResourceAndroidNotificationSound('device_subscription_expired'),
      ),
      const AndroidNotificationChannel(
        'distance',
        'Distance',
        description: 'Canal para notificaciones de distance',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('distance'),
      ),
      const AndroidNotificationChannel(
        'driver',
        'Driver',
        description: 'Canal para notificaciones de driver',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('driver'),
      ),
      const AndroidNotificationChannel(
        'driver_authorized',
        'Driver Authorized',
        description: 'Canal para notificaciones de driver_authorized',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('driver_authorized'),
      ),
      const AndroidNotificationChannel(
        'driver_change',
        'Driver Change',
        description: 'Canal para notificaciones de driver_change',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('driver_change'),
      ),
      const AndroidNotificationChannel(
        'driver_unauthorized',
        'Driver Unauthorized',
        description: 'Canal para notificaciones de driver_unauthorized',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('driver_unauthorized'),
      ),
      const AndroidNotificationChannel(
        'expired_device',
        'Expired Device',
        description: 'Canal para notificaciones de expired_device',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('expired_device'),
      ),
      const AndroidNotificationChannel(
        'expired_sim',
        'Expired SIM',
        description: 'Canal para notificaciones de expired_sim',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('expired_sim'),
      ),
      const AndroidNotificationChannel(
        'expired_user',
        'Expired User',
        description: 'Canal para notificaciones de expired_user',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('expired_user'),
      ),
      const AndroidNotificationChannel(
        'expiring_device',
        'Expiring Device',
        description: 'Canal para notificaciones de expiring_device',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('expiring_device'),
      ),
      const AndroidNotificationChannel(
        'expiring_sim',
        'Expiring SIM',
        description: 'Canal para notificaciones de expiring_sim',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('expiring_sim'),
      ),
      const AndroidNotificationChannel(
        'expiring_user',
        'Expiring User',
        description: 'Canal para notificaciones de expiring_user',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('expiring_user'),
      ),
      const AndroidNotificationChannel(
        'fuel_fill',
        'Fuel Fill',
        description: 'Canal para notificaciones de fuel_fill',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('fuel_fill'),
      ),
      const AndroidNotificationChannel(
        'fuel_theft',
        'Fuel Theft',
        description: 'Canal para notificaciones de fuel_theft',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('fuel_theft'),
      ),
      const AndroidNotificationChannel(
        'idle_duration',
        'Idle Duration',
        description: 'Canal para notificaciones de idle_duration',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('idle_duration'),
      ),
      const AndroidNotificationChannel(
        'ignition_duration',
        'Ignition Duration',
        description: 'Canal para notificaciones de ignition_duration',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('ignition_duration'),
      ),
      const AndroidNotificationChannel(
        'ignition_off',
        'Ignition Off',
        description: 'Canal para notificaciones de ignition_off',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('ignition_off'),
      ),
      const AndroidNotificationChannel(
        'ignition_on',
        'Ignition On',
        description: 'Canal para notificaciones de ignition_on',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('ignition_on'),
      ),
      const AndroidNotificationChannel(
        'move_start',
        'Move Start',
        description: 'Canal para notificaciones de move_start',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('move_start'),
      ),
      const AndroidNotificationChannel(
        'offline_duration',
        'Offline Duration',
        description: 'Canal para notificaciones de offline_duration',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('offline_duration'),
      ),
      const AndroidNotificationChannel(
        'overspeed',
        'Overspeed',
        description: 'Canal para notificaciones de overspeed',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('overspeed'),
      ),
      const AndroidNotificationChannel(
        'plugged_in',
        'Plugged In',
        description: 'Canal para notificaciones de plugged_in',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('plugged_in'),
      ),
      const AndroidNotificationChannel(
        'poi_idle_duration',
        'POI Idle Duration',
        description: 'Canal para notificaciones de poi_idle_duration',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('poi_idle_duration'),
      ),
      const AndroidNotificationChannel(
        'poi_stop_duration',
        'POI Stop Duration',
        description: 'Canal para notificaciones de poi_stop_duration',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('poi_stop_duration'),
      ),
      const AndroidNotificationChannel(
        'sos',
        'SOS',
        description: 'Canal para notificaciones de sos',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('sos'),
      ),
      // stop_duration ya lo tienes definido, pero lo incluyo para completar la lista:
      const AndroidNotificationChannel(
        'stop_duration',
        'Stop Duration Channel',
        description: 'Canal para notificaciones de duración de parada',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('stop_duration'),
      ),
      const AndroidNotificationChannel(
        'task_complete',
        'Task Complete',
        description: 'Canal para notificaciones de task_complete',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('task_complete'),
      ),
      const AndroidNotificationChannel(
        'task_failed',
        'Task Failed',
        description: 'Canal para notificaciones de task_failed',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('task_failed'),
      ),
      const AndroidNotificationChannel(
        'task_in_progress',
        'Task In Progress',
        description: 'Canal para notificaciones de task_in_progress',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('task_in_progress'),
      ),
      const AndroidNotificationChannel(
        'task_new',
        'Task New',
        description: 'Canal para notificaciones de task_new',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('task_new'),
      ),
      const AndroidNotificationChannel(
        'time_duration',
        'Time Duration',
        description: 'Canal para notificaciones de time_duration',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('time_duration'),
      ),
      const AndroidNotificationChannel(
        'unplugged',
        'Unplugged',
        description: 'Canal para notificaciones de unplugged',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('unplugged'),
      ),
      const AndroidNotificationChannel(
        'zone_in',
        'Zone In',
        description: 'Canal para notificaciones de zone_in',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('zone_in'),
      ),
      const AndroidNotificationChannel(
        'zone_out',
        'Zone Out',
        description: 'Canal para notificaciones de zone_out',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('zone_out'),
      ),
    ];

    final androidImpl =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    for (final channel in channels) {
      await androidImpl?.createNotificationChannel(channel);
    }

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,
    );
  }
  // Define y crea el canal de notificaciones

  // Manejar el tap de la notificación
  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  // Cancelar notificación
  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
