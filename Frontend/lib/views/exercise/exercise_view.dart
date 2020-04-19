import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/new_exercise_from_list_dialog.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExerciseView extends StatefulWidget {
  final int id;
  final String name;
  final bool isBelonged;

  ExerciseView({this.id, this.name, this.isBelonged = false});

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
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
            child: StrongrText(
          "Informations exercice",
          color: Colors.grey,
        )),
      ),
      floatingActionButton: !widget.isBelonged
          ? FloatingActionButton.extended(
              heroTag: 'fab_' + widget.id.toString(),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: StrongrColors.blue,
              onPressed: () => showDialog(context: context, builder: (context) => NewExerciseFromListDialog()),
              label: StrongrText(
                "Ajouter",
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
