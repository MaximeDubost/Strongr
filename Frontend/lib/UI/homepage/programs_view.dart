import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/pages/programs_pages/create_program_page.dart';
import 'package:strongr/pages/programs_pages/program_page.dart';

import '../../main.dart';
import '../dialogs/order_by_dialog.dart';

class ProgramsView extends StatefulWidget {
  @override
  State createState() => ProgramsViewState();
}

class ProgramsViewState extends State<ProgramsView> {
  List<String> _programsList = ProgramsList;
  bool _isEmptyList;

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
    _isEmptyList = _programsList.length == 0 ? true : false;

    Visibility programsList = Visibility(
      visible: !_isEmptyList,
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
          Visibility(
            visible: _isEmptyList,
            child: Container(
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
                    programsList
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                //color: Colors.blue,
                height: height / 12,
                child: Stack(
                  children: <Widget>[
                    Center(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.list),
                        color: DarkColor,
                        iconSize: 28,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return OrderByDialog(["Date de création", "Ordre alphabétique"]);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              _buildSeparator(screenSize),
              Expanded(
                child: Container(
                  //color: Colors.indigo,
                  child: ListView(
                    children: <Widget>[
                      for (final item in _programsList)
                        ListTile(
                          key: ValueKey(item),
                          // leading: Icon(Icons.add),
                          title: Text(
                            item,
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Calibri',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          subtitle: Text("5 séances, 20 exercices", style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Calibri',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey)),
                          // trailing: Icon(Icons.help_outline),
                          onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      ProgramPage(item))),
                        ),
                    ],
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
