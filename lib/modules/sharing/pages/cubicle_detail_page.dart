import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CubicleDetailPage extends StatefulWidget {
  @override
  _CubicleDetailPageState createState() => _CubicleDetailPageState();
}

class _CubicleDetailPageState extends State<CubicleDetailPage> {
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
            Text('Cubículo 103'),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.schedule,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text('10:00 - 12:00'),
          ],
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet ',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 48.0),
        Text(
          'Recursos disponibles',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 16.0),
        Row(
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
                Text('IMAC')
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
                Text('IMAC')
              ],
            )
          ],
        ),
        SizedBox(height: 32.0),
        RaisedButton(
          color: Colors.red,
          onPressed: () {},
          child: Text(
            'Continuar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
