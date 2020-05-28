import 'package:cubipool/modules/home/pages/home_page.dart';
import 'package:cubipool/modules/learn/dialog/dialogs_page.dart';
import 'package:cubipool/modules/learn/qr_flutter/qr_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubipool APP',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {'/': (context) => QrPage()},
    );
  }
}
