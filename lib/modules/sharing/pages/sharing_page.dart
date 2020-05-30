import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class SharingPage extends StatefulWidget {
  SharingPage({Key key}) : super(key: key);

  @override
  _SharingPageState createState() => _SharingPageState();
}

class _SharingPageState extends State<SharingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar cubículos compartidos'),
        centerTitle: true,
      ),
			body: Text('GA'),
    );
  }
}
