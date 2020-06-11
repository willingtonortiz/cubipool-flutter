import 'package:cubipool/dtos/publications/publication_response_dto.dart';
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
  List<PublicationResponseDto> publications;

  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar cubículos compartidos'),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          SearchPage(
            onPublicationsFound: (List<PublicationResponseDto> result) {
              setState(() {
                publications = result;
              });
              goToNextPage();
            },
          ),
          CubicleListPage(
            publications: publications,
            onBackEvent: () {
              goToPreviousPage();
            },
          ),
          CubicleDetailPage()
        ],
      ),
    );
  }

  void goToNextPage() {
    var nextPageId = controller.page.toInt() + 1;
    controller.jumpToPage(nextPageId);
  }

  void goToPreviousPage() {
    var previousPageId = controller.page.toInt() - 1;
    controller.jumpToPage(previousPageId);
  }
}
