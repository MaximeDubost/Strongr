import 'package:flutter/material.dart';
import 'package:strongr/views/homepage/pages/app_exercises_page.dart';

class ExerciseAddView extends StatefulWidget {
  _ExerciseAddViewState createState() => _ExerciseAddViewState();
}

class _ExerciseAddViewState extends State<ExerciseAddView> {
  final List<String> popupMenuItems = ["Filtres"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text("Nouvel exercice"),
          // actions: <Widget>[
          //   PopupMenuButton<String>(
          //     tooltip: "Menu",
          //     onSelected: (value) async {
          //       switch (value) {
          //         case "Filtres":
          //           break;
          //       }
          //     },
          //     itemBuilder: (BuildContext context) {
          //       return popupMenuItems.map(
          //         (String choice) {
          //           return PopupMenuItem<String>(
          //             value: choice,
          //             child: Text(choice),
          //           );
          //         },
          //       ).toList();
          //     },
          //   ),
          // ],
        ),
        body: AppExercisesPage(
          fromExercises: true,
        ));
  }
}
