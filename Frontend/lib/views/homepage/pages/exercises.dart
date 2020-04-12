import 'package:flutter/material.dart';
import 'package:strongr/widgets/strongr_text.dart';

class Exercises extends StatefulWidget {
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  @override
  Widget build(BuildContext context) {
    return Center(child: StrongrText('Exercises'),);
  }
}