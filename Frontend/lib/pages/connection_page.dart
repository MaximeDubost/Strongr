import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'log_in_page.dart';
import 'sign_in_page.dart';

class ConnectionPage extends StatefulWidget {
  @override
  State createState() => new ConnectionPageState();
}

class ConnectionPageState extends State<ConnectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            Material(
              color: Color.fromRGBO(40, 140, 100, 1.0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, height / 3.25, 0, height / 3.24),
                child: Center(
                  child: Text(
                    "Strongr",
                    style: TextStyle(
                      fontSize: 50, 
                      fontFamily: 'Calibri',
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              color: Color.fromRGBO(20, 120, 80, 1.0),
              onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => LogInPage())),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, height / 20, 0, height / 20),
                child: Center(
                  child: Text(
                    "CONNEXION",
                    style: TextStyle(
                      fontSize: 28, 
                      fontFamily: 'Calibri',
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              color: Color.fromRGBO(0, 100, 60, 1.0),
              onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => SignInPage())),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, height / 20, 0, height / 20),
                child: Center(
                  child: Text(
                    "INSCRIPTION",
                    style: TextStyle(
                      fontSize: 28, 
                      fontFamily: 'Calibri',
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
