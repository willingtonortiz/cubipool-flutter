import 'package:cubipool/services/resources/resources_http_service_dtos.dart';

class Resource {
  int id;
  String name;

  Resource({this.id, this.name});

	@override
  String toString() {
    return 'Resource { id=$id, name=$name }';
  }

  Resource.fromJson(dynamic json)
      : id = json['id'],
        name = json['name'];

	Resource.fromDTO(GetResourcesByCubicleIdResponse response)
	{
		id=response.id;
		name=response.name;
	}
}
