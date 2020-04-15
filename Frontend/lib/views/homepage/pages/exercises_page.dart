import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/new_exercise_from_list_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisesPage extends StatefulWidget {
  final int id;

  ExercisesPage({this.id});

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 60,
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              // color: Colors.grey,
              child: TextField(
                style: TextStyle(
                    color: StrongrColors.black,
                    fontFamily: 'Futura',
                    fontSize: 18),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                controller: null,
                onChanged: (newValue) {},
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search, color: StrongrColors.blue),
                  hintText: "Rechercher un exercice...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: StrongrColors.blue, width: 1.5)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 100, right: 100),
            height: 1,
            width: 100,
            color: Colors.grey[350],
          ),
          for (int i = 1; i <= 10; i++)
            Container(
              padding: EdgeInsets.all(5),
              height: 90,
              child: StrongrRoundedContainer(
                content: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StrongrText("Exercice " + i.toString(), bold: true),
                          StrongrText("Muscle(s) ciblé(s)"),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 35,
                        height: 35,
                        child: FloatingActionButton(
                          heroTag: 'fab_' + i.toString(),
                          tooltip: "Ajouter",
                          backgroundColor: StrongrColors.blue,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  NewExerciseFromListDialog()),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EXERCISE_ROUTE,
                    arguments: ExercisesPage(id: i),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
