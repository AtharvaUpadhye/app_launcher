import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:launcherapp/commonCode.dart';

class CardsSubscriptionPage extends StatefulWidget {
  @override
  _CardsSubscriptionPageState createState() => _CardsSubscriptionPageState();
}

class _CardsSubscriptionPageState extends State<CardsSubscriptionPage> {
  var subscriptions;

  @override
  void initState() {
    getSubscriptions();
    super.initState();
  }

  getSubscriptions() async {
    http.Response response = await http.get(localhost() + '/card-options');
    setState(() {
      subscriptions = jsonDecode(response.body);
    });
  }

//  List<Icon> subsListIcons = [Icon(Icons.calendar_today), Icon(Icons.score)];
//  List<String> subsListIconNames = ['calendar_today', 'score'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('subscriptions'),
      ),
      body: ListView.builder(
        itemCount:
            subscriptions != null ? subscriptions['card-options'].length : 1,
        itemBuilder: (BuildContext context, int index) {
          if (subscriptions != null) {
            return CheckboxListTile(
              title: Text(subscriptions['card-options'][index]['title']),
              value: subscriptions['card-options'][index]['bool'],
//              secondary: subsListIcons[index],
              onChanged: (bool val) {
                setState(() {
                  subscriptions['card-options'][index]['bool'] =
                      !subscriptions['card-options'][index]['bool'];
                });
              },
            );
          } else {
            return Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'cannot connect to server',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text('Save'),
            onPressed: () {
              print('saved !');
            },
          ),
        ],
      ),
    );
  }
}
