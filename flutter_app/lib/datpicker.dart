import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBarInsideAppBarDemo extends StatefulWidget {
  @override
  _TabBarInsideAppBarDemoState createState() => _TabBarInsideAppBarDemoState();
}

class _TabBarInsideAppBarDemoState extends State<TabBarInsideAppBarDemo>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget getTabBar() {
    return TabBar(controller: tabController, tabs: [
      Tab(text: "Add", icon: Icon(Icons.add)),
      Tab(text: "Edit", icon: Icon(Icons.edit)),
      Tab(text: "Delete", icon: Icon(Icons.delete)),
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      Container(color: Colors.red, child: new Text("")),
      Container(color: Colors.green),
      Container(color: Colors.blue)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: getTabBar(),
          ),
        ),
        body: getTabBarPages());
  }
}

class MyAppDatePicker extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyAppDatePicker> {
  String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2020));
    if (picked != null) setState(() => _value = picked.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('gokulan'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(_value),
              new RaisedButton(
                onPressed: _selectDate,
                child: new Text('Click me'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
