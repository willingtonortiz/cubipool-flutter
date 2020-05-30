import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List page'),
      ),
      body: Builder(
        builder: (scfContext) => Container(
            child: ListView(
          children: <Widget>[
            for (var i = 0; i < 20; ++i)
              ListTile(
                title: ((i + 1) % 2 == 0) ? Text('Es par') : Text('Es impar'),
                onTap: () {},
              )
          ],
        )),
      ),
    );
  }

  ListView generateList(BuildContext context) {
    return ListView(
      children: List.generate(
        10,
        (i) => ListTile(
          title: Text('Item #${i + 1}'),
          onTap: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Item #${i + 1}'),
                duration: Duration(milliseconds: 500),
              ),
            );
          },
        ),
      ),
    );
  }
}
