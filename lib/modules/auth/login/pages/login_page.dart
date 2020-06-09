import 'package:cubipool/modules/auth/register/pages/register_page.dart';
import 'package:cubipool/modules/home/pages/home_page.dart';
import 'package:cubipool/services/auth/auth_service.dart';
import 'package:cubipool/services/auth/auth_shared_preferences.dart';
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

    // Si el usuario esta logueado, redirigir a la pantalla home
    redirectIfUserLoggedIn();

    var header = Stack(
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
              SizedBox(height: 30.0),
              Text(
                'CUBIPOOL',
                style: TextStyle(
                    fontSize: 28.0, color: Colors.white, letterSpacing: 1.2),
              ),
              SizedBox(height: 30.0),
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
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (scfContext) => SafeArea(
          child: Column(
            children: <Widget>[
              header,
              SizedBox(height: 40.0),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: inputHorizontalPadding),
                  child: _buildUsernameTextField()),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: inputHorizontalPadding),
                child: _buildPasswordTextField(),
              ),
              SizedBox(height: 30.0),
              _buildLoginButton(scfContext),
              SizedBox(height: 20.0),
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
      ),
    );
  }

  /* Widgets - UI */
  TextField _buildUsernameTextField() => TextField(
        controller: usernameController,
        decoration: InputDecoration(
            hintText: 'Código de estudiante',
            icon: Icon(Icons.person),
            errorText: usernameErrorText),
        style: TextStyle(fontSize: 16.0),
        onChanged: (value) {},
      );

  TextField _buildPasswordTextField() => TextField(
        controller: passwordController,
        decoration:
            InputDecoration(hintText: 'Contraseña', icon: Icon(Icons.lock)),
        obscureText: true,
      );

  void showMessage(BuildContext context, String message) =>
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));

  RaisedButton _buildLoginButton(BuildContext context) => RaisedButton(
        child: Text(
          'Ingresar',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () async {
          if (!isUsernameValid()) {
            checkUsernameInput();
            return;
          }

          var username = usernameController.text.trim();
          var password = passwordController.text.trim();

          try {
            // Realizando login
            var token = await AuthService.login(username, password);

            // Guardando el token del usuario en SharedPreferences
            await AuthSharedPreferences.saveUserToken(token);

            showMessage(context, token);

						// Navegando al home
            Navigator.pushReplacementNamed(context, HomePage.route);
          } catch (e) {
            showMessage(context, 'Ocurrió un error en el api');
          }
        },
      );

  /* Logic */
  bool isUsernameValid() {
    var username = usernameController.text.trim();
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
    usernameController.text = 'u20161C808';
    isUsernameValid();
  }

  Future redirectIfUserLoggedIn() async {
    var token = await AuthSharedPreferences.getUserToken();
    if (token == null) return;
    Navigator.pushReplacementNamed(context, HomePage.route);
  }
}
