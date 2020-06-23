import 'package:flutter/cupertino.dart';

class ReservationResponseDto {
  int id;
  int cubicleId;
  String cubicleCode;
  String description;
  DateTime startTime;
  DateTime endTime;
  String status;

  ReservationResponseDto(
      {this.id,
      this.cubicleCode,
      this.description,
      this.startTime,
      this.endTime,
      this.status,
			this.cubicleId});

  @override
  String toString() {
    return 'PublicationResponseDto { id=$id, code=$cubicleCode, description=$description, publicationStartTime=$startTime, publicationEndTime=$endTime, status=$status, cubicleId=$cubicleId }';
  }

  ReservationResponseDto.fromJson(dynamic json) {
    id = json['id'];
    cubicleCode = json['cubicleCode'];
    description = json['cubicleDescription'];
    startTime = DateTime.parse(json['startTime']).toLocal();
    endTime = DateTime.parse(json['endTime']).toLocal();
    status = json['status'];
    cubicleId=json['cubicleId'];
  }
}
