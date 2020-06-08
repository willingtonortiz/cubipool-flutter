import 'dart:convert';

import 'package:cubipool/models/campus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CampusHttpService {
  static Future<List<Campus>> getAllCampus() async {
    try {
      var response = await http.get(
        'http://10.0.2.2:5000/api/campus',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      List<dynamic> items = json.decode(response.body);
      items = items.map((e) => Campus.fromJson(e)).toList();

      return items;
    } catch (e) {
      return null;
    }
  }
}
