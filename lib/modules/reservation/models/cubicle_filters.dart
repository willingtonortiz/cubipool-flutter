import 'package:cubipool/models/campus.dart';

class CubicleFilters {
  Campus campus;
  DateTime startDateTime;
  bool isToday;
  int totalHours;
  int totalSeats;

  CubicleFilters(
      {this.campus, this.startDateTime, this.isToday,this.totalHours, this.totalSeats});
}
