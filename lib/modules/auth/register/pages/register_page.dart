import 'package:cubipool/models/campus.dart';
import 'package:cubipool/services/auth/auth_service.dart';
import 'package:cubipool/services/campus/campus_http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const String route = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<Campus> campusList = [];
  Campus selectedCampus;

  var studentCodeController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchCampusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (scfContext) => Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  height: 150.0,
                  child: Image.asset('assets/images/pencils.png')),
              _buildCampusDropdown(),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: _buildStudentCodeInput()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: _buildPasswordInput(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: _buildConfirmPasswordInput(),
              ),
              _buildRegisterButton(scfContext),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildCampusDropdown() => Container(
        width: 250.0,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<Campus>(
              items: campusList
                  .map(
                    (campus) => DropdownMenuItem<Campus>(
                      child: Text(campus.name),
                      value: campus,
                    ),
                  )
                  .toList(),
              hint: Text('Sede'),
              value: selectedCampus,
              onChanged: (Campus val) {
                setState(() {
                  selectedCampus = val;
                });
              },
            ),
          ),
        ),
      );

  TextFormField _buildStudentCodeInput() => TextFormField(
        controller: studentCodeController,
        decoration: InputDecoration(
            hintText: 'Código de estudiante',
            icon: Icon(Icons.person),
            errorText: ''),
        style: TextStyle(fontSize: 16.0),
        validator: (String value) {
          if (value.isEmpty) return "Este campo es requerido";

          RegExp regExp = RegExp(r"^[uU]\d{4}\w{5}$", multiLine: false);
          if (!regExp.hasMatch(value)) return "Debe ingresar un código válido";

          return null;
        },
      );

  TextFormField _buildPasswordInput() => TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña', icon: Icon(Icons.lock), errorText: ''),
        style: TextStyle(fontSize: 16.0),
        validator: (String value) {
          if (value.isEmpty) return "Este campo es requerido";
          return null;
        },
      );

  TextFormField _buildConfirmPasswordInput() => TextFormField(
        controller: confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar contraseña',
            icon: Icon(Icons.lock),
            errorText: ''),
        style: TextStyle(fontSize: 16.0),
        validator: (String value) {
          if (value.isEmpty) return "Este campo es requerido";
          var password = passwordController.text;
          debugPrint(value);
          debugPrint(password);
          if (password != value) return "La contraseña no coincide";
          return null;
        },
      );

  RaisedButton _buildRegisterButton(BuildContext context) => RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          'Registrar',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          if (!_formKey.currentState.validate()) return;

          var username = studentCodeController.text;
          var password = passwordController.text;

          try {
            await AuthService.register(username, password);

            showSuccessAlert(context);
          } catch (e) {
            showSnackBar(context, 'Hubo un error al registrarse');
          }
        },
      );

  void showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🎉 Bienvenido! 🎉', textAlign: TextAlign.center),
        content: Text('Se registro exitosamente', textAlign: TextAlign.center),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar'),
            onPressed: () {
              // Para cerrar el dialog
              Navigator.of(context).pop();
              // Para salir de la pantalla de registro
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  /* LOGIC */
  Future fetchCampusList() async {
    var items = await CampusHttpService.getAllCampus();
    setState(() {
      campusList = items;
    });
  }

  bool isUsernameValid() {
    var username = studentCodeController.text;
    RegExp regExp = RegExp(r"^[uU]\d{4}\w{5}$", multiLine: false);
    return regExp.hasMatch(username);
  }
}
