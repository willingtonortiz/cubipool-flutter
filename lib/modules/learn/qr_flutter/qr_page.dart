import 'package:cubipool/modules/learn/qr_flutter/pages/image_page.dart';
import 'package:cubipool/modules/learn/qr_flutter/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  QrPage({Key key}) : super(key: key);

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR PAGE'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(
                'Read QR code',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanPage()));
              },
            ),
            RaisedButton(
              child: Text(
                'Generate QR code',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImagePage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
