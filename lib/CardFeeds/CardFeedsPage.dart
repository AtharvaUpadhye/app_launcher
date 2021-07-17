//import 'dart:async';
//import 'dart:convert';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:launcherapp/CardFeeds/CardsSubscriptionPage.dart';
import 'package:launcherapp/commonCode.dart';

class CardFeedsPage extends StatefulWidget {
  final AppSettings appSettings;

  CardFeedsPage({Key key, this.appSettings}) : super(key: key);

  @override
  _CardFeedsPageState createState() => _CardFeedsPageState();
}

class _CardFeedsPageState extends State<CardFeedsPage> {
  String resJson;
  String toOutput = 'offline';
  List obj;

  @override
  void initState() {
    makeGetRequest();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('card feeds page');
    });
  }

  makeGetRequest() async {
//    var a = ResCards();
//    await a.getResMap();
    http.Response a = await http.get(localhost() + '/launcher-cards');
//    if (this.mounted) {
//      print('waiting for 5 seconds');
//      await new Future.delayed(const Duration(seconds : 5));
    List<dynamic> b = [];
    http.Response response = await http.get(localhost() + '/card-options');
    var c = jsonDecode(response.body)['card-options'];
    for(int i=0; i<jsonDecode(a.body)['serverRes'].length; i++) {
      if(c[i]['bool'] == true) b.add(jsonDecode(a.body)['serverRes'][i]);
    }
    setState(() {
//      print(b);
      obj = b;
//      obj['serverRes'][3]['contents']['url'] = b.body;
//      print(obj['serverRes'].length);
    });
//    }
  }

  Widget topCard(context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardsSubscriptionPage(),
                  ),
                );
              },
              child: Container(
//              color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.dehaze,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
//            Container(
//              width: 40,
//              height: 40,
//              decoration: BoxDecoration(
//                shape: BoxShape.circle,
//                color: Colors.yellow, // if image not present
//                image: DecorationImage(
//                  image: AssetImage('assets/images/user-avatar.png'),
//                  fit: BoxFit.cover, // use this
//                ),
//              ),
//            ),
            Text(
              'MY CARDS',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow, // if image not present
                image: DecorationImage(
                  image: AssetImage('assets/images/user-avatar.png'),
                  fit: BoxFit.cover, // use this
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Widget serverResponseCard(index) {
////    print(obj['serverRes'][index]['card-type']);
//    if (obj['serverRes'][index]['card-type'].toString() == 'http-get') {
//      return Card(
//        child: ListTile(
//          title: Text(
//            obj['serverRes'][index]['contents']['url'].toString(),
//          ),
//        ),
//      );
//    } else {
////      print(obj['serverRes'][index]['card-type'].toString());
//      return Card(
//        color: Colors.blue,
//        child: ListTile(
//          title: Text(
//            obj['serverRes'][index]['card-type'].toString(),
//          ),
//        ),
//      );
//    }
//  }

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
          ListView.builder(
            itemCount: obj != null ? obj.length + 1 : 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return topCard(context);
              } else if (obj != null) {
                index--;
                return CardGenerator(obj: obj[index]);
//                return serverResponseCard(index);
              } else {
                return Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'cannot connect to server',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CardGenerator extends StatefulWidget {
  CardGenerator({Key key, this.obj}) : super(key: key);
  final obj;

  @override
  _CardGeneratorState createState() => _CardGeneratorState();
}

class _CardGeneratorState extends State<CardGenerator> {
  String scoreCardFetchedValue;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
//    print('await...g');
//    http.Response b = await http.get(
////        'https://www.google.com/search?q=live+covid+19+cases+in+nagpur');
//        'https://coronavirus-19-api.herokuapp.com/countries/India');
//    print(b.body);
    await new Future.delayed(const Duration(seconds: 1));
    String apiRes =
        '{"country":"India","cases":1339176,"todayCases":2154,"deaths":31425,"todayDeaths":19,"recovered":850303,"active":457448,"critical":8944,"casesPerOneMillion":970,"deathsPerOneMillion":23,"totalTests":15849068,"testsPerOneMillion":11478}';

//    var escape = RegExp.escape('\<');
//    print(escape);
//    RegExp regExp = new RegExp(
////      r"null}c=Aa\(c\);.*",
//      r"OrdL9b{3}.*Nagpur",
//    );
//    String a = regExp.stringMatch(b.body.toString());
//    print(a);
//    print('length : ${b.body.length}');
//    for(int i=0;i<b.body.length;i++) {
//      if(b.body.substring(i)=='\<span>Nagpur\</span>') {
//        print('gotchaa !');
//      }
//    }
//    print('length : ${b.body.length}');
    setState(() {
//      print(jsonDecode(apiRes)['active']);
      scoreCardFetchedValue = '${jsonDecode(apiRes)['active']}';
    });
  }

  Widget cardContents() {
    if (widget.obj['card-type'] == 'calendar')
      return Text('Today: ${widget.obj['contents']['today']}');
    else if (widget.obj['card-type'] ==
        'score-card') if (scoreCardFetchedValue == null)
      return Text(
          '${widget.obj['contents']['country']}: ${widget.obj['contents']['score']}');
    else
      return Text(
          '${widget.obj['contents']['country']}: $scoreCardFetchedValue');
    else if (widget.obj['card-type'] == 'quick-note')
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.obj['contents']['note-title'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(widget.obj['contents']['note-details']),
        ],
      );
    else
      return Text('else');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardContents(),
      ),
    );
  }
}
