import 'package:cubipool/models/campus.dart';
import 'package:cubipool/models/resource.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // TODO: Modificar por la llamada al api
  List<Campus> campusList = [
    Campus(id: 1, name: "Villa"),
    Campus(id: 2, name: "Monterrico"),
    Campus(id: 3, name: "San Miguel"),
    Campus(id: 4, name: "San Isidro"),
  ];
  Campus selectedCampus;

  // TODO: Modificar dependiendo de la hora
  List<DateTime> reservationHourList = [
    DateTime(2020, 6, 1, 16, 0, 0),
    DateTime(2020, 6, 2, 17, 0, 0),
    DateTime(2020, 6, 3, 18, 0, 0),
  ];
  DateTime selectedReservationHour;

  // TODO: Modificar dependiendo de la cantidad de horas disponibles
  List<int> hoursCountList = [1, 2];
  int selectedHoursCount;

  // TODO: Modificar dependiendo de la cantidad de asientos del cubículo
  List<int> seatsCountList = [4, 5, 6];
  int selectedSeatsCount;

  @override
  void initState() {
//    selectedCampus = campusList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 32.0),
            height: 120.0,
            child: Image.asset('assets/images/books.png'),
          ),
          SizedBox(height: 20.0),
          buildCampusDropdown(),
          SizedBox(height: 20.0),
          buildReservationHourDropdown(),
          SizedBox(height: 20.0),
          buildHoursCountDropdown(),
          SizedBox(height: 20.0),
          buildSeatsCountDropdown(),
          SizedBox(height: 20.0),
          RaisedButton(
            child: Text(
              'Buscar',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            onPressed: () {
              // TODO: Mover a la siguiente pantalla
              // TODO Hacer la llamada al api
            },
          ),
        ],
      ),
    );
  }

  Container buildCampusDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Campus>(
            items: campusList
                .map(
                  (campus) => DropdownMenuItem<Campus>(
                    child: Text(campus.name),
                    value: campus,
                  ),
                )
                .toList(),
            hint: Text('Sede'),
            value: selectedCampus,
            onChanged: (Campus val) {
              setState(() {
                selectedCampus = val;
              });
            },
          ),
        ),
      ),
    );
  }

  Container buildReservationHourDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<DateTime>(
            items: reservationHourList
                .map(
                  (x) => DropdownMenuItem<DateTime>(
                    child: Text('${x.hour}:00'),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Hora de reserva'),
            value: selectedReservationHour,
            onChanged: (DateTime val) {
              setState(() {
                selectedReservationHour = val;
              });
            },
          ),
        ),
      ),
    );
  }

  Container buildHoursCountDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<int>(
            items: hoursCountList
                .map(
                  (x) => DropdownMenuItem<int>(
                    child: Text(x.toString()),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Cantidad de horas'),
            value: selectedHoursCount,
            onChanged: (int val) {
              setState(() {
                selectedHoursCount = val;
              });
            },
          ),
        ),
      ),
    );
  }

  Container buildSeatsCountDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<int>(
            items: seatsCountList
                .map(
                  (x) => DropdownMenuItem<int>(
                    child: Text(x.toString()),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Cantidad de asientos'),
            value: selectedSeatsCount,
            onChanged: (int val) {
              setState(() {
                selectedSeatsCount = val;
              });
            },
          ),
        ),
      ),
    );
  }
}
