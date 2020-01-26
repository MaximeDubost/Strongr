import 'package:flutter/material.dart';

class ExercisesView extends StatefulWidget {
  @override
  State createState() => ExercisesViewState();
}

class ExercisesViewState extends State<ExercisesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.fitness_center),
            Text("Exercices")
          ],
        ),
      ),
    );
  }
}