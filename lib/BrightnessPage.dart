import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

class BrightnessPage extends StatefulWidget {
  @override
  _BrightnessPageState createState() => new _BrightnessPageState();
}

class _BrightnessPageState extends State {
  bool _isKeptOn = false;
  double _brightness = 1.0;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState((){
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: new Text('Screen plugin example')),
        body: new Center(
            child: new Column(
                children: [
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text("Screen is kept on ? "),
                        new Checkbox(value: _isKeptOn, onChanged: (bool b){
                          Screen.keepOn(b);
                          setState((){_isKeptOn = b; });
                        })
                      ]
                  ),
                  new Text("Brightness :"),
                  new Slider(value : _brightness, onChanged : (double b){
                    setState((){_brightness = b;});
                    Screen.setBrightness(b);
                  })
                ]
            )
        ),
      ),
    );
  }
}