import 'package:flutter/material.dart';
import 'package:flutter_app/service.dart';

const String _AccountName = 'Aravind Vemula';
const String _AccountEmail = 'vemula.aravind336@gmail.com';
const String _AccountAbbr = 'AV';

class KeeperPage extends StatefulWidget {
  KeeperPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KeeperDrawer();
  }
}

class KeeperDrawer extends State<KeeperPage> {
// refer: https://docs.flutter.io/flutter/widgets/ListView-class.html
// refer: https://docs.flutter.io/flutter/widgets/GestureDetector-class.html
// refer: https://docs.flutter.io/flutter/material/ListTile-class.html

  @override
  void initState() {
    super.initState();
    // getMenuMasterApi();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: new Drawer(
            child: new ListView(
                padding: const EdgeInsets.only(top: 0.0),
                children: _buildDrawerList(context))),
        appBar: new AppBar(
          title: new Text('Keeper'),
        ),
        body: Container(
          child: FutureBuilder(
              future: getCategoriesApi(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        /*return ListTile(
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].email),
                        );*/
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].email),
                          ),
                        );
                      });
                } else {
                  return Center(
                      child: Column(
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      new Text('Please wait'),
                    ],
                  ));
                }
              }),
        ));
  }

  _onTapOtherAccounts(BuildContext context) {
    Navigator.of(context).pop();
    showDialog<Null>(
      context: context,
      child: new AlertDialog(
        title: const Text('Account switching not implemented.'),
        actions: <Widget>[
          new FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _onListTileTap(BuildContext context) {
    Navigator.of(context).pop();
    showDialog<Null>(
      context: context,
      child: new AlertDialog(
        title: const Text('Not Implemented'),
        actions: <Widget>[
          new FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDrawerList(BuildContext context) {
    List<Widget> children = [];
    children
      ..addAll(_buildUserAccounts(context))
      ..addAll(_buildLabelWidgets(context))
      ..addAll([new Divider()]);

    return children;
  }

  List<Widget> _buildUserAccounts(BuildContext context) {
    return [
      new UserAccountsDrawerHeader(
          accountName: const Text(_AccountName),
          accountEmail: const Text(_AccountEmail),
          currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.brown, child: new Text(_AccountAbbr)),
          otherAccountsPictures: <Widget>[
            new GestureDetector(
              onTap: () {
                return _onTapOtherAccounts(context);
              },
              child: new Semantics(
                label: 'Switch Account',
                child: new CircleAvatar(
                  backgroundColor: Colors.brown,
                  child: new Text('SA'),
                ),
              ),
            )
          ])
    ];
  }

  List<Widget> _defaultLabels(BuildContext context) {
    String notes = 'Test';
    return [
      new ListTile(
        subtitle: new Text("One"),
        title: new Text(notes),
      ),
      new ListTile(
        subtitle: new Text("Two"),
        title: new Text(notes),
      )
    ];
  }

  List<Widget> _buildLabelWidgets(BuildContext context) {
    List<Widget> labelListTiles = [];
    Container(
      child: FutureBuilder(
          future: getMenuMasterApi(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              for (var index in snapshot.data) {
                labelListTiles.add(new ListTile(
                  title: new Text(snapshot.data[index].menuName),
                  subtitle: new Text(snapshot.data[index].menuIcon),
                ));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
    return labelListTiles;
  }
}
