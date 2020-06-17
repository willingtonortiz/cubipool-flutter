import 'package:cubipool/models/ReservationDay.dart';
import 'package:cubipool/models/campus.dart';
import 'package:cubipool/modules/reservation/models/cubicle_details.dart';
import 'package:cubipool/modules/reservation/models/cubicle_filters.dart';
import 'package:cubipool/modules/reservation/models/cubicle_results.dart';
import 'package:cubipool/services/cubicles/cubicles_http_service.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  Function increasePageIndex;
  Function setCubicleFilters;
  Function setCubicleResults;

  SearchPage(
      this.increasePageIndex, this.setCubicleFilters, this.setCubicleResults);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Campus> campusList = [
    Campus(id: 1, name: "Villa"),
    Campus(id: 2, name: "Monterrico"),
    Campus(id: 3, name: "San Isidro"),
    Campus(id: 4, name: "San Miguel"),
  ];
  int selectedCampusId;

  final List<ReservationDay> reservationDaysList = [
    ReservationDay(id: 1, name: "Hoy"),
    ReservationDay(id: 2, name: "Mañana"),
  ];
  ReservationDay selectedReservationDay;
  int selectedReservationDayId;

  int selectedReservationHour;

  final List<int> hoursCountList = [1, 2];
  int selectedHoursCount = 1;

  final List<int> seatsCountList = [2, 3, 4, 5, 6];
  int selectedSeatsCount = 2;

  DateTime selectedStartHourDateTime(bool isToday, int startHour) {
    var startHourDateTime = DateTime.now();
    if (!isToday) {
      startHourDateTime = startHourDateTime.add(Duration(days: 1));
    }
    startHourDateTime = startHourDateTime
        .add(Duration(hours: startHour - startHourDateTime.hour));
    startHourDateTime = startHourDateTime.subtract(Duration(
        minutes: startHourDateTime.minute,
        seconds: startHourDateTime.second,
        milliseconds: startHourDateTime.millisecond,
        microseconds: startHourDateTime.microsecond));
    return startHourDateTime;
  }

  List<int> reservationStartHoursList(bool isToday, int reservationHours) {
    List<int> startHoursList = [];
    final currentHour = DateTime.now().hour;
    final startHour = 7;
    final endHour = 22;

    if (isToday) {
      final add = currentHour < startHour ? startHour - currentHour : 0;
      final maxHour = endHour - reservationHours;
      startHoursList = [for (var i = currentHour + add; i <= maxHour; i++) i];
    } else {
      var reduce = currentHour > endHour ? currentHour - endHour : 0;
      final maxHour = currentHour - reservationHours;
      startHoursList = [for (var i = startHour; i <= maxHour - reduce; i++) i];
    }
    return startHoursList;
  }

  Future goToCubicleListPage() async {
    try {
      final startHourDateTime = selectedStartHourDateTime(
          selectedReservationDay.isToday(), selectedReservationHour);
      final cubicles =
          await CubiclesHttpService.getNotReservedCubiclesByFilters(
              selectedCampusId,
              startHourDateTime,
              selectedHoursCount,
              selectedSeatsCount);

      if (cubicles.length == 0) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('No se encontraron cubículos disponibles'),
        ));
        return;
      }

      final filters = CubicleFilters(
          campus: campusList[selectedCampusId],
          isToday: selectedReservationDay.isToday(),
          startDateTime: startHourDateTime,
          totalHours: selectedHoursCount,
          totalSeats: selectedSeatsCount);
      widget.setCubicleFilters(filters);

      widget.setCubicleResults(CubicleResults(
          campus: filters.campus,
          startDateTime: filters.startDateTime,
          totalHours: filters.totalHours,
          isToday: filters.isToday,
          totalSeats: filters.totalSeats,
          cubicles: cubicles
              .map(
                (e) => CubicleInfo(id: e.id, code: e.code),
              )
              .toList()));

      widget.increasePageIndex();
    } catch (e) {
      debugPrint("goToCubicleListPage ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCampusId = campusList[0].id;
    selectedReservationDay = reservationDaysList[0];
    selectedReservationDayId = selectedReservationDay.id;
    final startHours = reservationStartHoursList(
        selectedReservationDay.isToday(), selectedHoursCount);
    selectedReservationHour = startHours.length == 0 ? null : startHours[0];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          buildBooksImage(),
          buildCampusDropdown(),
          buildDayDropdown(),
          buildHoursCountDropdown(),
          buildReservationHourDropdown(),
          buildSeatsCountDropdown(),
          buildCubicleListButton(),
        ],
      ),
    );
  }

  Container buildBooksImage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32.0),
      height: 120.0,
      child: Image.asset('assets/images/books.png'),
    );
  }

  Container buildDayDropdown() {
    return Container(
        width: 250.0,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.access_time),
              hintText: 'Seleccione el día de la reserva',
              labelText: 'Día de reserva'),
          value: selectedReservationDayId,
          onChanged: (newReservationDayId) {
            var newReservationDay = reservationDaysList
                .firstWhere((element) => element.id == newReservationDayId);

            var changedSelectedReservationHour = selectedReservationHour;

            final reservationHourList = reservationStartHoursList(
                newReservationDay.isToday(), selectedHoursCount);

            if (!reservationHourList.contains(selectedReservationHour)) {
              changedSelectedReservationHour = reservationHourList.first;
            }

            setState(() {
              selectedReservationDayId = newReservationDayId;
              selectedReservationDay = newReservationDay;
              selectedReservationHour = changedSelectedReservationHour;
            });
          },
          items: reservationDaysList
              .map((day) => DropdownMenuItem(
                    child: Text(day.name),
                    value: day.id,
                  ))
              .toList(),
        ));
  }

  Container buildCampusDropdown() {
    return Container(
        width: 250.0,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.business),
              hintText: 'Seleccione campus',
              labelText: 'Campus'),
          value: selectedCampusId,
          onChanged: (int campusId) {
            setState(() {
              selectedCampusId = campusId;
            });
          },
          items: campusList
              .map((campus) => DropdownMenuItem(
                    child: Text(campus.name),
                    value: campus.id,
                  ))
              .toList(),
        ));
  }

  Container buildReservationHourDropdown() {
    return Container(
        width: 250.0,
        child: DropdownButtonFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.access_time),
                hintText: 'Seleccione hora de reserva',
                labelText: 'Hora de reserva'),
            value: selectedReservationHour,
            onChanged: (startHour) {
              setState(() {
                selectedReservationHour = startHour;
              });
            },
            items: reservationStartHoursList(
                    selectedReservationDay.isToday(), selectedHoursCount)
                .map((hour) => DropdownMenuItem(
                      child: Text('${hour.toString()}:00'),
                      value: hour,
                    ))
                .toList()));
  }

  Container buildHoursCountDropdown() {
    return Container(
        width: 250.0,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.access_time),
              hintText: 'Seleccione la cantidad de horas',
              labelText: 'Horas de reserva'),
          value: selectedHoursCount,
          onChanged: (newHoursCount) {
            var changedSelectedReservationHour = selectedReservationHour;

            final reservationHourList = reservationStartHoursList(
                selectedReservationDay.isToday(), newHoursCount);

            if (!reservationHourList.contains(selectedReservationHour)) {
              changedSelectedReservationHour = reservationHourList.last;
            }

            setState(() {
              selectedHoursCount = newHoursCount;
              selectedReservationHour = changedSelectedReservationHour;
            });
          },
          items: hoursCountList
              .map((reservationHour) => DropdownMenuItem(
                    child: Text(reservationHour.toString()),
                    value: reservationHour,
                  ))
              .toList(),
        ));
  }

  Container buildSeatsCountDropdown() {
    return Container(
        width: 250.0,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.event_seat),
              hintText: 'Seleccione la cantidad de asientos',
              labelText: 'Cantidad de asientos'),
          value: selectedSeatsCount,
          onChanged: (reservationSeats) {
            setState(() {
              selectedSeatsCount = reservationSeats;
            });
          },
          items: seatsCountList
              .map((reservationSeats) => DropdownMenuItem(
                    child: Text(reservationSeats.toString()),
                    value: reservationSeats,
                  ))
              .toList(),
        ));
  }

  RaisedButton buildCubicleListButton() {
    return RaisedButton(
      child: Text(
        'Buscar',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.red,
      onPressed: () {
        goToCubicleListPage();
      },
    );
  }
}
