import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService();

  static Future<String> login(String username, String password) async {
    try {
      var response = await http.post(
        'http://10.0.2.2:5000/api/auth/login',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'username': username, 'password': password}),
      );
      return response.body;
    } catch (e) {
      return null;
    }
  }

  static Future<String> register(String username, String password) async {
    try {
      var response = await http.post(
        'http://10.0.2.2:5000/api/auth/register',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'username': username, 'password': password}),
      );
      return response.body;
    } catch (e) {
      return null;
    }
  }
}
