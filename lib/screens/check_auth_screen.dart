// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prosecat/screens/screens.dart';
import 'package:prosecat/services/services.dart';
import 'package:provider/provider.dart';

import '../widgets/loading_screen.dart';

//Verifica si el usuario esta autenticado para redirigir a login o a la pantalla principal
class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (context, AsyncSnapshot<String> snapshot){
            if (!snapshot.hasData) {
              return const LoadingScreen(); //Cambiar por animacion de carga
            }

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginScreen(), 
                  transitionDuration: const Duration(seconds: 0), 
                ));
              });              
            }else{
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const HomeScreen(), 
                  transitionDuration: const Duration(seconds: 0), 
                ));
              }); 
            }


            return Container();
          },
        ),
      ),
    );
  }
}