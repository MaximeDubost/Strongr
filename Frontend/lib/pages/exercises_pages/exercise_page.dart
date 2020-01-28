import 'package:flutter/material.dart';

import '../../main.dart';

class ExercisePage extends StatefulWidget {
  final String _exerciseName;

  ExercisePage(this._exerciseName);

  @override
  State createState() => ExercisePageState();
}

class ExercisePageState extends State<ExercisePage> {
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
        title: Text(widget._exerciseName),
        backgroundColor: PrimaryColor,
      ),
    );
  }
}