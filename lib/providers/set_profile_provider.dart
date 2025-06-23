import 'package:flutter/material.dart';
import 'package:prosecat/services/services.dart';

class SetProfileProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey();
  final authService = AuthService();


  String email = '';
  String password = '';
  String passwordConfirmation = '';  
  bool isLoading = false;

  void setEmail()async{
    final userEmail = await authService.readEmail();    
    email = userEmail;
    notifyListeners();
  }

  Future<String> getE()async{
    return await authService.readEmail();
  }

  String get getEmail => email;


  bool get getIsLoading => isLoading;
  set setIsLoagind(bool isLoading){
    this.isLoading = isLoading;
    notifyListeners();
  }

  bool isValidForm(){
    return formKey.currentState?.validate()  ?? false;
  }
  
}