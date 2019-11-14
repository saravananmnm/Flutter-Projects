import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';

class MyToast extends StatefulWidget {
  @override
  _MyToastState createState() => _MyToastState();
}

class _MyToastState extends State<MyToast> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
        backgroundColor: Colors.red,
      ),
      body: new Center(
          child: RaisedButton(
              onPressed: () => {showToasts('hello')}, child: Text('show'))),
    );
  }

  void showToasts(String message) {
    showToast(
      "$message",
      duration: Duration(seconds: 2),
      position: ToastPosition.top,
      backgroundColor: Colors.black.withOpacity(0.5),
      radius: 3.0,
      textStyle: TextStyle(fontSize: 30.0),
    );
  }
}
