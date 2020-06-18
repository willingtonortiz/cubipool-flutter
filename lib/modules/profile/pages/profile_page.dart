import 'package:cubipool/modules/auth/login/pages/login_page.dart';
import 'package:cubipool/modules/profile/myReservations/pages/reservation_list_page.dart';
import 'package:cubipool/modules/profile/rewards/pages/rewards_page.dart';
import 'package:cubipool/services/auth/auth_shared_preferences.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey[400],
                child: Icon(
                  Icons.person,
                  size: 80.0,
                  color: Colors.black38,
                ),
              ),
            ),
            Text(
              'Daniel Iglesias Espinoza',
              style: TextStyle(fontSize: 18.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'U20161c808',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Text(
              '300 puntos',
              style: TextStyle(fontSize: 14.0, color: Colors.green),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('Recompensas'),
                      leading: Icon(Icons.star),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).pushNamed(RewardPage.route);
                      },
                    ),
                    Divider(height: 0.0),
                    ListTile(
                      title: Text('Historial de puntos'),
                      leading: Icon(Icons.textsms),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navegar hacia la siguiente pagina
                      },
                    ),
                    Divider(height: 0.0),
                    ListTile(
                      title: Text('Mis reservas'),
                      leading: Icon(Icons.book),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).pushNamed(MyReservationsPage.route);
                        // TODO: Navegar hacia la siguiente pagina
                      },
                    ),
                    Divider(height: 0.0),
                    ListTile(
                      title: Text('Mis solicitudes'),
                      leading: Icon(Icons.book),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navegar hacia la siguiente pagina
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _buildLogOutButton(),
            ),
          ],
        ),
      ),
    );
  }

  RaisedButton _buildLogOutButton() => RaisedButton(
        color: Colors.red,
        child: Text(
          'Cerrar sesión',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          await AuthSharedPreferences.saveUserToken(null);
          await AuthSharedPreferences.saveUserId(null);

          Navigator.pushReplacementNamed(context, LoginPage.route);
        },
      );
}
