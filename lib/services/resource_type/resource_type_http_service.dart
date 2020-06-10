import 'dart:convert';

import 'package:cubipool/models/resource_type.dart';
import 'package:http/http.dart' as http;

class ResourceTypeHttpService {
  static Future<List<ResourceType>> getAllResources() async {
    var response = await http.get(
      'http://10.0.2.2:5000/api/resourceType',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body);
      items = items.map((e) => ResourceType.fromJson(e)).toList();

      return items;
    } else {
      throw Exception();
    }
  }
}
