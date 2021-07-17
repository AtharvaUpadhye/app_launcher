import 'package:flutter/material.dart';

class ExtraWidgets extends StatefulWidget {
  @override
  _ExtraWidgetsState createState() => _ExtraWidgetsState();
}

class _ExtraWidgetsState extends State<ExtraWidgets> {
  Color _themeColor = Colors.white;
  Color _contrastThemeColor = Colors.blue;
  double _radius = 24;
  double _addRadius = 5;
  bool isLabel = true;
  double textSize = 14.0;

  Widget bottomColumn(isLabel) {
    if (isLabel) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.keyboard_arrow_up,
            color: _contrastThemeColor,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text('Quick settings'),
          )
        ],
      );
    }
    return Icon(
      Icons.keyboard_arrow_up,
      color: _contrastThemeColor,
    );
  }

  Widget dynamicBottomUpButton() {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: ElevatedButton(
                child: Text(
                  'set',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  setState(() {
                    print(_radius);
                    if (isLabel) {
                      _radius = 23.0; // TODO: to remove in production
                    } else {
                      _radius = 21.0 - textSize / 2;
                    }

                    _addRadius = 0; // TODO: to remove in production
                    _radius = _radius + _addRadius;
                    print(_radius);
                  });
                },
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  height: _radius * 2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: _themeColor,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(
//                            topRight: Radius.circular(0.0),
                                bottomRight: Radius.circular(_radius),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _settingModalBottomSheet(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _themeColor,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(_radius),
                              ),
                            ),
                            child: AspectRatio(
                              aspectRatio: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: bottomColumn(isLabel),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: _themeColor,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(_radius),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
