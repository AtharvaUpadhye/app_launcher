import 'package:flutter/material.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:launcherapp/CardFeeds/CardFeedsPage.dart';
import 'package:launcherapp/HomePage.dart';

//import 'package:launcherapp/SettingsPage.dart';
import 'package:launcherapp/AppDrawerPage.dart';
import 'package:launcherapp/commonCode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InitiateLauncher(),
    );
  }
}

class InitiateLauncher extends StatefulWidget {
//  InitiateLauncher({Key key, this.title}) : super(key: key);
//  final String title;
  @override
  _InitiateLauncherState createState() => _InitiateLauncherState();
}

class _InitiateLauncherState extends State<InitiateLauncher> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(
        () => false,
      ),
      child: Scaffold(
        backgroundColor: appSettings.themeColor,
        body: Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              child: Image.asset(
                appSettings.wallpaper,
                fit: BoxFit.cover,
              ),
            ),
            PageView(
              controller: _controller,
              children: [
                CardFeedsPage(
                  appSettings: appSettings,
                ),
                HomePage(
                  appSettings: appSettings,
                ),
                AppDrawerPage(
                  installedApps: installedApps,
                  appSettings: appSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    appSettings = AppSettings(
      wallpaper: "assets/images/wallPaper.jpg",
      bgHueOpacity: 0.3,
      themeColor: Colors.blue,
      dayNightMode: Colors.black,
    );
    accessStorage = false;
    LauncherAssist.getAllApps().then((var apps) {
      setState(() {
        installedApps = apps;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var installedApps;
  var wallpaper;
  bool accessStorage;
  PageController _controller = PageController(initialPage: 1);
  AppSettings appSettings;
}
