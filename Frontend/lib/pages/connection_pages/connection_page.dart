import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/utils/no_animation_material_page_route.dart';

import '../../main.dart';
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

    return WillPopScope(
      onWillPop: () async => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Se déconnecter ?'),
          content: Text('Vous allez être redirigé vers la page de connexion'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () => exit(0), //Navigator.pop(c, true),
            ),
            FlatButton(
              child: Text('Annuler'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Material(
                  color: Color.fromRGBO(40, 140, 100, 1.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/strongr_logo.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Strongr",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Calibri',
                              color: DarkColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: Color.fromRGBO(20, 120, 80, 1.0),
                onPressed: () => Navigator.of(context).push(NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => LogInPage())),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, height / 20, 0, height / 20),
                  child: Center(
                    child: Text(
                      "CONNEXION",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Calibri',
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: Color.fromRGBO(0, 100, 60, 1.0),
                onPressed: () => Navigator.of(context).push(NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => SignInPage())),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, height / 20, 0, height / 20),
                  child: Center(
                    child: Text(
                      "INSCRIPTION",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Calibri',
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
