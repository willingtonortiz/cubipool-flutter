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
    return ListView(children: List.generate(10, (index) => buildNewRow()));
  }

  Container buildNewRow() {
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                	// TODO: Cambiar el icono del escritorio por algor que represente un cubiculo
                  Image.asset(
                    'assets/images/desk.png',
                    height: 20.0,
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Cubículo 103',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Expanded(child: Container()),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
          Divider(height: 0.0)
        ],
      ),
    );
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/desk.png',
                height: 20.0,
              ),
              SizedBox(width: 8.0),
              Text('Cubículo 103'),
              Expanded(child: Container()),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
