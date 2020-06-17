import 'package:cubipool/modules/reservation/models/cubicle_details.dart';
import 'package:cubipool/services/reservations/reservations_http_service.dart';
import 'package:cubipool/services/reservations/reservations_http_service_dtos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CubicleDetailPage extends StatefulWidget {
  CubicleDetails Function() cubicleDetails;

  CubicleDetailPage(this.cubicleDetails);

  @override
  _CubicleDetailPageState createState() => _CubicleDetailPageState();
}

class _CubicleDetailPageState extends State<CubicleDetailPage> {
  DateTime endHourDateTime() {
    final cubicleDetails = widget.cubicleDetails();
    return cubicleDetails.startHourDateTime
        .add(Duration(hours: cubicleDetails.totalHours));
  }

  String dayLabel() {
    return widget.cubicleDetails().isToday ? 'Hoy' : 'Mañana';
  }

  Future handleReservationButton() async {
    try {
      final cubicleDetails = widget.cubicleDetails();
      final requestDto = PostReservationRequest(
        cubicleId: cubicleDetails.id,
        hostId: 0,
        startTime: cubicleDetails.startHourDateTime,
        endTime: endHourDateTime(),
      );
      await ReservationsHttpService.post(requestDto);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Se reservó con éxito el cubículo'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      final errorMessage = e.toString().substring(11);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    }
  }

  buildResourcesImages() {
    var resourceImagesMap = {
      14: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/imac.png',
            height: 50.0,
          ),
          Text('IMAC')
        ],
      ),
      15: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/blackboard.png',
            height: 50.0,
          ),
          Text('PIZARRA')
        ],
      ),
      16: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/smart-tv.png',
            height: 50.0,
          ),
          Text('TV')
        ],
      )
    };
    var elements = [];
    final cubicleDetails = widget.cubicleDetails();
    cubicleDetails.resourceTypeIds.asMap().forEach((index, id) {
      elements.add(resourceImagesMap[id]);
      if (index != cubicleDetails.resourceTypeIds.length - 1) {
        elements.add(SizedBox(width: 32.0));
      }
    });
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/desk.png',
              height: 20.0,
            ),
            SizedBox(width: 8.0),
            Text('Cubículo ${widget.cubicleDetails().code.substring(3)}'),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.schedule,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(
                '${widget.cubicleDetails().startHourDateTime.hour}:00 - ${endHourDateTime().hour}:00'),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/building.png',
              height: 16.0,
            ),
            SizedBox(width: 8.0),
            Text('Campus ${widget.cubicleDetails().campus.name}'),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.event_seat,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text('${widget.cubicleDetails().totalSeats} Asientos'),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.access_time,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(dayLabel()),
          ],
        ),
        SizedBox(height: 48.0),
        Text(
          'Recursos disponibles',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[...buildResourcesImages()],
        ),
        SizedBox(height: 32.0),
        RaisedButton(
          color: Colors.red,
          onPressed: () {
            handleReservationButton();
          },
          child: Text(
            'Reservar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
