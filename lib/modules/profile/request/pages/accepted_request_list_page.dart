import 'package:flutter/material.dart';
import 'package:cubipool/modules/profile/request/models/request.dart';

class AcceptedRequestListPage extends StatefulWidget {
  @override
  _AcceptedRequestListPageState createState() =>
      new _AcceptedRequestListPageState();
}

class _AcceptedRequestListPageState extends State<AcceptedRequestListPage> {
  List<Requests> _requests = [
    Requests(id: 0, title: "Cubículo 103: Campus Villa", detail: "Fecha: 20/06/2020 - 10:00am"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Solicitudes aceptadas'),
        ),
        body: Stack(
          children: <Widget>[
            _listView(context),
          ],
        ));
  }

  // ---- Widgets ----

  Widget _listView(BuildContext context) {
    return new ListView.builder(
      itemCount: _requests.length,
      itemBuilder: _buildListTile,
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    var requests = _requests[index];

    return new ListTile(
      trailing: RaisedButton(
        color: Colors.red,
        child:
        Text('Confirmar', style: TextStyle(color: Colors.white)),
        onPressed: showAlert,
      ),
      leading: Icon(Icons.receipt),
      title: new Text(
        requests.title,
      ),
      subtitle: new Text(
        requests.detail,
      ),
    );
  }

  void showAlert() {
    print("alert");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Confirmación"),
            content: new Text(
                "¿Seguro que quiere unirse a este cubículo?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Si"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


}
