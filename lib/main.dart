// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScaffoldBody()
    );
  }
}

class ScaffoldBody extends StatefulWidget {
  @override
  State createState() => new ScaffoldBodyState();
}

class ScaffoldBodyState extends State<ScaffoldBody> {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  var grid = [
    new GridItem("ヨーグルト", "pic5", 0.1, 1),
    new GridItem("じゃがいも", "pic4", 0.2, 1),
    new GridItem("サラダ", "pic12", 0.5, 1),
    new GridItem("卵", "pic9", 0.1, 1),
    new GridItem("豚バラ肉", "pic8", 1.0, 2),
    new GridItem("鶏もも", "pic14", 1.0, 2),
    new GridItem("トマト", "pic0", 0.5, 3),
    new GridItem("人参", "pic1", 0.5, 3),
    new GridItem("サラダチキン", "pic13", 0.4, 4),
    new GridItem("ネギ", "pic2", 0.6, 4),
    new GridItem("玉ねぎ", "pic3", 0.7, 5),
    new GridItem("プリン", "pic7", 0.7, 5),
    new GridItem("味噌", "pic10", 0.7, 5),
    new GridItem("牛乳", "pic6", 1.0, 5),
    new GridItem("にんにく", "pic11", 0.9, 6),
  ];

  @override
  void initState() {
    super.initState();
    // Set notification functions.
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _buildDialog(context, "onMessage");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _buildDialog(context, "onLaunch");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _buildDialog(context, "onResume");
      },
    );
    // Approve notification.
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('賞味期限一覧'),
        ),
        body: GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index >= grid.length) {
                grid.addAll([
                  new GridItem("ヨーグルト", "pic5", 0.1, 1),
                  new GridItem("じゃがいも", "pic4", 0.2, 1),
                  new GridItem("サラダ", "pic12", 0.5, 1),
                  new GridItem("卵", "pic9", 0.1, 1),
                  new GridItem("豚バラ肉", "pic8", 1.0, 2),
                  new GridItem("鶏もも", "pic14", 1.0, 2),
                  new GridItem("トマト", "pic0", 0.5, 3),
                  new GridItem("人参", "pic1", 0.5, 3),
                  new GridItem("サラダチキン", "pic13", 0.4, 4),
                  new GridItem("ネギ", "pic2", 0.6, 4),
                  new GridItem("玉ねぎ", "pic3", 0.7, 5),
                  new GridItem("プリン", "pic7", 0.7, 5),
                  new GridItem("味噌", "pic10", 0.7, 5),
                  new GridItem("牛乳", "pic6", 1.0, 5),
                  new GridItem("にんにく", "pic11", 0.9, 6),
                ]);
              }
              return _gridWidget(grid[index]);
            }
        )
    );
  }

  Widget _gridWidget(GridItem item) {
    var assetsImage = "images/" + item.image + ".jpg";
    return Container(
      child: Column(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(assetsImage, fit: BoxFit.cover,),
                  Container(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  Container(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          item.remainingDays <= 1 ? Colors.orange : Colors
                              .blue),
                      value: item.progress,
                      strokeWidth: 6.0,
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    child: Text(
                      "残り" + item.remainingDays.toString() + "日",
                      style: TextStyle(
                          color: item.remainingDays <= 1
                              ? Colors.orange
                              : Colors.blue,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                  ),
                ],
              )
          ),
          Expanded(
            child: Container(
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(item.name),
              ),
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.0),
    );
  }

  void _buildDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new Text("Message: $message"),
          actions: <Widget>[
            new FlatButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            new FlatButton(
              child: const Text('SHOW'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      }
    );
  }
}

class GridItem {
  String name;
  String image;
  double progress;
  int remainingDays;

  GridItem(String name, String image, double progress, int remainingDays) {
    this.name = name;
    this.image = image;
    this.progress = progress;
    this.remainingDays = remainingDays;
  }
}