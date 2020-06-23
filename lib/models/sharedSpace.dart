
class SharedSpace
{
	DateTime startTime;
	DateTime endTime;
	int resourceId;

	SharedSpace(this.startTime, this.endTime, this.resourceId);

	SharedSpace.fromJson(dynamic json) {

		startTime = DateTime.parse(json['startTime']).toLocal();
		endTime = DateTime.parse(json['endTime']).toLocal();
		resourceId=json["resourceId"];

	}

	Map<String, dynamic> toJson() => {
		'startTime': startTime.toIso8601String(),
		'endTime': endTime.toIso8601String(),
		'resourceId': resourceId
	};


}
