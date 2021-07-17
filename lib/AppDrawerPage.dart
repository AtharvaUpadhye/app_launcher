import 'dart:convert';
import 'dart:typed_data';

//import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:permission_handler/permission_handler.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:launcherapp/commonCode.dart';

class AppDrawerPage extends StatefulWidget {
  final installedApps;
  final AppSettings appSettings;

  AppDrawerPage({Key key, this.installedApps, this.appSettings})
      : super(key: key);

  @override
  _AppDrawerPageState createState() => _AppDrawerPageState();
}

class _AppDrawerPageState extends State<AppDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: widget.appSettings.bgHueOpacity,
            child: Container(
              color: Colors.black,
            ),
          ),
          // show all apps
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: widget.installedApps != null
                ? ForegroundWidget(installedApps: widget.installedApps)
                : Container(),
          ),
          // search bar
          Column(
            children: <Widget>[
              Expanded(child: Container()),
              searchBar(textEditingController: _textEditingController),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('all apps page');
    });
  }

  Widget searchBar({
    TextEditingController textEditingController,
    String str,
  }) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(100),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.text,
              controller: textEditingController,
              onChanged: (String s) {
                setState(() {
                  this._string = s;
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.requestFocus(
                      new FocusNode(),
                    );
                  }
                });
                print(_string);
              },
              decoration: new InputDecoration(
                hintText: "item to search",
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController _textEditingController;
  String _string = '';
}

class ForegroundWidget extends StatefulWidget {
  const ForegroundWidget({
    Key key,
    @required this.installedApps,
  }) : super(key: key);
  final installedApps;

  @override
  _ForegroundWidgetState createState() => _ForegroundWidgetState();
}

// widget.installedApps
class _ForegroundWidgetState extends State<ForegroundWidget> {
  int noOfAppIconsInOneRow;
  var myApps;
  var blankApp;

  myInstalledApps(w) {
    List<dynamic> testJson = [];
    for (int i = 0; i < widget.installedApps.length; i++) {
      testJson.add(w[i]);
    }
    var blankApp = jsonDecode('{"package":"", "icon": [], "label":""}');
    for (int i = 0; i < noOfAppIconsInOneRow; i++) {
      testJson.add(blankApp);
    }
    return testJson;
  }

  @override
  void initState() {
    noOfAppIconsInOneRow = 4;
//    var testJson = jsonDecode(jsonEncode(widget.installedApps));
    myApps = myInstalledApps(widget.installedApps);
//    var temp = jsonEncode(testJson[2]['icon'] = Uint8List(0));
//    var s = InstalledApps.fromJson(testJson);
//    s.icon = null;
//    print(s.icon);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: noOfAppIconsInOneRow,
        mainAxisSpacing: 0,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: List.generate(
          myApps != null ? myApps.length : 0,
          (index) => GestureDetector(
            // each block
            child: Container(
//                decoration: BoxDecoration(border: Border.all()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 7),
                  iconContainer(index),
                  SizedBox(height: 1),
                  // label
                  Text(
                    myApps[index]["label"],
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            onTap: () => LauncherAssist.launchApp(myApps[index]["package"]),
          ),
        ),
      ),
    );
  }

  iconContainer(index) {
    try {
      return Image.memory(
        myApps[index]["icon"] != null ? myApps[index]["icon"] : Uint8List(0),
        height: 45,
        width: 45,
      );
    } catch (e) {
      return Container();
    }
  }
}

//class WallpaperContainer extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.white,
//      child: Image(
//        width: double.maxFinite,
//        image: AssetImage('assets/images/Amoled abstract.jpeg'),
//        fit: BoxFit.cover,
//      ),
//    );
//  }
//}
