import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPage extends StatefulWidget {
  @override
  _SharedPreferencesPageState createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  String text = '';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared preferences'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                    icon: Icon(Icons.text_fields),
                    border: OutlineInputBorder(),
                    labelText: 'Ingresa texto'),
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            FlatButton(
              child: Text(
                'Save data',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                saveData();
              },
            ),
            FlatButton(
              child: Text(
                'Load data',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                loadAndDisplaySavedData();
              },
            ),
            Text(
              text,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  void saveData() async {
    var instance = await SharedPreferences.getInstance();
    instance.setString('key', textController.text);
    setState(() {
      text = textController.text;
    });
  }

  void loadAndDisplaySavedData() async {
    var instance = await SharedPreferences.getInstance();
    setState(() {
      text = instance.getString('key');
    });
  }
}
