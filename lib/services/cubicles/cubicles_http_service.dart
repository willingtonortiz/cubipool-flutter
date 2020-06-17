import 'dart:convert';

import 'package:cubipool/environment/url.dart';
import 'package:cubipool/services/auth/auth_shared_preferences.dart';
import 'package:cubipool/services/cubicles/cubicles_http_service_dtos.dart';
import 'package:http/http.dart' as http;

class CubiclesHttpService {
  static Future<List<GetNotReservedCubiclesByFiltersResponse>>
      getNotReservedCubiclesByFilters(
    int campusId,
    DateTime startTime,
    int hours,
    int totalSeats,
  ) async {
    var token = await AuthSharedPreferences.getUserToken();
    if (token == null) {
      throw Exception("Token del usuario no encontrado");
    }

    final url = '$BASE_URL/api/Cubicle/byFilters?' +
        'CampusId=$campusId&' +
        'StartTime=${startTime.toUtc().toIso8601String()}&' +
        'ReservationHours=$hours&' +
        'TotalSeats=$totalSeats';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      List<dynamic> cubicles = json.decode(response.body);
      cubicles = cubicles
          .map((e) => GetNotReservedCubiclesByFiltersResponse.fromJson(e))
          .toList();
      return cubicles;
    } else {
      throw Exception('getNotReservedCubiclesByFilters ${response.body}');
    }
  }
}
