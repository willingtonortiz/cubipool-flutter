import 'package:cubipool/modules/reservation/pages/cubicle_detail_page.dart';
import 'package:cubipool/modules/reservation/pages/cubicle_list_page.dart';
import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({Key key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar cubículos'),
        centerTitle: true,
      ),
      body: CubicleDetailPage(),
    );
  }
}
