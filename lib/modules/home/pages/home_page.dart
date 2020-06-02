import 'package:cubipool/modules/profile/pages/profile_page.dart';
import 'package:cubipool/modules/reservation/pages/reservation_page.dart';
import 'package:cubipool/modules/sharing/pages/sharing_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pages = [SharingPage(), ReservationPage(), ProfilePage()];
  var currentIndex;
  var currentPage = null;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    currentPage = pages[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  CurvedNavigationBar buildBottomNavigationBar() {
    Color iconsColor = Colors.white;
    Color primaryColor = Colors.red;

    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: iconsColor,
      color: primaryColor,
      height: 50.0,
      animationDuration: Duration(milliseconds: 300),
      items: <Widget>[
        Icon(
          Icons.share,
          color: iconsColor,
        ),
        Icon(
          Icons.book,
          color: iconsColor,
        ),
        Icon(
          Icons.person,
          color: iconsColor,
        )
      ],
      index: currentIndex,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
          currentPage = pages[currentIndex];
        });
      },
    );
  }
}
