import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExerciseView extends StatefulWidget {
  final String id;

  ExerciseView({this.id});

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercice " + widget.id),),
      body: Container(),
    );
  }
}