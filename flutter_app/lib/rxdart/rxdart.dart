import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

//RXDART

class RxDart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RxDartState();
  }
}

class RxDartState extends State<RxDart> {
  // bool _isload = false;
  String val = '';
  final pb_subject = new PublishSubject<String>();
  bool _isLoading = false;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pb_subject.stream.listen(_listenStr);
  }

  void _listenStr(String val) {
    if (!val.isEmpty && val != null) {
      setState(() {
        // _isload = true;
        this.val = val;
      });
    } else {
      setState(() {
        // _isload = true;
        this.val = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('RXDART'),
        ),
        body: new Container(
          child: new Form(
              child: new Column(
            children: <Widget>[
              new TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(labelText: 'First Name'),
                controller: textEditingController,
                onChanged: (str) => pb_subject.add(str),
              ),
              new Text(val)
            ],
          )),
        ));
  }
}
