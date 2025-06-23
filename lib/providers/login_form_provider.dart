import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey();

  String email = '';
  String password = '';
  String? idioma = '';
  
  bool isLoading = false;

  bool get getIsLoading => isLoading;
  set setIsLoagind(bool isLoading){
    this.isLoading = isLoading;
    notifyListeners();
  }

  bool isValidForm(){
    return formKey.currentState?.validate()  ?? false;
  }
  
}