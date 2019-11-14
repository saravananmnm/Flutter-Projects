import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key}) : super(key: key);
  static String tag = 'Image';

  @override
  ImagePageState createState() {
    // TODO: implement createState
    return ImagePageState();
  }
}

class ImagePageState extends State<ImagePage> {
  File image;

  @override
  Widget build(BuildContext context) {
    _onPressed() async {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      print(image.path != null ? image.path : '');
      setState(() {});
    }

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(title: new Text("My Home Page")),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: new Text("My Todos"),
              onPressed: _onPressed,
            ),
            Center(
                heightFactor: 1.0,
                widthFactor: 1.0,
                child:
                    image != null ? Image.file(image) : new Text('No image')),
          ],
        ),
      ),
    );
  }
}
