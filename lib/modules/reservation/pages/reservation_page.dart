import 'package:cubipool/modules/reservation/models/cubicle_details.dart';
import 'package:cubipool/modules/reservation/models/cubicle_filters.dart';
import 'package:cubipool/modules/reservation/models/cubicle_results.dart';
import 'package:cubipool/modules/reservation/pages/cubicle_detail_page.dart';
import 'package:cubipool/modules/reservation/pages/cubicle_list_page.dart';
import 'package:cubipool/modules/reservation/pages/search_page.dart';
import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({Key key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  int indexPage = 0;
  List<StatefulWidget> pages;
  CubicleFilters filters;
  CubicleResults cubicleResults;
  CubicleDetails cubicleDetails;

  @override
  void initState() {
    super.initState();
    pages = [
      SearchPage(increaseIndexPage, setCubicleFilters, setCubicleResults),
      CubicleListPage(getCubicleResults, increaseIndexPage, setCubicleDetails),
      CubicleDetailPage(getCubicleDetails)
    ];
  }

  CubicleDetails getCubicleDetails() {
    return cubicleDetails;
  }

  CubicleResults getCubicleResults() {
    return cubicleResults;
  }

  void setCubicleDetails(CubicleDetails newCubicleDetails) {
    setState(() {
      cubicleDetails = newCubicleDetails;
    });
  }

  void setCubicleResults(CubicleResults newCubicleResults) {
    setState(() {
      cubicleResults = newCubicleResults;
    });
  }

  void setCubicleFilters(CubicleFilters newFilters) {
    setState(() {
      filters = newFilters;
    });
  }

  void increaseIndexPage() {
    setState(() {
      indexPage = indexPage + 1;
    });
  }

  void decreaseIndexPage() {
    setState(() {
      indexPage = indexPage - 1;
    });
  }

  String appBarTitle() {
    switch (indexPage) {
      case 0:
        return 'Buscar cubículos para reservar';
        break;
      case 1:
        return 'Cubículos disponibles';
        break;
      case 2:
        if (cubicleResults == null) {
          return '';
        }
        return 'Cubículo ${cubicleDetails.code}';
        break;
      default:
        throw Exception('invalid page index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(appBarTitle()), centerTitle: true, leading: adasda()),
        body: pages[indexPage]);
  }

  Widget adasda() {
    if (indexPage == 0) {
      return null;
    }
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        decreaseIndexPage();
      },
    );
  }
}
