import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/utils/routing_constants.dart';
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

  @override
  initState() {
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
              child: Container(
                // height: ScreenSize.height(context) / 5.5,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      exercisesListCurrentPage = value;
                    });
                  },
                  controller: exercisesListController,
                  children: <Widget>[
                    for (int i = 1; i <= 3; i++)
                      StrongrRoundedContainer(
                        content: Stack(
                          children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.only(left: 10, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: StrongrText(
                                      "Exercice perso. " + i.toString(),
                                      bold: true,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.fitness_center),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "Exercice X",
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.show_chart),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "X kg",
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.refresh),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "X série(s)",
                                            )),
                                      ],
                                    ),
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
                                  heroTag: 'exercise_fab_' + i.toString(),
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
                              id: i.toString(),
                              name: "Exercice perso. " + i.toString(),
                            ),
                          );
                        },
                      ),
                  ],
                ),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: StrongrText(
                                      "Séance perso. " + i.toString(),
                                      bold: true,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.accessibility),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "Full body",
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.fitness_center),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "X exercices",
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.show_chart),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "X kg",
                                            )),
                                      ],
                                    ),
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
                                  heroTag: 'session_fab_' + i.toString(),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: StrongrText(
                                      "Programme perso. " + i.toString(),
                                      bold: true,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.star_border),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "Objectif",
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.calendar_today),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "X séances",
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.fitness_center),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: StrongrText(
                                              "X exercices",
                                            )),
                                      ],
                                    ),
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
                                  heroTag: 'program_fab_' + i.toString(),
                                  tooltip: "Démarrer",
                                  backgroundColor: DateTime.now().weekday % 3 != 0 ? StrongrColors.blue : Colors.grey,
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  onPressed: DateTime.now().weekday % 3 != 0 ? () {} : null,

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
          ),
        ],
      ),
    );
  }
}
