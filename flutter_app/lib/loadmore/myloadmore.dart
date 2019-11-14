import 'package:flutter/material.dart';
import 'package:flutter_app/loadmore/library.dart';

class MyLoadMorePage extends StatefulWidget {
  MyLoadMorePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyLoadMorePage> {
  int count;

  List<int> list;

  void initState() {
    super.initState();
    // list.addAll(List.generate(30, (v) => v));
    load();
  }

  void load() {
    for (int i = 0; i < 100; i++) {
      list.add(i);
    }
    setState(() {
      count = list != null ?? list.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: RefreshIndicator(
          child: LoadMore(
            isFinish: count >= 60,
            onLoadMore: _loadMore,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: new Text(list[index].toString()),
                  height: 40.0,
                  alignment: Alignment.center,
                );
              },
              itemCount: count != null ? count : 0,
            ),
            delegate: DefaultLoadMoreDelegate(),
            textBuilder: DefaultLoadMoreTextBuilder.english,
          ),
          onRefresh: _refresh,
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    list.clear();
    load();
  }
}
