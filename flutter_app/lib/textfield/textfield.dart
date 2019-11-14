import 'package:flutter/material.dart';
import 'package:flutter_app/commonwidgets/textfield.dart';

class MyTextInput extends StatefulWidget {
  @override
  MyTextInputState createState() => new MyTextInputState();
}

class MyTextInputState extends State<MyTextInput> {
  String result = "";
  TextEditingController controller = new TextEditingController();
  final key = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Input Text"), backgroundColor: Colors.deepOrange),
        body: new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              SizedBox(height: 10.0),
              TextBoxWithTitle(
                key: key,
                controller: controller,
                title: 'Vehicle Number',
                hint: 'Enter vehicle number',
                label: 'Vehicle Number',
                inputType: 'number',
                textCapitalization: '',
                digitsOnly: false,
                validator: (val) {
                  return val.isEmpty ? "enter text" : null;
                },
                saved: (text) {
                  controller.text = text;
                  return controller.text;
                },
              ),
              /* new TextField(
                          decoration: new InputDecoration(
                              hintText: "Type in here"
                          ),
                          //onChanged is called whenever we add or delete something on Text Field
                          onSubmitted: (String str){
                            setState((){
                              result = str;
                            });
                          }
                      ),*/
              //displaying input text
              new RaisedButton(onPressed: submit, child: new Text('Submit')),
              new Text(result)
            ])));
  }

  void submit() {
    setState(() {
      result = controller.text;
    });
  }
}
