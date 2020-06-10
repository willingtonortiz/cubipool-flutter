import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cubipool/models/resource.dart';

class ResourceHttpService {
  static Future<List<Resource>> getAllResources() async {
    var response = await http.get(
      'http://10.0.2.2:5000/api/resources',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body);
      items = items.map((e) => Resource.fromJson(e)).toList();

      return items;
    } else {
      throw Exception();
    }
  }
}
