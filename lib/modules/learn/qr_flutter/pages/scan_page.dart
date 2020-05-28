import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String barCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code scanner'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'Open Camera',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: scan,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                barCode,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barCode = result.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barCode = "No distes los permisos para abrir la camara";
        });
      } else {
        setState(() {
          barCode = "Error desconocido";
        });
      }
    } on FormatException catch (e) {
      setState(() {
        barCode = "Format exception";
      });
    } catch (e) {
      setState(() {
        barCode = "Error desconocido";
      });
    }
  }
}
