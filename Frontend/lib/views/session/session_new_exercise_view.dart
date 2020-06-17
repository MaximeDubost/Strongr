import 'package:flutter/material.dart';
import 'package:strongr/views/exercise/exercises_view.dart';

class SessionNewExerciseView extends StatefulWidget {
  _SessionNewExerciseViewState createState() => _SessionNewExerciseViewState();
}

class _SessionNewExerciseViewState extends State<SessionNewExerciseView> {
  final List<String> popupMenuItems = ["Filtres"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(),
        title: Text("Ajouter un exercice"),
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
      body: ExercisesView(fromSessionCreation: true)
    );
  }
}
