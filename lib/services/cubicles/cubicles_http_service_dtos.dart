class GetNotReservedCubiclesByFiltersResponse {
  int id;
  String code;
  String description;
  int campusId;
  int totalSeats;

  GetNotReservedCubiclesByFiltersResponse(
      {this.id, this.code, this.description, this.campusId, this.totalSeats});

  GetNotReservedCubiclesByFiltersResponse.fromJson(dynamic json)
      : id = json['id'],
        code = json['code'],
        description = json['description'],
        campusId = json['campusId'],
        totalSeats = json['totalSeats'];
}
