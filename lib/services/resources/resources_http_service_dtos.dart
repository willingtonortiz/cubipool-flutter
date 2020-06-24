class GetResourcesByCubicleIdResponse {
  int id;
  String code;
  String name;
  int points;
  String description;
  int resourceTypeId;

  GetResourcesByCubicleIdResponse(
      {this.id,
      this.code,
      this.description,
      this.name,
      this.points,
      this.resourceTypeId});

  GetResourcesByCubicleIdResponse.fromJson(dynamic json)
      : id = json['id'],
        code = json['code'],
        name = json['name'],
        points = json['points'],
        description = json['description'],
        resourceTypeId = json['resourceTypeId'];
}
