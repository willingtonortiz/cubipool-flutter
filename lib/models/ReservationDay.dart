class ReservationDay {
  int id;
  String name;

  ReservationDay({this.id, this.name});

  @override
  String toString() {
    return 'ReservationDay { id=$id, name=$name }';
  }

  ReservationDay.fromJson(dynamic json)
      : id = json['id'],
        name = json['name'];

  bool isToday() {
    return id == 1;
  }
}
