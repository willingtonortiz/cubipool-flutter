class Campus {
  int id;
  String name;

  Campus({this.id, this.name});

  @override
  String toString() {
    return 'Campus { id=$id, name=$name }';
  }

  Campus.fromJson(dynamic json)
      : id = json['id'],
        name = json['name'];
}
