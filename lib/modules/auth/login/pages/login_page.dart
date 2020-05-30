import 'package:cubipool/modules/auth/register/pages/register_page.dart';
import 'package:cubipool/modules/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
	static const String route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String usernameErrorText;

  @override
  Widget build(BuildContext context) {
    const inputHorizontalPadding = 48.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
									height: 305.0,
                  child: Image.asset(
                    'assets/images/login_background.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'CUBIPOOL',
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                            letterSpacing: 1.2),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        child: Image.asset(
                          'assets/images/upc_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: inputHorizontalPadding),
                child: _buildUsernameTextField()),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: inputHorizontalPadding),
              child: _buildPasswordTextField(),
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              child: Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                // checkUsernameInput();

								// TODO: La siguiente pagina no puede tener boton de regreso
								// TODO: ESta página debe eliminarse y volver a acceder
                // Navigator.of(context).pushNamed(HomePage.route);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              child: Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RegisterPage.route);
              },
            )
          ],
        ),
      ),
    );
  }

  // Widgets
  TextField _buildUsernameTextField() {
    return TextField(
      controller: usernameController,
      decoration: InputDecoration(
          hintText: 'Código de estudiante',
          icon: Icon(Icons.person),
          errorText: usernameErrorText),
      style: TextStyle(fontSize: 16.0),
      onChanged: (value) {},
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: passwordController,
      decoration:
          InputDecoration(hintText: 'Contraseña', icon: Icon(Icons.lock)),
      obscureText: true,
    );
  }

  // Logic
  bool isUsernameValid() {
    var username = usernameController.text;
    RegExp regExp = RegExp(r"^[uU]\d{4}\w{5}$", multiLine: false);
    return regExp.hasMatch(username);
  }

  void checkUsernameInput() {
    if (isUsernameValid()) {
      setState(() {
        usernameErrorText = null;
      });
    } else {
      setState(() {
        usernameErrorText = 'Código de estudiante no válido';
      });
    }
  }

  void testIsUsernameValid() {
    usernameController.text = 'u20161C963';
    isUsernameValid();
  }
}
