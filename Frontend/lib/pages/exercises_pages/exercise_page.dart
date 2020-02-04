import 'package:flutter/material.dart';

import '../../main.dart';

class ExercisePage extends StatefulWidget {
  final String exerciseName;

  ExercisePage({Key key, this.exerciseName}) : super(key: key);

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
        title: Text(widget.exerciseName),
        backgroundColor: PrimaryColor,
      ),
      body: Center(
        child: Text(
          "Bientôt disponible.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
        ),
      ),
    );
  }
}
