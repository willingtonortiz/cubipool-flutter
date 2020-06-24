import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cubipool/environment/url.dart';

class AuthService {
  AuthService();

  static Future<String> login(String username, String password) async {
    var response = await http.post(
      '$BASE_URL/api/auth/login',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    return response.body;
  }

  static Future<String> register(String username, String password) async {
    var response = await http.post(
      '$BASE_URL/api/auth/register',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    return response.body;
  }
}
