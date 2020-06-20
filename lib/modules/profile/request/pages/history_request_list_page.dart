import 'package:flutter/material.dart';
import 'package:cubipool/modules/profile/request/models/request.dart';

class HistoryRequestListPage extends StatefulWidget {
  @override
  _HistoryRequestListPageState createState() =>
      new _HistoryRequestListPageState();
}

class _HistoryRequestListPageState extends State<HistoryRequestListPage> {
  List<Requests> _requests = [
    Requests(id: 0, title: "Cubículo 103: Campus Villa", detail: "Fecha: 06/06/2020 - 5:00pm"),
    Requests(id: 1, title: "Cubículo 303: Campus Villa", detail: "Fecha: 05/06/2020 - 2:00pm"),
    Requests(id: 2, title: "Cubículo 204: Campus Villa", detail: "Fecha: 05/06/2020 - 3:00pm"),
    Requests(id: 3, title: "Cubículo 105: Campus Villa", detail: "Fecha: 04/06/2020 - 6:00pm"),
    Requests(id: 4, title: "Cubículo 301: Campus Villa", detail: "Fecha: 03/06/2020 - 8:00pm"),
    Requests(id: 5, title: "Cubículo 403: Campus Villa", detail: "Fecha: 02/06/2020 - 3:00pm"),
    Requests(id: 6, title: "Cubículo 201: Campus Villa", detail: "Fecha: 01/06/2020 - 3:00pm"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Historial de solicitudes'),
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
//      trailing: Icon(Icons.keyboard_arrow_right),
      leading: Icon(Icons.desktop_mac),
      title: new Text(
        requests.title,
      ),
      subtitle: new Text(
        requests.detail,
      ),
    );
  }
}
