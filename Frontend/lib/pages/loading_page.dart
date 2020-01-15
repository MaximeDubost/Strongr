import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'connection_page.dart';

class LoadingPage extends StatefulWidget {
   @override
  State createState() => new LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => skip(context));
  }

  void skip(context) {
    sleep(Duration(seconds: 1));
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (BuildContext context) => ConnectionPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(40, 140, 100, 1.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ConnectionPage())),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Strongr",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
