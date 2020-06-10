import 'package:cubipool/modules/sharing/pages/cubicle_detail_page.dart';
import 'package:cubipool/modules/sharing/pages/cubicle_list_page.dart';
import 'package:cubipool/modules/sharing/pages/search_page.dart';
import 'package:flutter/material.dart';

class SharingPage extends StatefulWidget {
  SharingPage({Key key}) : super(key: key);

  @override
  _SharingPageState createState() => _SharingPageState();
}

class _SharingPageState extends State<SharingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar cubículos compartidos'),
        centerTitle: true,
      ),
      body: SearchPage(),
    );
  }
}
