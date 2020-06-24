import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Generator'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            QrImage(
              data: "U20161C808",
              version: QrVersions.auto,
              size: 300.0,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
