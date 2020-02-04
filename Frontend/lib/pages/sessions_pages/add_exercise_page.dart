import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/pages/exercises_pages/exercise_page.dart';

import '../../main.dart';
import 'set_exercise_page.dart';

class AddExercisePage extends StatefulWidget {
  @override
  State createState() => AddExercisePageState();
}

class AddExercisePageState extends State<AddExercisePage> {
  bool _isEmptyList = false;
  bool _isSearching = false;
  List<String> _exercisesList = ExercisesList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: globalKey,
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
                  hintText: "Rechercher un exercice...",
                  hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            : Text("Ajouter un exercice"),
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
      body: Container(
        //color: Colors.green,
        child: Stack(
          children: <Widget>[
            Center(
              child: Visibility(
                visible: _isEmptyList,
                child: Text(
                  "Aucun exercice trouvé.",
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
                              for (final item in _exercisesList)
                                ListTile(
                                  key: ValueKey(item),
                                  leading: Icon(Icons.add, color: Colors.grey),
                                  trailing: IconButton(
                                    icon: Icon(Icons.help_outline,
                                        color: SecondaryColor),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (BuildContext context) =>
                                                  ExercisePage(exerciseName: item)));
                                    },
                                  ),
                                  title: Text(
                                    item,
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Calibri',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (BuildContext context) =>
                                            SetExercisePage(item),
                                      ),
                                    );
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
