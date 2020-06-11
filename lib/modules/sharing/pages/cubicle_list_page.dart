import 'package:cubipool/dtos/publications/publication_response_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CubicleListPage extends StatefulWidget {
  final List<PublicationResponseDto> publications;
  final Function onBackEvent;
  CubicleListPage({@required this.publications, @required this.onBackEvent});

  @override
  _CubicleListPageState createState() => _CubicleListPageState(
      publications: this.publications, onBackEvent: this.onBackEvent);
}

class _CubicleListPageState extends State<CubicleListPage> {
  final List<PublicationResponseDto> publications;
  final Function onBackEvent;

  _CubicleListPageState(
      {@required this.publications, @required this.onBackEvent});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          onBackEvent();
          return false;
        },
        child: ListView(
            children: publications.map((x) => _buildCard(x)).toList()));
  }

  Card _buildCard(PublicationResponseDto publication) {
    var formater = DateFormat.Hm();

    var startEndTime =
        '${formater.format(publication.publicationStartTime)} - ${formater.format(publication.publicationEndTime)}';

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/desk.png',
                          height: 20.0,
                        ),
                        SizedBox(width: 8.0),
                        Text('Cubículo ${publication.cubicleCode}'),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.schedule,
                          size: 20.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(startEndTime),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        publication.description,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
