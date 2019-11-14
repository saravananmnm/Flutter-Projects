import 'package:flutter/material.dart';

class MyAppButton extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _State createState() => new _State();
}

class _State extends State<MyAppButton> {
  String _value = 'Hello World';

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
              new Text(_value),
              new RaisedButton(
                  onPressed: _onPressed, child: new Text('Click me')),
            ],
          ),
        ),
      ),
    );
  }
}
