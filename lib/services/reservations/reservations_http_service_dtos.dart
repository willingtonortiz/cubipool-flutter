class PostReservationRequest {
  DateTime startTime;
  DateTime endTime;
  int cubicleId;
  int hostId;

  PostReservationRequest(
      {this.startTime, this.cubicleId, this.endTime, this.hostId});

  Map<String, dynamic> toJson() => {
        'startTime': startTime.toUtc().toIso8601String(),
        'endTime': endTime.toUtc().toIso8601String(),
        'cubicleId': cubicleId,
        'hostId': hostId
      };
}
