import 'package:cubipool/dtos/reservation/reservation_response_dto.dart';

class Reservation {
  int id;
  String cubicleCode;
  int cubicleId;
  DateTime startTime;
  DateTime endTime;
  String campus;
  int seats;
  String state;

  Reservation(
      {this.id,
      this.cubicleCode,
      this.startTime,
      this.endTime,
      this.campus,
      this.seats,
      this.state,
			this.cubicleId});

  @override
  String toString() {
    return 'Reservation { id=$id, cubicleCode=$cubicleCode, startTime=$startTime, endTime=$endTime, campus=$campus, seats=$seats, state=$state, cubicleId=$cubicleId}';
  }

  Reservation.fromReservationDTO(
      ReservationResponseDto reservationResponseDto) {
    id = reservationResponseDto.id;
    cubicleCode = reservationResponseDto.cubicleCode;
    startTime = reservationResponseDto.startTime.toLocal();
    endTime = reservationResponseDto.endTime.toLocal();
    campus = "Villa";
    seats = 6;
    state = reservationResponseDto.status;
    cubicleId=reservationResponseDto.cubicleId;
  }

  String timeInterval() {
    return this.startTime.hour.toString() +
        ":00 - " +
        this.endTime.hour.toString() +
        ":00";
  }

  String date() {
    return this.startTime.day.toString() +
        "/" +
        this.startTime.month.toString() +
        "/" +
        this.startTime.year.toString();
  }

  String leftTime() {
    final leftTime = DateTime.now().difference(this.startTime);
    return leftTime.inHours.toString() +
        ":" +
        (leftTime.inMinutes % 60).toString() +
        ":" +
        (leftTime.inSeconds % 60).toString();
  }
}
