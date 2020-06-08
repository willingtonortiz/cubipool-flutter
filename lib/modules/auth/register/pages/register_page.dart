import 'package:cubipool/models/campus.dart';
import 'package:cubipool/services/campus/campus_http_service.dart';
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

  @override
  void initState() {
    super.initState();
    fetchCampusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
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
          _buildRegisterButton(),
        ],
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

  RaisedButton _buildRegisterButton() => RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          'Registrar',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      );

  TextFormField _buildStudentCodeInput() => TextFormField(
        controller: studentCodeController,
        decoration: InputDecoration(
            hintText: 'Código de estudiante',
            icon: Icon(Icons.person),
            errorText: ''),
        style: TextStyle(fontSize: 16.0),
        validator: (String value) {},
      );

  TextFormField _buildPasswordInput() => TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña', icon: Icon(Icons.lock), errorText: ''),
        style: TextStyle(fontSize: 16.0),
        validator: (String value) {},
      );

  TextFormField _buildConfirmPasswordInput() => TextFormField(
        controller: confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar contraseña',
            icon: Icon(Icons.lock),
            errorText: ''),
        style: TextStyle(fontSize: 16.0),
        validator: (String value) {},
      );

  /* LOGIC */
  Future fetchCampusList() async {
    var items = await CampusHttpService.getAllCampus();
    setState(() {
      campusList = items;
    });
  }
}
