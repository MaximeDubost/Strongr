import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/pages/exercises_pages/exercise_page.dart';

import '../../main.dart';

class SetExercisePage extends StatefulWidget {
  final String _exerciseName;

  SetExercisePage(this._exerciseName);

  @override
  State createState() => SetExercisePageState();
}

class SetExercisePageState extends State<SetExercisePage> {
  var _equipmentList = [
    "Équipement",
    "Aucun équipement",
    "Équipement 1",
    "Équipement 2",
    "Équipement 3",
    "Équipement 4",
    "Équipement 5",
  ];
  var _workMethodsList = [
    "Méthode de travail",
    "Méthode de travail 1",
    "Méthode de travail 2",
    "Méthode de travail 3",
    "Méthode de travail 4",
    "Méthode de travail 5",
    "Méthode de travail personnalisée",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      //key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info_outline),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => ExercisePage(widget._exerciseName)));
              }),
        ],
        title: Text(widget._exerciseName),
        backgroundColor: PrimaryColor,
      ),
      body: Container(
        child: Center(
          child: Form(
            child: Column(
              children: <Widget>[
                Container(
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: DropdownButtonFormField(
                      onChanged: (newValue) {},
                      items: <DropdownMenuItem>[
                        for (var item in _equipmentList)
                          DropdownMenuItem(
                            child: Text(item),
                          ),
                      ],
                      hint: Text("Équipement"),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: DropdownButtonFormField(
                      onChanged: (newValue) {},
                      items: <DropdownMenuItem>[
                        for (var item in _workMethodsList)
                          DropdownMenuItem(
                            child: Text(item),
                          ),
                      ],
                      hint: Text("Méthode de travail"),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 5, 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Séries',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Répétitions',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Repos',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.check),
        backgroundColor: PrimaryColor,
      ),
    );
  }
}
