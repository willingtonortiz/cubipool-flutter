import 'package:flutter/material.dart';

class RequestListPage extends StatefulWidget {
  @override
  _RequestListPageState createState() => new _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mis solicitudes'),
        ),
        body: Stack(
          children: <Widget>[
            _listView(context),
          ],
        ));
  }

  // ---- Widgets ----

  Widget _listView(BuildContext context) {

    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('Historial de solicitudes'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => _navegarDetalleAsistencias(),
        ),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Solicitudes Aceptadas'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => _navegarDetalleAsistencias(),
        ),
      ],
    );
  }

  // ---- Navegación ----

  void _navegarDetalleAsistencias() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
//          return new Page(persona: persona);
        },
      ),
    );
  }

  void _navegarMasOpciones() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
//          return new Page(persona: persona);
        },
      ),
    );
  }
}
