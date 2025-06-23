import UIKit
import Flutter
import Firebase
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  // ...

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
       FirebaseApp.configure()
      UNUserNotificationCenter.current().delegate = self

       let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
       UNUserNotificationCenter.current().requestAuthorization(
         options: authOptions,
         completionHandler: { _, _ in }
       )
       application.registerForRemoteNotifications()
      
      GMSServices.provideAPIKey("AIzaSyAeDj72bFMG90foSkJiW2ArtBOR9r9ckpc")
    GeneratedPluginRegistrant.register(with: self)

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
      // Aquí puedes convertir el token de dispositivo a string si es necesario
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")

      // Aquí se debe pasar el token de dispositivo a Firebase Messaging
      Messaging.messaging().apnsToken = deviceToken
  }

  override func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
      // Maneja el caso de error al registrar para notificaciones
      print("Failed to register for remote notifications: \(error)")
  }

  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
      // Maneja la notificación recibida cuando la app está en primer plano, en background o cerrada
      if let messageID = userInfo["gcm.message_id"] {
          print("Message ID: \(messageID)")
      }

      // Imprime toda la info de la notificación
      print(userInfo)

      // Llama al manejador de finalización una vez que hayas terminado de procesar la notificación
      completionHandler(UIBackgroundFetchResult.newData)
  }

  // ...
}  

