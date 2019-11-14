import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/photo.dart';
import 'package:http/http.dart' as http;

class RxList extends StatefulWidget {
  @override
  RxListPage createState() => new RxListPage();
}

class RxListPage extends State<RxList> {
  final GlobalKey<RxListPage> _refreshKey = new GlobalKey<RxListPage>();
  StreamController<Photo> streamController;
  List<Photo> list = [];

  Widget getImage(String src) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Image.network(src),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(title: Text('Stream')),
      body: new RefreshIndicator(
        onRefresh: getDetails,
        child: Container(
          child: StreamBuilder(
              stream: streamController.stream,
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
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
                                width: 50.0,
                                height:
                                    50.0), //just for testing, will fill with image later
                          ),
                        );
                      },
                    ),

                    /*ListView.builder(
                itemCount: list.length,
                  itemBuilder: (context,index){
                  return ListTile(
                    leading: Image.network(list[index].url,width: 50.0,height: 50.0),
                    title: Text(list[index].title),
                  );
              }),*/
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshKey.currentState.initState());
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

  Future<Null> getDetails() async {
    return load(streamController).then((photo) {
      setState(() {
        list.add(photo);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }
}
