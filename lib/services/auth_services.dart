import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prosecat/system/global.dart';

class AuthService extends ChangeNotifier {
  final String apiUrl = GlobalVariables().apiUrl;
  final String urlLogin = GlobalVariables().urlLogin;
  final storage = const FlutterSecureStorage();
  
  Future<int> authUser(String email, String password) async {      
      final url = Uri.https(apiUrl, urlLogin, {
        'email': email,
        'password': password
      });

      final response = await http.get(url);
      
      final jsonData = jsonDecode(response.body);

      int status = jsonData['status'];      
      
      if (status == 0) {
        return status;
      }

      await storage.write(key: 'user_api_hash', value: jsonData['user_api_hash']);      
      await storage.write(key: 'email', value: email);      
      return status;
    }

    Future logout() async{
      await storage.delete(key: 'user_api_hash');
      return;
    }

    Future<String> readToken() async {
      return await storage.read(key: 'user_api_hash') ?? '';
    }

    Future<String> readEmail()async{
      return await storage.read(key: 'email') ?? '';
    }
}