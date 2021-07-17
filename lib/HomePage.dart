import 'dart:async';

import 'package:flutter/material.dart';
import 'package:launcherapp/SettingsPage.dart';
import 'package:launcherapp/commonCode.dart';

class HomePage extends StatefulWidget {
  final AppSettings appSettings;

  HomePage({Key key, this.appSettings}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    var now = DateTime.now();
    _timeString = currentTimeString(now);
    _weekDayDay = currentWeekDayDayString(now);
    _month = currentMonthString(now);
    _year = currentYearString(now);
//    _dateString = currentDateString();
    _clockTimer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => _getCurrentTime(),
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('home page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          // background wallpaper
          Container(),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: dateTimeCard(widget.appSettings.bgHueOpacity),
                  ),
                  // navigate to SettingsPage
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  Widget dateTimeCard(bgHueOpacity) {
    const textColor = Colors.white;
    const backgroundColor = Colors.black;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: bgHueOpacity,
          child: Container(
            width: double.maxFinite,
//            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '',
                textScaleFactor: 2,
              ),
            ),
            color: backgroundColor,
          ),
        ),
        Container(
//            color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _timeString,
//                textScaleFactor: 2.0,
                  style: TextStyle(
                    fontSize: 28,
                    color: textColor,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      _weekDayDay,
//                    textScaleFactor: 2.0,
                      style: TextStyle(
                        fontSize: 28,
                        color: textColor,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          _month,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          _year,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String singleToDoubleDigitPositiveInt(int i) {
    return i < 10 ? '0$i' : '$i';
  }

  String currentTimeString(now) {
    return '${singleToDoubleDigitPositiveInt(now.hour > 12 ? now.hour % 12 : now.hour)}:${singleToDoubleDigitPositiveInt(now.minute)} ${now.hour > 11 ? 'pm' : 'am'}';
    //      '${singleToDoubleDigitPositiveInt(now.hour % 12)}:${singleToDoubleDigitPositiveInt(now.minute)}:${singleToDoubleDigitPositiveInt(now.second)} ${now.hour > 11 ? 'pm' : 'am'}';
  }

  String currentWeekDayDayString(now) {
    return '${weekDays[now.weekday - 1]}, ${singleToDoubleDigitPositiveInt(now.day)} ';
    //  String currentMonthString() => '${monthNames[2]}';
  }

  void _getCurrentTime() {
    setState(() {
      var now = DateTime.now();
      _timeString = currentTimeString(now);
      _weekDayDay = currentWeekDayDayString(now);
      _month = currentMonthString(now);
      _year = currentYearString(now);
//      _dateString = currentDateString();
    });
  }

  String currentMonthString(now) {
    return '${monthNames[now.month - 1]}';
  }

  String currentYearString(now) {
    return '${now.year}';
  }

  String _timeString;

  String _weekDayDay;

  String _month;

  String _year;

  List weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  List monthNames = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  Timer _clockTimer;
}
