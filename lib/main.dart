import 'package:cubipool/modules/auth/login/pages/login_page.dart';
import 'package:cubipool/modules/auth/register/pages/register_page.dart';
import 'package:cubipool/modules/home/pages/home_page.dart';
import 'package:cubipool/modules/profile/rewards/pages/rewards_page.dart';
import 'package:flutter/material.dart';

import 'modules/profile/myReservations/pages/reservation_list_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubipool APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (context) => LoginPage(),
        RegisterPage.route: (context) => RegisterPage(),
        HomePage.route: (context) => HomePage(),
        RewardPage.route: (context) => RewardPage(),
        MyReservationsPage.route: (context) => MyReservationsPage(),

      },
    );
  }
}

class ScanPage {}
