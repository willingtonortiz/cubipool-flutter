import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color iconsColor = Colors.white;
    Color primaryColor = Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: iconsColor,
        color: primaryColor,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            color: iconsColor,
          ),
          Icon(
            Icons.home,
            color: iconsColor,
          ),
          Icon(
            Icons.home,
            color: iconsColor,
          )
        ],
        index: currentIndex,
        onTap: (int index) {
          debugPrint(index.toString());
        },
      ),
    );
  }
}
