import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CubicleListPage extends StatefulWidget {
  @override
  _CubicleListPageState createState() => _CubicleListPageState();
}

class _CubicleListPageState extends State<CubicleListPage> {

  // TODO: Obtener información del api
  @override
  Widget build(BuildContext context) {
    return ListView(children: List.generate(10, (index) => buildCard()));
  }

  // TODO: Add params
  Card buildCard() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/desk.png',
                          height: 20.0,
                        ),
                        SizedBox(width: 8.0),
                        Text('Cubículo 103'),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.schedule,
                          size: 20.0,
                        ),
                        SizedBox(width: 8.0),
                        Text('10:00 - 12:00'),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet lorem ipsum dolor sin amet ',
                        textAlign: TextAlign.left,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
