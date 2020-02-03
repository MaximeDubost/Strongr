import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/UI/dialogs/custom_dialog.dart';
import 'package:strongr/pages/exercises_pages/exercise_page.dart';
import 'package:strongr/pages/exercises_pages/search_exercise.dart';

import '../../main.dart';

class ExercisesView extends StatefulWidget {
  @override
  State createState() => ExercisesViewState();
}

class ExercisesViewState extends State<ExercisesView> {
  List<String> _exercisesList = ExercisesList;
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

  // Widget _buildListSeparator(Size screenSize) {
  //   return Container(
  //     width: screenSize.width / 1.05,
  //     height: 1.0,
  //     color: LightLightGrey,
  //     //margin: EdgeInsets.only(top: 4.0),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    _isEmptyList = _exercisesList.length == 0 ? true : false;

    Visibility exercisesList = Visibility(
      visible: false,
      child: Container(
        color: Colors.green,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => SearchExercisePage())),
        child: Icon(Icons.search),
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
                      "Impossible de charger la liste des exercices.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Calibri',
                          color: Colors.grey),
                    ),
                    exercisesList
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                // color: Colors.blue,
                height: height / 12,
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Exercices",
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
                        icon: Icon(Icons.tune),
                        color: DarkColor,
                        iconSize: 24,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog("Filtres", "Bientôt disponible.", "", "OK");
                            },
                          );
                        },
                      ),
                    )
                    ],
                  ),
                ),
              ),
              _buildSeparator(screenSize),
              Expanded(
                child: Container(
                  //color: Colors.indigo,
                  child: ListView(
                    children: <Widget>[
                      for (final item in _exercisesList)
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
                          // trailing: Icon(Icons.help_outline),
                          onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      ExercisePage(item))),
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
