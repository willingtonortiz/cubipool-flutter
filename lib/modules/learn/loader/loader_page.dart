import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderPage extends StatefulWidget {
  @override
  _LoaderPageState createState() => _LoaderPageState();
}

// Alto consumo del procesador
class _LoaderPageState extends State<LoaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loader page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SpinKitFadingGrid(
              color: Colors.red,
              size: 64.0,
            ),
            SpinKitCubeGrid(
              color: Colors.blue,
              size: 64.0,
            ),
            SpinKitWave(
              color: Colors.green,
              size: 64.0,
            ),
          ],
        ),
      ),
    );
  }
}
