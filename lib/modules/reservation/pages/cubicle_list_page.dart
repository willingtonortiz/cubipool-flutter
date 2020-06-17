import 'package:cubipool/modules/reservation/models/cubicle_details.dart';
import 'package:cubipool/modules/reservation/models/cubicle_results.dart';
import 'package:cubipool/services/resources/resources_http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CubicleListPage extends StatefulWidget {
  CubicleResults Function() getCubicleResults;
  Function increasePageIndex;
  Function setCubicleDetails;

  CubicleListPage(
      this.getCubicleResults, this.increasePageIndex, this.setCubicleDetails);

  @override
  _CubicleListPageState createState() => _CubicleListPageState();
}

class _CubicleListPageState extends State<CubicleListPage> {
  @override
  void initState() {
    super.initState();
  }

  Future goToCubicleDetailsPage(CubicleInfo cubicle) async {
    try {
      final resources =
          await ResourceHttpService.getResourcesByCubicleId(cubicle.id);
      final cubicleResults = widget.getCubicleResults();
      final cubicleDetails = CubicleDetails(
          campus: cubicleResults.campus,
          code: cubicle.code,
          id: cubicle.id,
          isToday: cubicleResults.isToday,
          startHourDateTime: cubicleResults.startDateTime,
          totalHours: cubicleResults.totalHours,
          totalSeats: cubicleResults.totalSeats,
          resourceTypeIds: resources.map((e) => e.resourceTypeId).toList());
      widget.setCubicleDetails(cubicleDetails);

      widget.increasePageIndex();
    } catch (e) {
      debugPrint("goToCubicleDetailsPage ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget
          .getCubicleResults()
          .cubicles
          .map((cubicle) => buildNewRow(cubicle))
          .toList(),
    );
  }

  Container buildNewRow(CubicleInfo cubicle) {
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              goToCubicleDetailsPage(cubicle);
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.desktop_mac),
                  SizedBox(width: 16.0),
                  Text(
                    'Cubículo ${cubicle.code.substring(3)}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Expanded(child: Container()),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
          Divider(height: 0.0)
        ],
      ),
    );
  }

  // TODO: Add params
  Card buildCard() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/desk.png',
                height: 20.0,
              ),
              SizedBox(width: 8.0),
              Text('Cubículo 103'),
              Expanded(child: Container()),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
