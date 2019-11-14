import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/model.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getCategoriesApi() async {
  List<User> users = [];
  http.Response response1 =
      await http.get('http://52.38.106.96:81/WDS_SERVICE.svc/trucktypemaster');
  Map<String, dynamic> decodedCategories = json.decode(response1.body);
  var usersData = decodedCategories["getAllTruckTypeMasterResult"];

  for (var user in usersData) {
    // User newUser = User(user["TypeDescription"], user["BodyTypeDescription"]);

    //  users.add(newUser);
  }

  return users;
}

Future<List<Menu>> getMenuMasterApi() async {
  List<Menu> menus = [];
  http.Response response1 = await http.get(
      'http://52.38.106.96:81/WDS_SERVICE.svc/fleetintelligencemenumaster');
  Map<String, dynamic> decodedCategories = json.decode(response1.body);
  //print(response1);
  var mData = decodedCategories["getAllFleetIntelligenceMenuMasterResult"];

  for (var items in mData) {
    Menu newUser = Menu(items["MenuName"], items["Icons"], items["IsActive"]);

    menus.add(newUser);
  }

  return menus;
}
