import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedCampus;
  var studentCodeController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

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
              color: Colors.black,
              width: 200.0,
              child: Image.asset('assets/images/upc_logo.png')),
          DropdownButton<String>(
            items: ['Villa', 'Monterrico', 'San Miguel', 'San Isidro']
                .map((e) => DropdownMenuItem<String>(
                      child: Text(e.toString()),
                      value: e,
                    ))
                .toList(),
            value: selectedCampus,
            onChanged: (String val) {
              setState(() {
                selectedCampus = val;
              });
            },
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: TextFormField(
              controller: studentCodeController,
              decoration: InputDecoration(
                  hintText: 'Código de estudiante',
                  icon: Icon(Icons.person),
                  errorText: ''),
              style: TextStyle(fontSize: 16.0),
              validator: (String value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Contraseña',
                  icon: Icon(Icons.lock),
                  errorText: ''),
              style: TextStyle(fontSize: 16.0),
              validator: (String value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Confirmar contraseña',
                  icon: Icon(Icons.lock),
                  errorText: ''),
              style: TextStyle(fontSize: 16.0),
              validator: (String value) {},
            ),
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Registrar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
