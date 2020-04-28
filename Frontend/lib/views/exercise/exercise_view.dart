import 'package:flutter/material.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExerciseView extends StatefulWidget {
  final String id;
  final String name;

  ExerciseView({this.id, this.name});

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'exercise_fab_' + widget.id.toString(),
        icon: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        backgroundColor: StrongrColors.blue,
        onPressed: () {},
        label: StrongrText(
          "Démarrer",
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
