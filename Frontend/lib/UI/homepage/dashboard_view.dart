import 'package:flutter/material.dart';

import '../../main.dart';

class DashboardView extends StatefulWidget {
  @override
  State createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  List<String> _currentSessionsList = SessionsList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        //color: Colors.cyan,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bonjour Maxime ! ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.bold,
                    color: PrimaryColor),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Votre séance du jour",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: DropdownButton(
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  onChanged: (newValue) {},
                  items: <DropdownMenuItem>[
                    for (var item in _currentSessionsList)
                    DropdownMenuItem(
                      child: Text(item),
                    ),
                  ],
                  hint: Text("Équipement"),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Changer de programme",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Calibri',
                      color: Colors.grey[400]),
                ),
              ),
              RaisedButton(
                color: Color.fromRGBO(40, 140, 100, 1.0),
                disabledColor: Colors.grey,
                onPressed: () {},
                child: Text(
                  "C'est parti !",
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Calibri', color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    // side: BorderSide(color: SecondaryColor)
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         "Bonjour Maxime ! ",
      //         textAlign: TextAlign.center,
      //         style: TextStyle(
      //             fontSize: 28,
      //             fontFamily: 'Calibri',
      //             fontWeight: FontWeight.bold,
      //             color: PrimaryColor),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      //         child: Text(
      //           "C'est bien vide par ici... 🤔",
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //               fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
      //         child: Text(
      //           "Que diriez-vous de nous en dire un peu plus sur vous ?",
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //               fontSize: 18,
      //               fontFamily: 'Calibri',
      //               fontWeight: FontWeight.bold,
      //               color: Colors.grey),
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      //         child: RaisedButton(
      //           color: Color.fromRGBO(40, 140, 100, 1.0),
      //           disabledColor: Colors.grey,
      //           onPressed: () {},
      //           child: Text(
      //             "Allons-y !",
      //             style: TextStyle(
      //                 fontSize: 16, fontFamily: 'Calibri', color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
