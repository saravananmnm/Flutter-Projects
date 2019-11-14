import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/photo.dart';
import 'package:http/http.dart' as http;

class HomeScreenPage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomeScreenPage> {
  StreamController<Photo> streamController;
  TextEditingController _search = new TextEditingController();
  TextEditingController _pincode = new TextEditingController();
  List<Photo> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(child: Text('Go2Market')),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: new Icon(
              Icons.shopping_cart,
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.indigoAccent.shade700,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: TextField(
                enabled: true,
                controller: _search,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: 'What, are you looking for?',
                    contentPadding: EdgeInsets.all(5.0)),
                onChanged: (String val) {
                  setState(() {
                    _search.text = val;
                  });
                },
              ),
            ),
          ),
          Container(
            color: Colors.indigoAccent.shade700,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _pincode,
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    prefixIcon: Icon(Icons.location_on),
                    prefixStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter your delivery pin code',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.all(10.0)),
                onChanged: (String val) {
                  setState(() {
                    _pincode.text = val;
                  });
                },
              ),
            ),
          ),
          new Center(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: new Image.asset('assets/images/loginimg.png',
                        height: 120.0, width: 120.0),
                  ),
                  flex: 2),
              Expanded(
                child: Center(
                  child: new Text('54 Cylinder Lawn Mower 54 Nanyo',
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 20),
                      softWrap: true),
                ),
                flex: 1,
              )
            ],
          )),
          new Divider(),
          Expanded(
            child: StreamBuilder(
                stream: streamController.stream,
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return Container(
                      child: new GridView.builder(
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    (OrientationBuilder == Orientation.portrait)
                                        ? 2
                                        : 3),
                        itemBuilder: (context, index) {
                          return new Card(
                            child: new GridTile(
                              footer: new Text('name'),
                              child: new Image.network(list[index].url,
                                  width: 10.0,
                                  height:
                                      10.0), //just for testing, will fill with image later
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();
    streamController.stream.listen((P) {
      setState(() {
        list.add(P);
      });
    });
    load(streamController);
  }

  load(StreamController stream) async {
    String url = 'https://jsonplaceholder.typicode.com/photos';
    var client = new http.Client();
    var req = new http.Request('get', Uri.parse(url));
    var res = await client.send(req);
    res.stream.transform(Utf8Decoder()).transform(json.decoder).expand((e) {
      return e;
    }).map((map) {
      return Photo.fromJson(map);
    }).pipe(streamController);
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }
}
