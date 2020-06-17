import 'package:cubipool/models/campus.dart';

class CubicleDetails {
  int id;
  String code;
  DateTime startHourDateTime;
  int totalHours;
  Campus campus;
  int totalSeats;
  bool isToday;
  List<int> resourceTypeIds;

  CubicleDetails(
      {this.id,
      this.code,
      this.startHourDateTime,
      this.totalHours,
      this.campus,
      this.totalSeats,
      this.isToday,
      this.resourceTypeIds});
}
