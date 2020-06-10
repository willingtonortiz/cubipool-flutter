import 'package:cubipool/models/campus.dart';
import 'package:cubipool/models/resource_type.dart';
import 'package:cubipool/services/campus/campus_http_service.dart';
import 'package:cubipool/services/resource_type/resource_type_http_service.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Campus> campusList = [];
  Campus selectedCampus;

  List<DateTime> startHourList = [];
  DateTime selectedStartHour;

  List<DateTime> endHourList = [];
  DateTime selectedEndHour;

  List<ResourceType> resourceList = [];
  ResourceType selectedResource;

  @override
  void initState() {
    super.initState();
    fetchCampusList();
    fetchResourceList();
    initializeStartHourDropdown();
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
                    child: Text(dateTimeToHour(x)),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Hora de inicio'),
            value: selectedStartHour,
            onChanged: (DateTime val) {
              setState(() {
                selectedStartHour = val;
                initializeEndHourDropdown();
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
                    child: Text(dateTimeToHour(x)),
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
          child: DropdownButton<ResourceType>(
            items: resourceList
                .map(
                  (x) => DropdownMenuItem<ResourceType>(
                    child: Text(x.name),
                    value: x,
                  ),
                )
                .toList(),
            hint: Text('Recurso'),
            value: selectedResource,
            onChanged: (ResourceType val) {
              setState(() {
                selectedResource = val;
              });
            },
          ),
        ),
      ),
    );
  }

  /* ===== LOGIC ===== */
  Future fetchCampusList() async {
    try {
      var items = await CampusHttpService.getAllCampus();
      setState(() {
        campusList = items;
      });
    } catch (e) {
      debugPrint("ERROR");
    }
  }

  Future initializeStartHourDropdown() async {
    var now = DateTime.now();
    var minutes = (now.minute < 30) ? 0 : 30;

    var timeIterator =
        DateTime(now.year, now.month, now.day, now.hour, minutes);

    var counter = (minutes == 0) ? 4 : 3;

    startHourList =
        generateDateTimeList(timeIterator, counter, Duration(minutes: 30));
  }

  Future initializeEndHourDropdown() async {
    var iterator = selectedStartHour.add(Duration(minutes: 30));

    endHourList = List<DateTime>();
    for (var item in startHourList) {
      if (item.difference(iterator).inMinutes >= 0) {
        endHourList.add(item);
      }
    }

    endHourList.add(startHourList.last.add(Duration(minutes: 30)));
  }

  Future fetchResourceList() async {
    try {
      var items = await ResourceTypeHttpService.getAllResources();
      setState(() {
        resourceList = items;
      });
    } catch (e) {
      debugPrint("ERROR");
    }
  }

  String dateTimeToHour(DateTime date) {
    var formater = DateFormat("HH:mm");

    return formater.format(date);
  }

  List<DateTime> generateDateTimeList(
      DateTime startTime, int count, Duration duration) {
    var iterator = startTime;
    var result = List<DateTime>();

    for (var i = 0; i < count; ++i) {
      result.add(iterator);
      iterator = iterator.add(duration);
    }

    return result;
  }
}
