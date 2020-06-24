import 'package:cubipool/models/reservation.dart';
import 'package:cubipool/modules/profile/myReservations/pages/reservation_datail_page.dart';
import 'package:cubipool/modules/reservation/pages/reservation_page.dart';
import 'package:cubipool/services/reservation/reservation_http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyReservationsPage extends StatefulWidget {
  static const String route = '/my-reservations';
  @override
  _MyReservationsPageState createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage> {
  List<Reservation> activeReservation = [];
  List<Reservation> completedReservation = [];
  bool _loading = true;

  @override
  void initState() {
    getReservations();
    super.initState();
  }

  void getReservations() async {
    //TODO: VALIDAR LOS DATOS OBTENIDOS DE RESERVAS COMPLETADAS
    await Future.wait([
      ReservationService.getReservationNoCompleted(),
      ReservationService.getReservationCompleted()
    ])
        .then((List responses) => {
              activeReservation = responses.elementAt(0),
              completedReservation = responses.elementAt(1)
            })
        .catchError((e) => debugPrint(e));

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mis Reservas'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.symmetric(vertical: 50.0)),
                CircularProgressIndicator()
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Reservas'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Activos', style: TextStyle(color: Colors.black)),
              ),
              for (var i = 0; i < activeReservation.length; ++i)
                buildCard(activeReservation.elementAt(i)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child:
                    Text('Finalizados', style: TextStyle(color: Colors.black)),
              ),
              for (var i = 0; i < completedReservation.length; ++i)
                buildCard(completedReservation.elementAt(i)),
              // for (var i = 0; i < 5; ++i) buildCard(),
            ],
          ),
        ),
      ),
    );
  }

  Card buildCard(Reservation reservation) {
    //TODO: VALIDAR DATOS QUE SE MUESTRA
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReservationDetailPage(reservation)));
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/desk.png',
                      height: 15.0,
                    ),
                    Icon(
                      Icons.schedule,
                      size: 15.0,
                    ),
                    Image.asset(
                      'assets/images/building.png',
                      height: 16.0,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Cubículo ' + reservation.cubicleCode,
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      reservation.timeInterval(),
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      reservation.date(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/desk.png',
                      height: 15.0,
                    ),
                    Image.asset(
                      'assets/images/desk.png',
                      height: 15.0,
                    ),
                    Image.asset(
                      'assets/images/desk.png',
                      height: 15.0,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  // align the text to the left instead of centered
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Campus ' + reservation.campus,
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      reservation.seats.toString() + ' asientos',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      reservation.state,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
