import 'package:flutter/material.dart';

import '../main.dart';

class DashboardView extends StatefulWidget {
  @override
  State createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bonjour Maxime ! ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.bold,
                  color: PrimaryColor),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                "C'est bien vide par ici... 🤔",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
              child: Text(
                "Que diriez-vous de nous en dire un peu plus sur vous ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: RaisedButton(
                color: Color.fromRGBO(40, 140, 100, 1.0),
                disabledColor: Colors.grey,
                onPressed: () {},
                child: Text(
                  "Allons-y !",
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Calibri', color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
