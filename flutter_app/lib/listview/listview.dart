import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//LISTVIEW

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Users',
      home: new UsersList(),
    );
  }
}

class UsersList extends StatefulWidget {
  static String tag = 'list-page';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new UserListState();
  }
}

class UserListState extends State<UsersList> {
  TextEditingController searchController = new TextEditingController();
  String filter;

  @override
  initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Future<List<User>> _getUserList() async {
    List<User> users = [];
    var response = await http.get('https://api.randomuser.me/?results=20');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var jsonData = json.decode(response.body);
      var usersData = jsonData['results'];

      for (var user in usersData) {
        User newUser = User(user["name"]["first"] + user["name"]["last"],
            user["email"], user["picture"]["large"], user["phone"]);

        users.add(newUser);
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _confirmAlert(
      BuildContext context,
      String message,
    ) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  navigationButton();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final makeBody = new Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search names',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          ),
        ),
        new Expanded(
          child: FutureBuilder(
            future: _getUserList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                        onTap: () {
                          _confirmAlert(context, 'Welcom');
                        },
                        child: Card(
                          elevation: 10.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(snapshot.data[index].fullName,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                new Text(snapshot.data[index].fullName,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0)),
                                new Divider(),
                              ]),
                        ),
                      );
                    });

                /* return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.indigoAccent),
                          child: new ListTile(
                              title: Text(snapshot.data[index].fullName,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              leading: CircleAvatar(
                                backgroundImage:
                                NetworkImage(snapshot.data[index].imageUrl),
                              ),
                              onTap:(){_confirmAlert(context,'Welcom');}
                          )
                        ),
                      );
                    });*/
              }
            },
          ),
        ),
      ],
    );

    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          "Introduction to Driving",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(" Intermediate", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: new Text('List of Users'),
        actions: <Widget>[
          Padding(
            child: new Icon(Icons.search),
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
        ],
      ),
      body: makeBody,
    );
  }

  navigationButton() async {
    List<User> users = [];
    var response = await http.get('https://api.randomuser.me/?results=20');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var jsonData = json.decode(response.body);
      var usersData = jsonData['results'];

      for (var user in usersData) {
        User newUser = User(user["name"]["first"] + user["name"]["last"],
            user["email"], user["picture"]["large"], user["phone"]);

        users.add(newUser);
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }

    return users;
  }
}

class User {
  final String fullName;

  final String email;

  final String imageUrl;

  final String mobileNumber;

  User(this.fullName, this.email, this.imageUrl, this.mobileNumber);
}
