import 'dart:convert';

import 'package:cubipool/dtos/reservation/reservation_response_dto.dart';
import 'package:cubipool/models/sharedSpace.dart';

class Publication{

	int id;
	DateTime startTime;
	DateTime endTime;
	int sharedSeats;
	int reservationId;
	String description;
	List<SharedSpace> sharedSpaces;

	Publication(this.id, this.startTime, this.endTime, this.sharedSeats,
      this.reservationId,this.description);

	Publication.fromJson(dynamic json) {


		try {
			if(json['id']!=null)
				id = json['id'];
			startTime = DateTime.parse(json['startTime']).toLocal();
			endTime = DateTime.parse(json['endTime']).toLocal();
			sharedSeats = json["sharedSeats"];
			reservationId = json["reservationId"];
			List<dynamic> ss = json["sharedSpaces"];
			ss = ss.map((e) => SharedSpace.fromJson(e)).toList();
			description = json['description'];
			sharedSpaces = ss;
		}catch(e)
		{
			print(e);
		}
	}

	Map<String, dynamic> toJson() => {
		'startTime': startTime.toIso8601String(),
		'endTime': endTime.toIso8601String(),
		'sharedSeats': sharedSeats,
		'reservationId': reservationId,
		'description': description,
		 'sharedSpaces': sharedSpaces
	};

}
