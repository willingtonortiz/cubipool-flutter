import 'dart:convert';

import 'package:cubipool/environment/url.dart';
import 'package:cubipool/services/auth/auth_shared_preferences.dart';
import 'package:cubipool/services/resources/resources_http_service_dtos.dart';
import 'package:http/http.dart' as http;
import 'package:cubipool/models/resource.dart';

class PublicationHttpService {
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

  static Future<List<GetResourcesByCubicleIdResponse>> getResourcesByCubicleId(
      int id) async {
    var token = await AuthSharedPreferences.getUserToken();
    if (token == null) {
      throw Exception("Token del usuario no encontrado");
    }

    final url = '$BASE_URL/api/cubicles/$id/resources';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      List<dynamic> resources = json.decode(response.body);
      List<GetResourcesByCubicleIdResponse>rs = resources
          .map((e) => GetResourcesByCubicleIdResponse.fromJson(e))
          .toList();
      return resources;
    } else {
      throw Exception('getNotReservedCubiclesByFilters ${response.body}');
    }
  }
}
