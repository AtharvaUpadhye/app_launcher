import 'package:flutter/material.dart';
import 'package:launcherapp/BrightnessPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
//            color: Colors.blue,
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Music'),
                  onTap: () {},
//                  onTap: () => {
//                    showBottomSheet(
//                        context: context,
//                        builder: (BuildContext c) {
//                          // not a good idea
//                          // not implementable
//                          // these children get stuck on screen and we cannot go back
//                          return Container(
//                            child: Wrap(
//                              children: <Widget>[
//                                ListTile(
//                                  title: Text('a'),
//                                ),
//                                ListTile(
//                                  title: Text('b'),
//                                ),
//                              ],
//                            ),
//                          );
//                        })
//                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Video'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  void _settingModalBottomSheet2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
//            color: Colors.blue,
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.android),
                  title: new Text('Android'),
                  onTap: () {},
//                  onTap: () => {
//                    showBottomSheet(
//                        context: context,
//                        builder: (BuildContext c) {
//                          // not a good idea
//                          // not implementable
//                          // these children get stuck on screen and we cannot go back
//                          return Container(
//                            child: Wrap(
//                              children: <Widget>[
//                                ListTile(
//                                  title: Text('a'),
//                                ),
//                                ListTile(
//                                  title: Text('b'),
//                                ),
//                              ],
//                            ),
//                          );
//                        })
//                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.wallpaper),
                  title: new Text('Wallpaper'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
//      appBar: AppBar(
//        title: Text('Settings page'),
//      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _settingModalBottomSheet(context);
              },
              child: Text('tap 1'),
            ),
            ElevatedButton(
              onPressed: () {
                _settingModalBottomSheet2(context);
              },
              child: Text('tap 2'),
            ),
            ElevatedButton(
              child: Icon(Icons.brightness_7),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrightnessPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
