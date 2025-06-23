import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/preferences/preference.dart';

import 'package:prosecat/ui/ui.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    PushNotificationService.initializeApp();
  }
  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);    
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);    

    double screenWidth = MediaQuery.of(context).size.width;    
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              
              if(loginForm.getIsLoading) const LoadingScreen(),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/logo.png', ),
                    width: (screenWidth * 70) / 100,
                  ),
                  Form(
                    key: loginForm.formKey,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
                        // height: (screenHeight * 2) / 100,
                        // color: Colors.amber,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: DecorationInputs.authDecorationInput(
                                context,
                                hintText: 'test@gps.com', 
                                labelText: S.of(context).etiquetaNombreDeUsuario,
                                prefixIcon: Icons.account_circle_outlined
                              ),
                              onChanged: (value) => loginForm.email = value,
                              validator: (value) {
                                String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(pattern);
                      
                                return regExp.hasMatch(value ?? '')
                                  ? null
                                  : S.of(context).validacionNombreDeUsuario;
                              },
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              obscureText: true,
                              decoration: DecorationInputs.authDecorationInput(
                                context,
                                hintText: '********', 
                                labelText: S.of(context).etiquetaContrasena,
                                prefixIcon: Icons.lock_outline
                              ),
                              onChanged: (value) => loginForm.password = value,
                              validator: (value) {
                                //si el valor no esta vacio y es mayor o igual a 6 no regresa nada
                                //si no regresa la advertencia de 'La contraseña debe...'
                                return (value != null && value.length >= 6)
                                    ? null
                                    : S.of(context).validacionContrasena;
                              },
                            ),
                            SizedBox(
                              // width: (screenWidth * 25) / 100,
                              // decoration: const BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(color: Colors.grey, width: 1), // Establece el borde inferior
                              //     ),
                              //   ),
                              child: DropdownButtonFormField<String>(
                                isExpanded: false,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                hint: Text(S.of(context).idioma),
                                decoration: const InputDecoration(border: InputBorder.none),                                           
                                items: [
                                  DropdownMenuItem(value: 'es', child: Text(S.of(context).espanol)),
                                  DropdownMenuItem(value: 'en', child: Text(S.of(context).ingles)),
                                  DropdownMenuItem(value: 'ca', child: Text(S.of(context).catalan)),
                                ], 
                                onChanged: (value){
                                  Preferences.idioma = value!;
                                  S.load(Locale(Preferences.idioma));                                
                                  setState(() {                                  
                                  });
                                },
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey, width: 1), // Establece el borde inferior
                                  ),
                                ),
                              margin: const EdgeInsets.only(bottom: 15),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
                              child: CustomMaterialButton(
                                label: S.of(context).labelIniciarSesion, 
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                onPressed: (loginForm.getIsLoading)
                                  ? null 
                                  : () async {
                                    
                                                
                                    FocusScope.of(context).unfocus();
                                                
                                    if(!loginForm.isValidForm()) return ;
                                    
                                    loginForm.setIsLoagind = true;
                                                
                                    final authService = Provider.of<AuthService>(context, listen: false);
                                                
                                    final response = await authService.authUser(loginForm.email, loginForm.password);
                                                
                                    if (response == 0) {
                                      loginForm.setIsLoagind = false;
                                      
                                      await showMyDialog(
                                              navigatorKey.currentContext!, 
                                              S.current.mensaje, 
                                              S.current.errorMensaje, 
                                              S.current.aceptarMensaje);                            
                                      return;
                                    } else {                         
                                      
                                      deviceProvider.updateUserToken();
                                      loginForm.setIsLoagind = false;
                                      Navigator.pushReplacementNamed(navigatorKey.currentContext!, 'home_screen');                                        
                                    
                                      deviceProvider.resume();
                                      deviceProvider.devicesResponse.clear();

                                      // deviceProvider.getAllDevice();
                                                
                                      // final mapController = Provider.of<MapController>(context, listen: false);    
                                      // await mapController.fillItems();
                                      
                                      return;
                                    }
                                },
                              ),
                            ),                      
                          ],
                        ),
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: LoginFooter(screenWidth: screenWidth),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,      
    );
  }
}
