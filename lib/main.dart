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
              title: Text('GridView'),
            ),
            body: GridView.builder(
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
                  return _photoItem(grid[index]);
                }
            )
        )
    );
  }

  Widget _photoItem(GridItem item) {
    var assetsImage = "images/" + item.image + ".jpg";
    return Container(
      child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.asset(assetsImage, fit: BoxFit.cover,),
            ),
            Expanded(
              child: Container(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(item.name),
                ),
                color: Colors.grey,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      padding: EdgeInsets.all(5.0),
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