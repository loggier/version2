import 'package:flutter/material.dart';

//Para mostrar una pantalla de carga cuando el correo y contraseña del usuario son evaluados
class NotificationService {
  //con esto mantengo la referencia de un key en el main/material scaffoldMessengerKey:
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //Con esto mostramos la alerta o mensaje
  //para mandarlo a llamar usamos la llave mesengerKey
  //Es una alerta que aparece en la parte de abajo de la pantalla
  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
