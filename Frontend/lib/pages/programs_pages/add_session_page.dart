import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/pages/sessions_pages/create_session_page.dart';

import '../../main.dart';

class AddSessionPage extends StatefulWidget {
  @override
  State createState() => AddSessionPageState();
}

class AddSessionPageState extends State<AddSessionPage> {
  bool _isEmptyList = false;
  bool _isSearching = false;
  List<String> _sessionsList = SessionsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: _isSearching
              ? () => setState(() {
                    _isSearching = false;
                  })
              : () => Navigator.of(context).pop(),
        ),
        title: _isSearching
            ? TextField(
                autofocus: true,
                cursorColor: DarkColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Rechercher une séance...",
                  hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            : Text("Ajouter une séance"),
        actions: <Widget>[
          !_isSearching
              ? IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  })
              : Container() //IconButton(icon: null, onPressed: () {},)
        ],
        backgroundColor: PrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isSearching = false;
          });
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => CreateSessionPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: PrimaryColor,
      ),
      body: Container(
        //color: Colors.green,
        child: Stack(
          children: <Widget>[
            Center(
              child: Visibility(
                visible: _isEmptyList,
                child: Text(
                  "Vous n'avez aucune séance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
                ),
              ),
            ),
            Container(
              //color: Colors.transparent,
              child: Form(
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: !_isEmptyList,
                      child: Expanded(
                        child: Container(
                          //color: Colors.indigo,
                          child: ListView(
                            children: <Widget>[
                              for (final item in _sessionsList)
                                ListTile(
                                  key: ValueKey(item),
                                  leading: Icon(Icons.add),
                                  title: Text(
                                    item,
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Calibri',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                  subtitle: Text(
                                    "4 exercices",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Calibri',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  onTap: () {
                                    // Navigator.of(context).pop();
                                    setState(() {
                                      _isSearching = false;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
