import 'dart:convert';

import 'package:cubipool/environment/url.dart';
import 'package:cubipool/services/auth/auth_shared_preferences.dart';
import 'package:cubipool/services/reservations/reservations_http_service_dtos.dart';
import 'package:http/http.dart' as http;

class ReservationsHttpService {
  static Future post(PostReservationRequest request) async {
    var token = await AuthSharedPreferences.getUserToken();
    if (token == null) {
      throw Exception("Token del usuario no encontrado");
    }

    final url = '$BASE_URL/api/Reservation/reservation';

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encoder.convert(request));

    if (response.statusCode != 200) {
      throw Exception('${json.decode(response.body)['error']}');
    }
  }
}
