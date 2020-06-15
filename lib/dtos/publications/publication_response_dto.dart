class PublicationResponseDto {
  int id;
  String cubicleCode;
  String description;
  DateTime publicationStartTime;
  DateTime publicationEndTime;
  int campusId;

  PublicationResponseDto({
    this.id,
    this.cubicleCode,
    this.description,
    this.publicationStartTime,
    this.publicationEndTime,
  });

  @override
  String toString() {
    return 'PublicationResponseDto { id=$id, code=$cubicleCode, description=$description, publicationStartTime=$publicationStartTime, publicationEndTime=$publicationEndTime }';
  }

  PublicationResponseDto.fromJson(dynamic json) {
    id = json['id'];
    cubicleCode = json['cubicleCode'];
    description = json['description'];
    publicationStartTime =
        DateTime.parse(json['publicationStartTime']).toLocal();
    publicationEndTime = DateTime.parse(json['publicationEndTime']).toLocal();
    campusId = json['campusId'];
  }
}
