import 'dart:async';

import 'package:barcode_scan/platform_wrapper.dart';
import 'package:cubipool/models/reservation.dart';
import 'package:cubipool/modules/learn/qr_flutter/pages/scan_page.dart';
import 'package:cubipool/modules/sharing/pages/share_cubicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class ReservationDetailPage extends StatefulWidget {
  static const String route = '/reservation';
  final Reservation reservation;
  ReservationDetailPage(this.reservation) : super();

  @override
  _ReservationDetailPage createState() => _ReservationDetailPage(reservation);
}

class _ReservationDetailPage extends State<ReservationDetailPage> {
  final Reservation reservation;
  String barCode = "";
  String btnActivateText = "";
  String btnShare="Compartir Cubiculo";
  bool isBtnActivateDisabled = true;
  Timer timer;

  _ReservationDetailPage(this.reservation) : super();

  @override
  void initState() {
    super.initState();
    checkLeftTime();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkLeftTime());
  }

  void checkLeftTime() {
    final leftTime = this.reservation.startTime.difference(DateTime.now());
    if (leftTime.inSeconds >= 0) {
      setState(() {
        isBtnActivateDisabled = true;
        btnActivateText = leftTime.inHours.toString() +
            ":" +
            (leftTime.inMinutes % 60).toString() +
            ":" +
            (leftTime.inSeconds % 60).toString() +
            " Activar";
      });
      return;
    }
    if (leftTime.inSeconds < 0 && leftTime.inSeconds >= -5 * 60) {
      setState(() {
        isBtnActivateDisabled = false;
        btnActivateText = (4 + leftTime.inMinutes).toString() +
            ":" +
            ((5 * 60 + leftTime.inSeconds) % 60).toString() +
            " Activar";
      });

      return;
    }
    timer?.cancel();
    setState(() {
      isBtnActivateDisabled = true;
      btnActivateText = "Ya no se puede activar";
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Reservas'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
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
                  Text('Cubículo ${reservation.cubicleCode}'),
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
                      '${reservation.startTime.hour}:00 - ${reservation.endTime.hour}:00'),
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
                  Text('Campus ${reservation.campus}'),
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
                  Text('${reservation.seats} Asientos'),
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
                  Text(reservation.date()),
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
                  Text(reservation.state),
                ],
              ),
              SizedBox(height: 48.0),
              Text(
                'Recursos disponibles',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 16.0),
              resources(),
              SizedBox(height: 32.0),
              RaisedButton(
                color: Colors.red,
                onPressed: isBtnActivateDisabled ? null : scan,
                child: Text(
                  btnActivateText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
							RaisedButton(
								color: Colors.red,
								onPressed: share,
								child: Text(
									"Compartir Cubiculo",
									style: TextStyle(color: Colors.white),
								),
							),
            ],
          ),
        ),
      ),
    );
  }

  // Content reservationAttributes(){

  // }

  Row resources() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/imac.png',
              height: 50.0,
            ),
            Text('IMAC')
          ],
        ),
        SizedBox(width: 32.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/blackboard.png',
              height: 50.0,
            ),
            Text('PIZARRA')
          ],
        ),
        SizedBox(width: 32.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/smart-tv.png',
              height: 50.0,
            ),
            Text('TV')
          ],
        )
      ],
    );
  }

  Future scan() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barCode = result.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barCode = "No distes los permisos para abrir la camara";
        });
      } else {
        setState(() {
          barCode = "Error desconocido";
        });
      }
    } on FormatException catch (e) {
      setState(() {
        barCode = "Format exception";
      });
    } catch (e) {
      setState(() {
        barCode = "Error desconocido";
      });
    }
  }

	Future share() async {
			Navigator.of(context).push(MaterialPageRoute(
				builder: (context) => ShareCubiclePage(reservation)));
	}


}
