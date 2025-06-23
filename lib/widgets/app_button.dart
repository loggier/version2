import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final String goTo;
  
  const AppButton({
    super.key, required this.backgroundColor, required this.label, required this.goTo,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      disabledColor: Colors.grey,
      elevation: 0,
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () {
        switch (goTo) {
          case 'map_screen':
            // Navigator.pushNamed(context, 'map_screen');
            // Aquí puedes colocar el código que deseas ejecutar para la ruta 'map_screen'
            break;
          case 'otra_ruta':
            // Aquí puedes colocar el código que deseas ejecutar para otra ruta
            break;
          // Agrega más casos según sea necesario
          default:
            // Aquí puedes colocar el código que deseas ejecutar por defecto si no se cumple ningún caso
            break;
        }
      },
    );
  }
}