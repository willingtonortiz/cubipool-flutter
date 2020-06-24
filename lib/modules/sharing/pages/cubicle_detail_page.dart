import 'package:cubipool/dtos/publications/publication_response_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CubicleDetailPage extends StatefulWidget {
  final PublicationResponseDto publication;
  final Function onBackEvent;
  final Function(PublicationResponseDto item) onContinuePressed;

  CubicleDetailPage(
      {@required this.publication,
      @required this.onBackEvent,
      @required this.onContinuePressed});

  @override
  _CubicleDetailPageState createState() => _CubicleDetailPageState(
        publication: publication,
        onBackEvent: onBackEvent,
        onContinuePressed: onContinuePressed,
      );
}

class _CubicleDetailPageState extends State<CubicleDetailPage> {
  final PublicationResponseDto publication;
  final Function onBackEvent;
  final Function(PublicationResponseDto item) onContinuePressed;

  _CubicleDetailPageState({
    @required this.publication,
    @required this.onBackEvent,
    @required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    var formater = DateFormat.Hm();

    var startEndTime =
        '${formater.format(publication.publicationStartTime)} - ${formater.format(publication.publicationEndTime)}';

    final resourcesRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/imac.png',
              height: 50.0,
            ),
            Text('IMAC')
          ],
        ),
        SizedBox(width: 32.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/blackboard.png',
              height: 50.0,
            ),
            Text('IMAC')
          ],
        ),
        SizedBox(width: 32.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/smart-tv.png',
              height: 50.0,
            ),
            Text('IMAC')
          ],
        )
      ],
    );

    return WillPopScope(
      onWillPop: () async {
        onBackEvent();
        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/desk.png',
                height: 20.0,
              ),
              SizedBox(width: 8.0),
              Text('Cubículo ${publication.cubicleCode}'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.schedule,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Text(startEndTime),
            ],
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              publication.description,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 48.0),
          Text(
            'Recursos disponibles',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 16.0),
          resourcesRow,
          const SizedBox(height: 32.0),
          _buildContinueButton()
        ],
      ),
    );
  }

  RaisedButton _buildContinueButton() => RaisedButton(
        color: Colors.red,
        onPressed: () {
          onContinuePressed(publication);
        },
        child: Text(
          'Continuar',
          style: TextStyle(color: Colors.white),
        ),
      );
}
