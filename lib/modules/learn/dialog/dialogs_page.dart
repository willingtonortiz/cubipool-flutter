import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog page'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text(
              'Show dialog',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Alert dialog'),
                    content: Text('Dialog content'),
                    actionsPadding: EdgeInsets.all(0.0),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Aceptar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          FlatButton(
            color: Colors.red,
            child: Text(
              'Custom dialog',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5.0)), //this right here
                      child: Container(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'What do you want to remember?'),
                              ),
                              SizedBox(
                                child: RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: const Color(0xFF1BC0C5),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
