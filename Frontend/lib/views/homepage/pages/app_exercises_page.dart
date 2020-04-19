import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/models/app_exercise.dart';
import 'package:strongr/services/app_exercise_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/new_exercise_from_list_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisesPage extends StatefulWidget {
  final int id;
  final String name;

  ExercisesPage({this.id, this.name});

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  Future<List<AppExercise>> futureAppExercisesList;

  @override
  void initState() {
    futureAppExercisesList = AppExerciseService.getAppExercises();
    super.initState();
  }

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
            width: ScreenSize.width(context),
            // color: Colors.blue,
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
                        BorderSide(color: StrongrColors.blue, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 100, right: 100),
            height: 1,
            width: ScreenSize.width(context) / 2,
            color: Colors.grey[350],
          ),

          FutureBuilder(
            future: futureAppExercisesList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    snapshot.data.length != 0
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.center,
                            height: ScreenSize.height(context) / 1.75,
                            child: StrongrText(
                              "Aucun élément à afficher",
                              color: Colors.grey,
                            ),
                          ),
                    for (final item in snapshot.data)
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 90,
                        child: StrongrRoundedContainer(
                          width: ScreenSize.width(context),
                          content: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    StrongrText(
                                      snapshot.data[snapshot.data.indexOf(item)]
                                          .name,
                                      textAlign: TextAlign.start,
                                      bold: true,
                                    ),
                                    StrongrText(
                                      snapshot.data[snapshot.data.indexOf(item)]
                                          .muscleList[0].name,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  child: FloatingActionButton(
                                    elevation: 0,
                                    heroTag: 'fab_' +
                                        snapshot.data.indexOf(item).toString(),
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
                              arguments: ExercisesPage(
                                id: snapshot
                                    .data[snapshot.data.indexOf(item)].id,
                                name: snapshot
                                    .data[snapshot.data.indexOf(item)].name,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error, textAlign: TextAlign.center);
              } else
                return Container(
                  alignment: Alignment.center,
                  height: ScreenSize.height(context) / 1.75,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(StrongrColors.blue),
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
