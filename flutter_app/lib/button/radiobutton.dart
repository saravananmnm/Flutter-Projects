import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyRadionButton extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _State createState() => new _State();
}

class _State extends State<MyRadionButton> {
  String _value = 'Hello World';
  var _oneVal;
  static final _key = new GlobalKey();

  void _onPressed() {
    setState(() {
      _value = 'My name is Raunak';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Radio(
                key: _key,
                value: 'one',
                groupValue: _oneVal,
                onChanged: (str) {
                  str != null ? 'empty' : str;
                  print(str);
                },
              ),
              new Radio(
                key: _key,
                value: 'Two',
                groupValue: _oneVal,
                onChanged: (str) {
                  str != null ? 'empty' : str;
                  print(str);
                },
              ),
              new Radio(
                value: 'three',
                groupValue: _oneVal,
                onChanged: (str) {
                  str != null ? 'empty' : str;
                  print(str);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
