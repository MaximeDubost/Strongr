import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'add_session_page.dart';

class CreateProgramPage extends StatefulWidget {
  @override
  State createState() => CreateProgramPageState();
}

class CreateProgramPageState extends State<CreateProgramPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  bool _isEmptyList = true;
  List<String> _sessionsList = [];

  @override
  void initState() {
    super.initState();
  }

  void showSnackbar(BuildContext context) {
    globalKey.currentState.removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text('Vous ne pouvez pas créer un programme vide.'),
      backgroundColor: Colors.red,
    );
    globalKey.currentState.showSnackBar(snackBar);
  }

  // Widget _buildSeparator(Size screenSize) {
  //   return Container(
  //     width: screenSize.width / 2,
  //     height: 1.0,
  //     color: SecondaryColor,
  //     //margin: EdgeInsets.only(top: 4.0),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
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
        onPressed: () {
          globalKey.currentState.removeCurrentSnackBar();
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => AddSessionPage()));
        },
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
                  "Ajoutez votre première séance.",
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
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            //autofocus: true,
                            //maxLength: 30,
                            //validator: validateEmail,
                            onSaved: (String value) {
                              //email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.grey,
                            //controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Nom du programme",
                              hintStyle: TextStyle(fontSize: 16, fontFamily: 'Calibri', color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(40, 140, 100, 1.0))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   //color: Colors.yellow,
                    //   height: height / 16,
                    //   child: Padding(
                    //     padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    //     child: Text(
                    //       "Exercices",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           fontSize: 18,
                    //           fontFamily: 'Calibri',
                    //           color: PrimaryColor),
                    //     ),
                    //   ),
                    // ),
                    // _buildSeparator(screenSize),
                    Visibility(
                      visible: !_isEmptyList,
                      child: Container(
                        //color: Colors.cyan,
                        height: height / 16,
                        child: Center(
                          child: Text(
                            "Programmes",
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
