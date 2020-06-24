import 'dart:convert';

import 'package:cubipool/dtos/publications/publication_response_dto.dart';
import 'package:cubipool/environment/url.dart';
import 'package:cubipool/models/publication.dart';

import 'package:cubipool/services/auth/auth_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// 01:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI1IiwibmJmIjoxNTkxODk1OTg5LCJleHAiOjE2MjM0MzE5ODksImlhdCI6MTU5MTg5NTk4OX0.H2eoVZ0R28HvMaY5Nz8gidDvrgMd0OcLOZZATD_vDmo
// 02:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI2IiwibmJmIjoxNTkxODk2MDE1LCJleHAiOjE2MjM0MzIwMTUsImlhdCI6MTU5MTg5NjAxNX0.pLR54_ppoeNRPtdTXt9EZ-FzajJf6YvhFiwhmJVjaL8
// 04:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI4IiwibmJmIjoxNTkxODk2MDYyLCJleHAiOjE2MjM0MzIwNjIsImlhdCI6MTU5MTg5NjA2Mn0.atMeBtHrQs2AGmUxXpVtMa9uUpKtMdTSzmtoQMMlAPs
// 05:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI5IiwibmJmIjoxNTkxODk2MDc0LCJleHAiOjE2MjM0MzIwNzQsImlhdCI6MTU5MTg5NjA3NH0.VSIbWau9rNEJH3033FkVpjUbyrKggv6WmorrNPqstBQ

class PublicationsHttpService {
  static Future<List<PublicationResponseDto>> getAllByFilters(
    int campusId,
    DateTime seatStartTime, {
    DateTime seatEndTime,
    int resourceTypeId,
  }) async {
    var token = await AuthSharedPreferences.getUserToken();

    if (token == null) {
      throw Exception("Token del usuario no encontrado");
    }

    var url =
        '$BASE_URL/publications/search?campusId=$campusId&seatStartTime=${seatStartTime.toIso8601String()}';

    // Agregando hora de fin
    if (seatEndTime != null) {
      url += '&seatEndTime=${seatEndTime.toIso8601String()}';
    }

    // Agregando tipo de recurso elegido
    if (resourceTypeId != null) {
      url += '&resourceTypeId=$resourceTypeId';
    }
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      try {
        List<dynamic> items = json.decode(response.body);
        items = items.map((e) => PublicationResponseDto.fromJson(e)).toList();
        return items;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception(response.body);
    }
  }

  static Future<Publication>  postPublication(Publication publication) async
	{
		var token = await AuthSharedPreferences.getUserToken();
		var url =
			'$BASE_URL/api/Publication';
		var bd=json.decode(json.encoder.convert(publication));
		if (token == null) {
			throw Exception("Token del usuario no encontrado");
		}
			final response = await http.post(url,
				headers: {
					'Content-Type': 'application/json',
					'Accept': 'application/json',
					'Authorization': 'Bearer $token'
				},
				body: json.encoder.convert(publication));

			if (response.statusCode != 200) {
				throw Exception('${json.decode(response.body)['error']}');
			}

			if(response.statusCode == 200)
			{

				Publication pb=Publication.fromJson(json.decode(response.body));
				return publication;
			} else {
				throw Exception('getNotReservedCubiclesByFilters ${response.body}');
			}

	}
}
