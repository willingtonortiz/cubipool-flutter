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
  List<DateTime> startHourList = [
    DateTime(2020, 6, 1),
    DateTime(2020, 6, 2),
    DateTime(2020, 6, 3),
  ];
  DateTime selectedStartHour;

  // TODO: Modificar dependiendo de la hora de inicio
  List<DateTime> endHourList = [
    DateTime(2020, 6, 1),
    DateTime(2020, 6, 2),
    DateTime(2020, 6, 3),
  ];
  DateTime selectedEndHour;

  // TODO: Modificar por la llamada al api
  List<Resource> resourceList = [
    Resource(id: 1, name: "IMac"),
    Resource(id: 2, name: "Televisor"),
    Resource(id: 3, name: "Pizarra"),
  ];
  Resource selectedResource;

  @override
  void initState() {
//    selectedCampus = campusList[0];
//    selectedStartHour = startHourList[0];
//    selectedEndHour = endHourList[0];
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
          buildStartHourDropdown(),
          SizedBox(height: 20.0),
          buildEndHourDropdown(),
          SizedBox(height: 20.0),
          Container(
            width: 300.0,
            child: ExpandablePanel(
              header: Text('Más opciones'),
              expanded: Center(
                child: buildResourcesDropdown(),
              ),
            ),
          ),
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

  Container buildStartHourDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<DateTime>(
            items: startHourList
                .map(
                  (x) => DropdownMenuItem<DateTime>(
                    child: Text(x.year.toString()),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Hora de inicio'),
            value: selectedStartHour,
            onChanged: (DateTime val) {
              setState(() {
                selectedStartHour = val;
              });
            },
          ),
        ),
      ),
    );
  }

  Container buildEndHourDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<DateTime>(
            items: endHourList
                .map(
                  (x) => DropdownMenuItem<DateTime>(
                    child: Text(x.year.toString()),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Hora de fin'),
            value: selectedEndHour,
            onChanged: (DateTime val) {
              setState(() {
                selectedEndHour = val;
              });
            },
          ),
        ),
      ),
    );
  }

  Container buildResourcesDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Resource>(
            items: resourceList
                .map(
                  (x) => DropdownMenuItem<Resource>(
                    child: Text(x.name),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Recurso'),
            value: selectedResource,
            onChanged: (Resource val) {
              setState(() {
                selectedResource = val;
              });
            },
          ),
        ),
      ),
    );
  }
}
