import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/programs_pages/create_program_page.dart';

import '../main.dart';

class ProgramsView extends StatefulWidget {
  @override
  State createState() => ProgramsViewState();
}

class ProgramsViewState extends State<ProgramsView> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 2,
      height: 1.0,
      color: SecondaryColor,
      //margin: EdgeInsets.only(top: 4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;

    Visibility programList = Visibility(
      visible: false,
      child: Container(
        color: Colors.green,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => CreateProgramPage())),
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
                    "Aucun programme.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Calibri',
                        color: Colors.grey),
                  ),
                  programList
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                //color: Colors.blue,
                height: height / 12,
                child: Center(
                  child: Text(
                    "Programmes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Calibri',
                        fontWeight: FontWeight.bold,
                        color: PrimaryColor),
                  ),
                ),
              ),
              _buildSeparator(screenSize),
            ],
          )
        ],
      ),
    );
  }
}
