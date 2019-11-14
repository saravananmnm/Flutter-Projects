import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: "Tab 1",
              ),
              Tab(icon: Icon(Icons.directions_transit), text: "Tab 2"),
            ],
          ),
          title: Text('Persistent Tab Demo'),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Page 1")),
            Center(child: Text("Page 2")),
          ],
        ),
      ),
    );
  }
}

class VehicleDetails extends StatefulWidget {
  static String tag = 'home-page';

  @override
  VehicelPage createState() => new VehicelPage();
}

class VehicelPage extends State<VehicleDetails> {
  String _value = 'Hello World';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onPressed() {
    setState(() {
      _value = 'My name is Raunak';
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _neverSatisfied(BuildContext context, String message) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('This is Alert Dialog'),
            content: new Text('Displayes Alerts!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    _submit() {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
      }
    }

    final gateInButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      onPressed: () {
        _submit();
        return _neverSatisfied(context, 'Saved');
      },
      padding: EdgeInsets.all(15),
      color: Colors.lightBlueAccent,
      child: Text('Gate In', style: TextStyle(color: Colors.white)),
    );
    // flutter defined function

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('Vehicle Details'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: TextFormField(
                  controller: TextEditingController(),
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 30,
                  maxLengthEnforced: false,
                  decoration: new InputDecoration(
                    labelText: 'Vehicle Number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Vehicle Number is required';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: TextEditingController(),
                  maxLength: 30,
                  decoration: new InputDecoration(
                    labelText: 'Driver name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Driver name is required';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  maxLength: 10,
                  decoration: new InputDecoration(
                    labelText: 'Driver Number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Driver Number is required';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: gateInButton,
              ),
            ]),
      ),
    );
  }
}
