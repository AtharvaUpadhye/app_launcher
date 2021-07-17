// import 'dart:convert';
import 'dart:io';
import 'dart:ui';

//import 'package:http/http.dart';

class AppSettings {
  String wallpaper;
  double bgHueOpacity;
  Color themeColor;
  Color dayNightMode;

  AppSettings(
      {this.wallpaper, this.bgHueOpacity, this.themeColor, this.dayNightMode});
}

String localhost() {
  if (Platform.isAndroid)
    return 'http://10.0.2.2:3000';
  else // for iOS simulator
    return 'http://localhost:3000';
}

//Future<String> getResBody(String reqRoute) async {
//  Response response = await get(localhost() + reqRoute);
//  String resString = response.body;
////  Map jsonObj = jsonDecode(resString);
////  var a = ResCards.fromJson(jsonObj);
//  return resString;
//}

//class ResCards {
//  String resString;
//  Map jsonMap;
//  String cardType;
//
//  getResMap() async {
//    Response response = await get(localhost() + '/launcher-cards');
//    this.resString = response.body;
//    this.jsonMap = jsonDecode(resString);
//  }
//
//  getCardType() {
//    getResBody('/launcher-cards');
//    Map jsonObj = jsonDecode(resString);
//    print(jsonObj);
////  var a = ResCards.fromJson(jsonObj);
//  }
//}

class InstalledApps {
  String package;
  List<int> icon;
  String label;

  InstalledApps({this.package, this.icon, this.label});

  InstalledApps.fromJson(Map<String, dynamic> json) {
    package = json['package'];
    icon = json['icon'].cast<int>();
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package'] = this.package;
    data['icon'] = this.icon;
    data['label'] = this.label;
    return data;
  }
}
