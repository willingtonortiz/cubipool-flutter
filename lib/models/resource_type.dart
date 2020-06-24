class ResourceType {
  int id;
  String name;

  ResourceType({this.id, this.name});

	@override
  String toString() {
    return 'ResourceType { id=$id, name=$name }';
  }

  ResourceType.fromJson(dynamic json)
      : id = json['id'],
        name = json['name'];
}
