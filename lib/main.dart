// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var grid = [
      new GridItem("トマト", "pic0"),
      new GridItem("人参", "pic1"),
      new GridItem("ネギ", "pic2"),
      new GridItem("玉ねぎ", "pic3"),
      new GridItem("じゃがいも", "pic4"),];
    return MaterialApp(
        home: Scaffold(
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
                      new GridItem("トマト", "pic0"),
                      new GridItem("人参", "pic1"),
                      new GridItem("ネギ", "pic2"),
                      new GridItem("玉ねぎ", "pic3"),
                      new GridItem("じゃがいも", "pic4"),]);
                  }
                  return _gridWidget(grid[index]);
                }
            )
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
                        color: Colors.white.withOpacity(0.7),
                    ),
                    Container(
                      child: CircularProgressIndicator(value: 0.8, strokeWidth: 6.0,),
                      padding: EdgeInsets.all(10.0),
                    ),
                    Container(
                      child: Text(
                        "残り10日",
                        style: TextStyle(
                          color: Colors.blue,
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
}

class GridItem {
  String name;
  String image;

  GridItem(String name, String image) {
    this.name = name;
    this.image = image;
  }
}