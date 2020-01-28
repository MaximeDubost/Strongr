import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/sessions_pages/create_session_page.dart';

import '../../main.dart';

class AddSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Ajouter une séance"),
        backgroundColor: PrimaryColor,
      ),
      body: Container(
        //color: Colors.cyan,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Vous n'avez pas encore créé de séance.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: RaisedButton(
                  color: Color.fromRGBO(40, 140, 100, 1.0),
                  disabledColor: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) => CreateSessionPage()));
                  },
                  child: Text(
                    "Créer une séance",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Calibri',
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
