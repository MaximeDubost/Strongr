import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/add_session_page.dart';

import '../main.dart';

class SessionsView extends StatefulWidget {
  @override
  State createState() => SessionsViewState();
}

class SessionsViewState extends State<SessionsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    Visibility sessionsList = Visibility(
      visible: false,
      child: Container(
        color: Colors.green,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => AddSessionPage())),
        child: Icon(Icons.add),
        backgroundColor: PrimaryColor,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            //color: Colors.red,
            height: height,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Text(
                    "Aucune séance.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Calibri',
                        color: Colors.grey),
                  ),
                  sessionsList
                ],
              ),
            ),
          ),
          Container(
            //color: Colors.blue,
            height: height / 8,
            child: Center(
              child: Text(
                "Séances",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.bold,
                    color: PrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
