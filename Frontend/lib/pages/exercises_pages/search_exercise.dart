import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'exercise_page.dart';

class SearchExercisePage extends StatefulWidget {
  @override
  State createState() => SearchExercisePageState();
}

class SearchExercisePageState extends State<SearchExercisePage> {
  List<String> _exercisesList = ExercisesList;

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
        title: TextField(
          autofocus: true,
          cursorColor: DarkColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Rechercher un exercice...",
            hintStyle: TextStyle(
                fontSize: 18, fontFamily: 'Calibri', color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: PrimaryColor,
      ),
      body: Container(
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
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  trailing: Icon(Icons.help_outline),
                  onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) => ExercisePage(item))),
                ),
            ],
          ),
        ),
    );
  }
}
