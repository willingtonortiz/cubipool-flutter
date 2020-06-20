import 'dart:convert';

import 'package:cubipool/models/campus.dart';
import 'package:http/http.dart' as http;
import 'package:cubipool/environment/url.dart';

class CampusHttpService {
  static Future<List<Campus>> getAllCampus() async {
    var response = await http.get(
      '$BASE_URL/api/campus',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body);
      items = items.map((e) => Campus.fromJson(e)).toList();
      return items;
    } else {
      throw Exception();
    }
  }
}
