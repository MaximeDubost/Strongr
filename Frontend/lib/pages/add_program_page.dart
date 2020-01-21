import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AddProgramPage extends StatefulWidget {
  @override
  State createState() => AddProgramPageState();
}

class AddProgramPageState extends State<AddProgramPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  bool _isEmptyList = true;
  List<String> _sessionsList = [];

  @override
  void initState() {
    super.initState();
  }

  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Vous ne pouvez pas créer un programme vide'),
      backgroundColor: Colors.red,
    );
    globalKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Nouveau programme"),
        actions: <Widget>[
          Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.check),
              color: Colors.white,
              onPressed: _isEmptyList
                  ? () {
                      showSnackbar(context);
                    }
                  : () {
                      Navigator.of(context).pop();
                    },
            ),
          ),
        ],
        backgroundColor: PrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
        //     builder: (BuildContext context) => AddSessionPage())),
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
                  "Aucune séance.",
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
                    Container(
                      //color: Colors.red,
                      height: height / 8,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: TextFormField(
                            //autofocus: true,
                            maxLength: 30,
                            //validator: validateEmail,
                            onSaved: (String value) {
                              //email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.grey,
                            //controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Libellé',
                              labelStyle: TextStyle(color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(40, 140, 100, 1.0))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_isEmptyList,
                      child: Container(
                        //color: Colors.cyan,
                        height: height / 16,
                        child: Center(
                          child: Text(
                            "Séances",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Calibri',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_isEmptyList,
                      child: Expanded(
                        child: Container(
                          //color: Colors.indigo,
                          child: ListView.separated(
                            itemCount: _sessionsList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_sessionsList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
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
