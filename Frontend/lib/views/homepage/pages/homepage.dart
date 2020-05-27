import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/services/exercise_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercise_view.dart';
import 'package:strongr/views/program/program_view.dart';
import 'package:strongr/views/session/session_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> exercisesList;
  List<Widget> sessionsList;
  List<Widget> programsList;
  PageController exercisesListController,
      sessionsListController,
      programsListController;
  int exercisesListCurrentPage,
      sessionsListCurrentPage,
      programsListCurrentPage;

  Future<List<ExercisePreview>> futureExercises;

  @override
  void initState() {
    exercisesListCurrentPage =
        sessionsListCurrentPage = programsListCurrentPage = 0;
    exercisesListController = PageController(
      initialPage: exercisesListCurrentPage,
      keepPage: false,
      viewportFraction: 0.85,
    );
    sessionsListController = PageController(
      initialPage: sessionsListCurrentPage,
      keepPage: false,
      viewportFraction: 0.85,
    );
    programsListController = PageController(
      initialPage: programsListCurrentPage,
      keepPage: false,
      viewportFraction: 0.85,
    );

    futureExercises = ExerciseService.getExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, EXERCISES_ROUTE);
                },
                child: Container(
                  // height: ScreenSize.height(context) / 12,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StrongrText("Vos exercices", size: 25),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 11,
            child: Container(
              // color: Colors.red,
              // height: ScreenSize.height(context) / 5.5,
              child: FutureBuilder(
                future: futureExercises,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Center(
                        child: StrongrText(
                          "Impossible d'afficher vos exercices",
                          color: Colors.grey,
                        ),
                      );
                    } else if (snapshot.data.length == 0) {
                      return Center(
                        child: StrongrText(
                          "Aucun exercice à afficher",
                          color: Colors.grey,
                        ),
                      );
                    } else
                      return PageView(
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          setState(() {
                            exercisesListCurrentPage = value;
                          });
                        },
                        controller: exercisesListController,
                        children: <Widget>[
                          for (final item in snapshot.data)
                            StrongrRoundedContainer(
                              content: Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: StrongrText(
                                            item.name,
                                            bold: true,
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              height: 30,
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.fitness_center,
                                                    color:
                                                        item.appExerciseName !=
                                                                null
                                                            ? StrongrColors
                                                                .black
                                                            : Colors.grey,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: StrongrText(
                                                      item.appExerciseName !=
                                                              null
                                                          ? item.appExerciseName
                                                          : "Aucun exercice",
                                                      color:
                                                          item.appExerciseName !=
                                                                  null
                                                              ? StrongrColors
                                                                  .black
                                                              : Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.refresh,
                                                    color: int.parse(item
                                                                    .setCount) >
                                                                0 ||
                                                            int.parse(item
                                                                    .setCount) !=
                                                                null
                                                        ? StrongrColors.black
                                                        : Colors.grey,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: StrongrText(
                                                      int.parse(item.setCount) >
                                                                  0 ||
                                                              int.parse(item
                                                                      .setCount) !=
                                                                  null
                                                          ? int.parse(item
                                                                      .setCount) <=
                                                                  1
                                                              ? item.setCount +
                                                                  " série"
                                                              : item.setCount +
                                                                  " séries"
                                                          : "Aucune série",
                                                      color: int.parse(item
                                                                      .setCount) >
                                                                  0 ||
                                                              int.parse(item
                                                                      .setCount) !=
                                                                  null
                                                          ? StrongrColors.black
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.show_chart,
                                                    color: item.tonnage != null
                                                        ? StrongrColors.black
                                                        : Colors.grey,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: StrongrText(
                                                      item.tonnage != null
                                                          ? "Tonnage de " +
                                                              item.tonnage
                                                                  .toString() +
                                                              "kg"
                                                          : "Tonnage non calculé",
                                                      color: item.tonnage !=
                                                              null
                                                          ? StrongrColors.black
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: 10, right: 10),
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        heroTag: 'exercise_play_fab_' +
                                            item.id.toString(),
                                        tooltip: "Démarrer",
                                        backgroundColor: StrongrColors.blue,
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  EXERCISE_ROUTE,
                                  arguments: ExerciseView(
                                    id: item.id.toString(),
                                    name: item.name,
                                    appExerciseName: item.appExerciseName,
                                  ),
                                );
                              },
                            ),
                        ],
                      );

                    // return Center(child: StrongrText(snapshot.data.toString()),);
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
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, SESSIONS_ROUTE);
                },
                child: Container(
                  // height: ScreenSize.height(context) / 12,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StrongrText("Vos séances", size: 25),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 11,
            child: Container(
              // height: ScreenSize.height(context) / 5.5,
              child: PageView(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    sessionsListCurrentPage = value;
                  });
                },
                controller: sessionsListController,
                children: <Widget>[
                  for (int i = 1; i <= 3; i++)
                    StrongrRoundedContainer(
                      content: Stack(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: StrongrText(
                                    "Séance perso. " + i.toString(),
                                    bold: true,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.accessibility),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "Full body",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.fitness_center),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "5 exercices",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.show_chart,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "Tonnage non calculé",
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, right: 10),
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 35,
                              height: 35,
                              child: FloatingActionButton(
                                elevation: 0,
                                heroTag: 'session_play_fab_' + i.toString(),
                                tooltip: "Démarrer",
                                backgroundColor: StrongrColors.blue,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SESSION_ROUTE,
                          arguments: SessionView(
                            id: i.toString(),
                            name: "Séance perso. " + i.toString(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, PROGRAMS_ROUTE);
                },
                child: Container(
                  // height: ScreenSize.height(context) / 12,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StrongrText("Vos programmes", size: 25),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 11,
            child: Container(
              // height: ScreenSize.height(context) / 5.5,
              child: PageView(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    programsListCurrentPage = value;
                  });
                },
                controller: programsListController,
                children: <Widget>[
                  for (int i = 1; i <= 3; i++)
                    StrongrRoundedContainer(
                      content: Stack(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: StrongrText(
                                    "Programme perso. " + i.toString(),
                                    bold: true,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.star_border),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "Prise de masse",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.calendar_today),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "5 séances",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.show_chart,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "Tonnage non calculé",
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, right: 10),
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 35,
                              height: 35,
                              child: FloatingActionButton(
                                elevation: 0,
                                heroTag: 'program_play_fab_' + i.toString(),
                                tooltip: "Démarrer",
                                backgroundColor: DateTime.now().weekday % 3 != 0
                                    ? StrongrColors.blue
                                    : Colors.grey,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: DateTime.now().weekday % 3 != 0
                                    ? () {}
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PROGRAM_ROUTE,
                          arguments: ProgramView(
                            id: i.toString(),
                            name: "Programme perso. " + i.toString(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
