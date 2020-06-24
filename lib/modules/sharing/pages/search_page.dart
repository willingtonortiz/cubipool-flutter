import 'package:cubipool/dtos/publications/publication_response_dto.dart';
import 'package:cubipool/models/campus.dart';
import 'package:cubipool/models/resource_type.dart';
import 'package:cubipool/services/campus/campus_http_service.dart';
import 'package:cubipool/services/publications/publication_http_service.dart';
import 'package:cubipool/services/resource_type/resource_type_http_service.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  final Function(List<PublicationResponseDto> publications) onPublicationsFound;

  SearchPage({@required this.onPublicationsFound});

  @override
  _SearchPageState createState() =>
      _SearchPageState(onPublicationsFound: this.onPublicationsFound);
}

class _SearchPageState extends State<SearchPage> {
  final Function(List<PublicationResponseDto> publications) onPublicationsFound;

  _SearchPageState({@required this.onPublicationsFound});

  // Lista de campus
  List<Campus> campusList = [];
  Campus selectedCampus;

  // Lista de horas de inicio
  List<DateTime> startHourList = [];
  DateTime selectedStartHour;

  // Lista de horas de fin
  List<DateTime> endHourList = [];
  DateTime selectedEndHour;

  // Lista de recursos
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
            child: Image.asset('assets/images/books.png', height: 120.0),
          ),
          SizedBox(height: 20.0),
          _buildCampusDropdown(),
          SizedBox(height: 20.0),
          _buildStartHourDropdown(),
          SizedBox(height: 20.0),
          _buildEndHourDropdown(),
          SizedBox(height: 20.0),
          Container(
            width: 300.0,
            child: ExpandablePanel(
              header: Text('Más opciones'),
              expanded: Center(
                child: _buildResourcesDropdown(),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          _buildSearchButton(context)
        ],
      ),
    );
  }

  Container _buildCampusDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Campus>(
            items: campusList
                .map(
                  (campus) => DropdownMenuItem<Campus>(
                    child: Text(campus.name.toUpperCase()),
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

  Container _buildStartHourDropdown() {
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

  Container _buildEndHourDropdown() {
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

  Container _buildResourcesDropdown() {
    return Container(
      width: 250.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<ResourceType>(
            items: resourceList
                .map(
                  (x) => DropdownMenuItem<ResourceType>(
                    child: Text(x.name.toUpperCase()),
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

  RaisedButton _buildSearchButton(BuildContext context) => RaisedButton(
        child: Text(
          'Buscar',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.red,
        onPressed: () async {
          // El campus no puede ser nulo
          if (selectedCampus == null) {
            showSnackBar(context, 'Debe elegir un campus');
            return;
          }

          // La hora de inicio no puede ser nula
          if (selectedStartHour == null) {
            showSnackBar(context, 'Debe elegir una Hora de inicio');
            return;
          }

          try {
            var items = await PublicationsHttpService.getAllByFilters(
                selectedCampus.id, selectedStartHour,
                seatEndTime: selectedEndHour);

            if (items.length == 0) {
              showSnackBar(context, 'No se encontraron publicaciones');
              return;
            }
            onPublicationsFound(items);
          } catch (e) {
            showSnackBar(context, 'Ocurrio un error');
          }
        },
      );

  void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
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
