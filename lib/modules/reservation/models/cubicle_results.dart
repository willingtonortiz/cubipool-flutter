import 'package:cubipool/models/campus.dart';
import 'package:cubipool/modules/reservation/models/cubicle_details.dart';

class CubicleInfo {
  int id;
  String code;

  CubicleInfo({this.id, this.code});
}

class CubicleResults {
  Campus campus;
  int totalSeats;
  DateTime startDateTime;
  int totalHours;
  bool isToday;
  List<CubicleInfo> cubicles;

  CubicleResults(
      {this.campus,
      this.totalSeats,
      this.startDateTime,
      this.totalHours,
      this.isToday,
      this.cubicles});
}
