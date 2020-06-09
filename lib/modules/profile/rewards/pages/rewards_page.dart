import 'package:flutter/material.dart';

class RewardPage extends StatefulWidget {
  static const String route = '/rewards';
  RewardPage({Key key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recompensas'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 32.0),
                height: 75.0,
                child: Image.asset('assets/images/gift.png'),
              ),
              const Text('Disponible'),
              const Text('300 puntos',
                  style: TextStyle(color: Colors.green, fontSize: 16.0)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('¿En qué podría canjear mis puntos?',
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 16.0),
              RewardItem(
                imageAssetUrl: 'assets/images/ipad.png',
                name: 'iPad',
                description: 'Podrás tener prioridad para usar el iPad',
                price: 10,
                onPressed: () {},
              ),
              const Divider(height: 24.0),
              RewardItem(
                imageAssetUrl: 'assets/images/sandclock.png',
                name: '2 horas más de reserva',
                description: 'Podrás aumentar tu cuota de reserva diaria',
                price: 10,
                onPressed: () {},
              ),
              const Divider(height: 24.0),
              RewardItem(
                imageAssetUrl: 'assets/images/books-2.png',
                name: 'Reserva de libro',
                description: 'Podrás aumentar tu cuota de reserva de libro',
                price: 10,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RewardItem extends StatelessWidget {
  final String imageAssetUrl;
  final String name;
  final String description;
  final int price;
  final void Function() onPressed;

  const RewardItem({
    Key key,
    @required this.imageAssetUrl,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: <Widget>[
              Container(height: 92.0, width: 75.0, child: Image.asset(imageAssetUrl)),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(name),
                      SizedBox(width: 8.0),
                      Text('($price puntos)',
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(description,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                  SizedBox(height: 8.0),
                  RaisedButton(
                    color: Colors.red,
                    child:
                        Text('Canjear', style: TextStyle(color: Colors.white)),
                    onPressed: onPressed,
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
