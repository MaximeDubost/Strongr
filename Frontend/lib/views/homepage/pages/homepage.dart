import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/ProgramPreview.dart';
import 'package:strongr/models/SessionPreview.dart';
import 'package:strongr/services/ExerciseService.dart';
import 'package:strongr/services/ProgramService.dart';
import 'package:strongr/services/SessionService.dart';
import 'package:strongr/utils/app_exercises_filters.dart';
import 'package:strongr/route/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strings.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercise_view.dart';
import 'package:strongr/views/exercise/exercises_loading_view.dart';
import 'package:strongr/views/program/program_view.dart';
import 'package:strongr/views/session/session_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_snackbar_content.dart';
import 'package:strongr/widgets/strongr_text.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final globalKey = GlobalKey<ScaffoldState>();
  PageController exercisesListController,
      sessionsListController,
      programsListController;
  int exercisesListCurrentPage,
      sessionsListCurrentPage,
      programsListCurrentPage;

  Future<List<ExercisePreview>> futureExercises;
  Future<List<SessionPreview>> futureSessions;
  Future<List<ProgramPreview>> futurePrograms;

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
    futureSessions = SessionService.getSessions();
    futurePrograms = ProgramService.getPrograms();
    super.initState();
  }

  /// Actualise la liste des exercices.
  void refreshExercises() async {
    setState(() {
      futureExercises = ExerciseService.getExercises();
      exercisesListCurrentPage = 0;
      exercisesListController = PageController(
        initialPage: exercisesListCurrentPage,
        keepPage: false,
        viewportFraction: 0.85,
      );
    });
  }

  /// Actualise la liste des séances.
  void refreshSessions() async {
    setState(() {
      futureSessions = SessionService.getSessions();
      sessionsListCurrentPage = 0;
      sessionsListController = PageController(
        initialPage: sessionsListCurrentPage,
        keepPage: false,
        viewportFraction: 0.85,
      );
    });
  }

  /// Actualise la liste des programmes.
  void refreshPrograms() async {
    setState(() {
      futurePrograms = ProgramService.getPrograms();
      programsListCurrentPage = 0;
      programsListController = PageController(
        initialPage: programsListCurrentPage,
        keepPage: false,
        viewportFraction: 0.85,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Container(
        // color: Colors.red,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Container(
                child: FlatButton(
                  onPressed: () async {
                    AppExercisesFilters.disableAll();
                    globalKey.currentState.hideCurrentSnackBar();
                    try {
                      await Navigator.pushNamed(
                        context,
                        EXERCISES_ROUTE,
                      ).then(
                        (exerciseChanges) {
                          if (exerciseChanges) {
                            refreshExercises();
                            refreshSessions();
                            refreshPrograms();
                          }
                        },
                      );
                    } catch (e) {
                      refreshExercises();
                      refreshSessions();
                      refreshPrograms();
                    }
                  },
                  child: Container(
                    // color: Colors.red,
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
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.length == 0) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StrongrText(
                                "Aucun exercice à afficher",
                                color: Colors.grey,
                              ),
                              FloatingActionButton.extended(
                                heroTag: "exercise_create_fab",
                                icon: Icon(Icons.add),
                                label: StrongrText(
                                  "Créer",
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  EXERCISE_ADD_ROUTE,
                                ).then(
                                  (exerciseCreated) {
                                    if (exerciseCreated) {
                                      refreshExercises();
                                      globalKey.currentState
                                          .hideCurrentSnackBar();
                                      globalKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: StrongrSnackBarContent(
                                            message:
                                                "Exercice créé avec succès",
                                          ),
                                          backgroundColor: StrongrColors.blue80,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
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
                                content: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        // color: Colors.red[100],
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: StrongrText(
                                                item.name,
                                                bold: true,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 30,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.fitness_center,
                                                        color: item.appExerciseName !=
                                                                null
                                                            ? StrongrColors
                                                                .black
                                                            : Colors.grey,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: StrongrText(
                                                            item.appExerciseName !=
                                                                    null
                                                                ? item
                                                                    .appExerciseName
                                                                : "Aucun exercice",
                                                            color:
                                                                item.appExerciseName !=
                                                                        null
                                                                    ? StrongrColors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                            ? StrongrColors
                                                                .black
                                                            : Colors.grey,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
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
                                                              ? StrongrColors
                                                                  .black
                                                              : Colors.grey,
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.blue[100],
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.show_chart,
                                                        color:
                                                            item.volume != null
                                                                ? StrongrColors
                                                                    .black
                                                                : Colors.grey,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          // color: Colors.red,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: StrongrText(
                                                            item.volume != null
                                                                ? "Volume de " +
                                                                    item.volume
                                                                        .toString()
                                                                : "Volume inconnu",
                                                            color: item
                                                                        .volume !=
                                                                    null
                                                                ? StrongrColors
                                                                    .black
                                                                : Colors.grey,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 1,
                                                          ),
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
                                    ),
                                    Container(
                                      width: 50,
                                      // color: Colors.yellow,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          // color: Colors.purple,
                                          height: 60,
                                          child: Center(
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              // color: Colors.green[500],
                                              width: 35,
                                              height: 35,
                                              child: FloatingActionButton(
                                                elevation: 0,
                                                heroTag: 'exercise_play_fab_' +
                                                    item.id.toString(),
                                                tooltip: "Démarrer",
                                                backgroundColor:
                                                    StrongrColors.blue,
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    EXERCISES_LOADING_ROUTE,
                                                    arguments:
                                                        ExercisesLoadingView(
                                                      exerciseId: item.id,
                                                      name: item.name,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  globalKey.currentState.hideCurrentSnackBar();
                                  Navigator.pushNamed(
                                    context,
                                    EXERCISE_ROUTE,
                                    arguments: ExerciseView(
                                      id: item.id,
                                      name: item.name,
                                      appExerciseName: item.appExerciseName,
                                    ),
                                  ).then(
                                    (value) {
                                      Map<String, bool> action;
                                      if (value != null)
                                        action = value;
                                      else
                                        action = {
                                          CREATE: false,
                                          UPDATE: false,
                                          DELETE: false,
                                        };
                                      if (action[CREATE] ||
                                          action[UPDATE] ||
                                          action[DELETE]) {
                                        refreshExercises();
                                        if (action[DELETE]) {
                                          refreshSessions();
                                          refreshPrograms();
                                          globalKey.currentState
                                              .hideCurrentSnackBar();
                                          globalKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: StrongrSnackBarContent(
                                                message:
                                                    "Exercice supprimé avec succès",
                                              ),
                                              backgroundColor:
                                                  StrongrColors.blue80,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                          ],
                        );
                      // return Center(child: StrongrText(snapshot.data.toString()),);
                    } else if (snapshot.hasError &&
                        snapshot.connectionState == ConnectionState.done) {
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
                    globalKey.currentState.hideCurrentSnackBar();
                    try {
                      Navigator.pushNamed(
                        context,
                        SESSIONS_ROUTE,
                      ).then(
                        (sessionChanges) {
                          if (sessionChanges) {
                            refreshSessions();
                            refreshPrograms();
                          }
                        },
                      );
                    } catch (e) {
                      refreshSessions();
                      refreshPrograms();
                    }
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
                child: FutureBuilder(
                  future: futureSessions,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StrongrText(
                                "Aucune séance à afficher",
                                color: Colors.grey,
                              ),
                              FloatingActionButton.extended(
                                heroTag: "session_create_fab",
                                icon: Icon(Icons.add),
                                label: StrongrText(
                                  "Créer",
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  SESSION_CREATE_ROUTE,
                                ).then(
                                  (sessionCreated) {
                                    if (sessionCreated) {
                                      refreshSessions();
                                      globalKey.currentState
                                          .hideCurrentSnackBar();
                                      globalKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: StrongrSnackBarContent(
                                            message: "Séance créée avec succès",
                                          ),
                                          backgroundColor: StrongrColors.blue80,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else
                        return PageView(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (value) {
                            setState(() {
                              sessionsListCurrentPage = value;
                            });
                          },
                          controller: sessionsListController,
                          children: <Widget>[
                            for (final item in snapshot.data)
                              StrongrRoundedContainer(
                                content: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: StrongrText(
                                                item.name,
                                                bold: true,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 30,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.accessibility,
                                                        color: item.sessionTypeName !=
                                                                null
                                                            ? StrongrColors
                                                                .black
                                                            : Colors.grey,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: StrongrText(
                                                            item.sessionTypeName !=
                                                                    null
                                                                ? item
                                                                    .sessionTypeName
                                                                : "Aucune type",
                                                            color:
                                                                item.sessionTypeName !=
                                                                        null
                                                                    ? StrongrColors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.fitness_center,
                                                        color: int.parse(item
                                                                        .exerciseCount) >
                                                                    0 ||
                                                                int.parse(item
                                                                        .exerciseCount) !=
                                                                    null
                                                            ? StrongrColors
                                                                .black
                                                            : Colors.grey,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: StrongrText(
                                                          int.parse(item.exerciseCount) >
                                                                      0 ||
                                                                  int.parse(item
                                                                          .exerciseCount) !=
                                                                      null
                                                              ? int.parse(item
                                                                          .exerciseCount) <=
                                                                      1
                                                                  ? item.exerciseCount +
                                                                      " exercice"
                                                                  : item.exerciseCount +
                                                                      " exercices"
                                                              : "Aucun exercice",
                                                          color: int.parse(item
                                                                          .exerciseCount) >
                                                                      0 ||
                                                                  int.parse(item
                                                                          .exerciseCount) !=
                                                                      null
                                                              ? StrongrColors
                                                                  .black
                                                              : Colors.grey,
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.blue[100],
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.show_chart,
                                                        color:
                                                            item.volume != null
                                                                ? StrongrColors
                                                                    .black
                                                                : Colors.grey,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          // color: Colors.red,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: StrongrText(
                                                            item.volume != null
                                                                ? "Volume de " +
                                                                    item.volume
                                                                        .toString()
                                                                : "Volume inconnu",
                                                            color: item
                                                                        .volume !=
                                                                    null
                                                                ? StrongrColors
                                                                    .black
                                                                : Colors.grey,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 1,
                                                          ),
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
                                    ),
                                    Container(
                                      width: 50,
                                      // color: Colors.yellow,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          // color: Colors.purple,
                                          height: 60,
                                          child: Center(
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              // color: Colors.green[500],
                                              width: 35,
                                              height: 35,
                                              child: FloatingActionButton(
                                                elevation: 0,
                                                heroTag: 'session_play_fab_' +
                                                    item.id.toString(),
                                                tooltip: "Démarrer",
                                                backgroundColor:
                                                    StrongrColors.blue,
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    EXERCISES_LOADING_ROUTE,
                                                    arguments:
                                                        ExercisesLoadingView(
                                                      sessionId: item.id,
                                                      name: item.name,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  globalKey.currentState.hideCurrentSnackBar();
                                  Navigator.pushNamed(
                                    context,
                                    SESSION_ROUTE,
                                    arguments: SessionView(
                                      id: item.id,
                                      name: item.name,
                                      sessionTypeName: item.sessionTypeName,
                                    ),
                                  ).then(
                                    (value) {
                                      Map<String, bool> action;
                                      if (value != null)
                                        action = value;
                                      else
                                        action = {
                                          CREATE: false,
                                          UPDATE: false,
                                          DELETE: false,
                                        };
                                      if (action[CREATE] ||
                                          action[UPDATE] ||
                                          action[DELETE]) {
                                        refreshSessions();
                                        if (action[DELETE]) {
                                          refreshPrograms();
                                          globalKey.currentState
                                              .hideCurrentSnackBar();
                                          globalKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: StrongrSnackBarContent(
                                                message:
                                                    "Séance supprimée avec succès",
                                              ),
                                              backgroundColor:
                                                  StrongrColors.blue80,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
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
                    globalKey.currentState.hideCurrentSnackBar();
                    try {
                      Navigator.pushNamed(
                        context,
                        PROGRAMS_ROUTE,
                      ).then(
                        (programChanges) {
                          if (programChanges) refreshPrograms();
                        },
                      );
                    } catch (e) {
                      refreshPrograms();
                    }
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
                child: FutureBuilder(
                  future: futurePrograms,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StrongrText(
                                "Aucun programme à afficher",
                                color: Colors.grey,
                              ),
                              FloatingActionButton.extended(
                                heroTag: "program_create_fab",
                                icon: Icon(Icons.add),
                                label: StrongrText(
                                  "Créer",
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  PROGRAM_CREATE_ROUTE,
                                ).then(
                                  (programCreated) {
                                    if (programCreated) {
                                      refreshPrograms();
                                      globalKey.currentState
                                          .hideCurrentSnackBar();
                                      globalKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: StrongrSnackBarContent(
                                            message:
                                                "Programme créé avec succès",
                                          ),
                                          backgroundColor: StrongrColors.blue80,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else
                        return PageView(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (value) {
                            setState(() {
                              sessionsListCurrentPage = value;
                            });
                          },
                          controller: sessionsListController,
                          children: <Widget>[
                            for (final item in snapshot.data)
                              StrongrRoundedContainer(
                                content: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: StrongrText(
                                                item.name,
                                                bold: true,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 30,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.star_border,
                                                        color: item.programGoalName !=
                                                                null
                                                            ? StrongrColors
                                                                .black
                                                            : Colors.grey,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: StrongrText(
                                                            item.programGoalName !=
                                                                    null
                                                                ? item
                                                                    .programGoalName
                                                                : "Aucun objectif",
                                                            color:
                                                                item.programGoalName !=
                                                                        null
                                                                    ? StrongrColors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.calendar_today,
                                                        color: int.parse(item
                                                                        .sessionCount) >
                                                                    0 ||
                                                                int.parse(item
                                                                        .sessionCount) !=
                                                                    null
                                                            ? StrongrColors
                                                                .black
                                                            : Colors.grey,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: StrongrText(
                                                          int.parse(item.sessionCount) >
                                                                      0 ||
                                                                  int.parse(item
                                                                          .sessionCount) !=
                                                                      null
                                                              ? int.parse(item
                                                                          .sessionCount) <=
                                                                      1
                                                                  ? item.sessionCount +
                                                                      " séance"
                                                                  : item.sessionCount +
                                                                      " séances"
                                                              : "Aucune séance",
                                                          color: int.parse(item
                                                                          .sessionCount) >
                                                                      0 ||
                                                                  int.parse(item
                                                                          .sessionCount) !=
                                                                      null
                                                              ? StrongrColors
                                                                  .black
                                                              : Colors.grey,
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.blue[100],
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.show_chart,
                                                        color:
                                                            item.volume != null
                                                                ? StrongrColors
                                                                    .black
                                                                : Colors.grey,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          // color: Colors.red,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: StrongrText(
                                                            item.volume != null
                                                                ? "Volume de " +
                                                                    item.volume
                                                                        .toString()
                                                                : "Volume inconnu",
                                                            color: item
                                                                        .volume !=
                                                                    null
                                                                ? StrongrColors
                                                                    .black
                                                                : Colors.grey,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 1,
                                                          ),
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
                                    ),
                                    Container(
                                      width: 50,
                                      // color: Colors.yellow,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          // color: Colors.purple,
                                          height: 60,
                                          child: Center(
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              // color: Colors.green[500],
                                              width: 35,
                                              height: 35,
                                              child: FloatingActionButton(
                                                elevation: 0,
                                                heroTag: 'program_play_fab_' +
                                                    item.id.toString(),
                                                tooltip: "Démarrer",
                                                backgroundColor:
                                                    StrongrColors.blue,
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  globalKey.currentState.hideCurrentSnackBar();
                                  Navigator.pushNamed(
                                    context,
                                    PROGRAM_ROUTE,
                                    arguments: ProgramView(
                                      id: item.id,
                                      name: item.name,
                                      programGoalName: item.programGoalName,
                                    ),
                                  ).then(
                                    (value) {
                                      Map<String, bool> action;
                                      if (value != null)
                                        action = value;
                                      else
                                        action = {
                                          CREATE: false,
                                          UPDATE: false,
                                          DELETE: false,
                                        };
                                      if (action[CREATE] ||
                                          action[UPDATE] ||
                                          action[DELETE]) {
                                        refreshPrograms();
                                        if (action[DELETE]) {
                                          globalKey.currentState
                                              .hideCurrentSnackBar();
                                          globalKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: StrongrSnackBarContent(
                                                message:
                                                    "Programme supprimé avec succès",
                                              ),
                                              backgroundColor:
                                                  StrongrColors.blue80,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  );
                                },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
