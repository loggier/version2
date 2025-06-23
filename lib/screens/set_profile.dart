import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/models/user_data.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:prosecat/services/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/ui.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({super.key});

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  bool _isVoiceAlertEnabled = false;
  @override
  void initState() {
    super.initState();
    _loadVoiceAlertPreference();

    Provider.of<SetProfileProvider>(context, listen: false).setEmail();
  }

  Future<bool> getVoiceAlertPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Devuelve el valor de 'voiceAlertEnabled', si no existe devuelve 'false' por defecto.
    return prefs.getBool('voiceAlertEnabled') ?? false;
  }

  // Cargar la preferencia almacenada
  _loadVoiceAlertPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isVoiceAlertEnabled = prefs.getBool('voiceAlertEnabled') ?? false;
    });
  }

  // Guardar la preferencia en almacenamiento local
  _saveVoiceAlertPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('voiceAlertEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final profileProvider = Provider.of<SetProfileProvider>(context);
    final deviceProvider = Provider.of<DeviceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Provider.of<DeviceProvider>(context, listen: false).getUserData();
            },
            child: Text(S.of(context).labelAjustarPerfil)),
      ),
      body: PopScope(
        onPopInvoked: (bool value) {
          Provider.of<DeviceProvider>(context, listen: false).resume();
        },
        child: SafeArea(
          child: Form(
            key: profileProvider.formKey,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: (screenWidth * 90) / 100,
                // height: (screenHeight * 25) / 100,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 200, maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Input de email
                      TextFormField(
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: profileProvider.getEmail,
                            prefixIcon: Icon(Icons.alternate_email_outlined,
                                color: Theme.of(context).colorScheme.primary)),
                      ),

                      //Input de contraseña
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: DecorationInputs.authDecorationInput(
                            context,
                            hintText: '********',
                            labelText: S.of(context).labelNuevaContrasena,
                            prefixIcon: Icons.lock_outline),
                        onChanged: (value) => profileProvider.password = value,
                        validator: (value) {
                          return (value != null && value.length >= 6)
                              ? null
                              : S.of(context).validacionContrasena;
                        },
                      ),

                      //Input de repetir la contraseña
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: DecorationInputs.authDecorationInput(
                            context,
                            hintText: '********',
                            labelText: S.of(context).labelConfirmarContrasena,
                            prefixIcon: Icons.lock_outline),
                        onChanged: (value) =>
                            profileProvider.passwordConfirmation = value,
                        validator: (value) {
                          return (value != null &&
                                  value.length >= 6 &&
                                  profileProvider.password ==
                                      profileProvider.passwordConfirmation)
                              ? null
                              : S.current.labelContrasenaNoCoincide;
                        },
                      ),
                      // Switch para activar/desactivar alerta por voz
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Activar alerta de Voz (Beta)'),
                          Switch(
                            value: _isVoiceAlertEnabled,
                            onChanged: (value) {
                              setState(() {
                                _isVoiceAlertEnabled = value;
                              });
                              _saveVoiceAlertPreference(value);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: 200, maxWidth: 400),
                        child: CustomMaterialButton(
                          label: S.of(context).labelCambiarClave,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          onPressed: (profileProvider.getIsLoading)
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();

                                  if (!profileProvider.isValidForm()) return;

                                  profileProvider.setIsLoagind = true;

                                  final deviceProvider =
                                      Provider.of<DeviceProvider>(context,
                                          listen: false);
                                  final response =
                                      await deviceProvider.updatePassword(
                                          profileProvider.password,
                                          profileProvider.passwordConfirmation);

                                  if (response == 0) {
                                    profileProvider.setIsLoagind = false;
                                    //mensaje de error
                                    await showMyDialog(
                                        navigatorKey.currentContext!,
                                        S.current.mensaje,
                                        S.current.errorMensaje,
                                        S.current.aceptarMensaje);
                                    return;
                                  } else {
                                    //Mensaje de todo salio bien
                                    profileProvider.setIsLoagind = false;
                                    AuthService().logout();
                                    Navigator.pushNamedAndRemoveUntil(
                                        navigatorKey.currentContext!,
                                        'login',
                                        (route) => false);
                                    // Navigator.pushReplacementNamed(context, 'login');
                                    // Navigator.popUntil(context, (route) => false)
                                    return;
                                  }
                                },
                        ),
                      ),

                      const SizedBox(height: 5),

                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: 200, maxWidth: 400),
                        child: CustomMaterialButton(
                          label: S.of(context).labelCancelar,
                          backgroundColor: Colors.grey.shade800,
                          onPressed: () {
                            profileProvider.passwordConfirmation = '';
                            profileProvider.password = '';
                            Navigator.pop(context);
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      //Informacion de contacto
                      SizedBox(
                          height: (screenHeight * 30) / 100,
                          child: (deviceProvider.userData == null)
                              ? FutureBuilder<UserData>(
                                  future: deviceProvider.getUserData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData &&
                                        snapshot.data != null &&
                                        snapshot.data!.manager != null) {
                                      final userData = snapshot.data;
                                      return ContactInformation(
                                          userData: userData);
                                    }
                                    return Container();
                                  })
                              : (deviceProvider.userData!.manager != null)
                                  ? ContactInformation(
                                      userData: deviceProvider.userData)
                                  : Container())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactInformation extends StatelessWidget {
  const ContactInformation({
    super.key,
    required this.userData,
  });

  final UserData? userData;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      (userData!.logo != null)
          ? ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 50, maxWidth: 150),
              child: Image.network(userData!.logo!))
          : Container(),
      (userData!.manager!.telephone != null || userData!.manager!.email != null)
          ? Text(S.of(context).labelInformacionDeContacto)
          : Container(),
      (userData!.manager!.email != null)
          ? labelOnInfoWindow('Email', userData!.manager!.email!, color: false)
          : Container(),
      (userData!.manager!.phoneNumber != null)
          ? labelOnInfoWindow(
              S.of(context).labelTelefono, userData!.manager!.phoneNumber!,
              color: false)
          : Container(),
      (userData!.expirationDate != null)
          ? labelOnInfoWindow(
              S.of(context).labelFechaExpiracion, userData!.expirationDate!,
              color: false)
          : Container()
    ]);
  }
}
