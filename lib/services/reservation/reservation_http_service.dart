import 'dart:convert';

import 'package:cubipool/dtos/reservation/reservation_response_dto.dart';
import 'package:cubipool/environment/url.dart';
import 'package:cubipool/models/reservation.dart';
import 'package:cubipool/services/auth/auth_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReservationService {
  ReservationService();

  static Future<List<Reservation>> getReservationNoCompleted() async {
    var token = await AuthSharedPreferences.getUserToken();

    if (token == null) {
      throw Exception("Token del usuario no encontrado");
    }
    debugPrint(token);
    var response = await http
        .get('http://10.0.2.2:5000/api/users/1/reservations', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode != 200) {
      throw Exception();
    }

    if (response.statusCode == 200) {
      try {
        List<dynamic> items = json.decode(response.body);
        List<Reservation> resp = items
            .map((e) => Reservation.fromReservationDTO(
                ReservationResponseDto.fromJson(e)))
            .cast<Reservation>()
            .toList();
        return resp;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception(response.body);
    }
    return List<Reservation>();
  }

  static Future<List<Reservation>> getReservationCompleted() async {
    var token = await AuthSharedPreferences.getUserToken();

    if (token == null) {
      throw Exception("Token del usuario no encontrado");
    }
    debugPrint("Realizando  request completed");
    var response = await http
        .get('http://10.0.2.2:5000/api/users/reservationsCompleted', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode != 200) {
      throw Exception();
    }

    if (response.statusCode == 200) {
      try {
        List<dynamic> items = json.decode(response.body);
        List<Reservation> resp = items
            .map((e) => Reservation.fromReservationDTO(
                ReservationResponseDto.fromJson(e)))
            .cast<Reservation>()
            .toList();
        return resp;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception(response.body);
    }
    return List<Reservation>();
  }
}
