import 'dart:async';

import 'package:flutter/material.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/Status.dart';
import 'package:strongr/models/Set.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

import 'exercise_play_view.dart';

class ExercisesPlayView extends StatefulWidget {
  final String name;
  final List<Exercise> exercises;

  ExercisesPlayView({this.name, this.exercises});

  @override
  _ExercisesPlayViewState createState() => _ExercisesPlayViewState();
}

class _ExercisesPlayViewState extends State<ExercisesPlayView> {
  List<Exercise> exercises;
  List<GlobalKey<ExercisePlayViewState>> exerciseKeys;
  int currentPage;
  PageController controller;
  PageView pageView;
  Timer _parentTimer;
  int dynamicRestTime;

  @override
  void initState() {
    exercises = widget.exercises;
    initStatus(exercises);
    currentPage = 0;
    controller = PageController(initialPage: currentPage);
    exerciseKeys = List<GlobalKey<ExercisePlayViewState>>();
    for (final exercise in exercises)
      exerciseKeys.add(
          GlobalKey<ExercisePlayViewState>(debugLabel: exercise.id.toString()));

    pageView = PageView(
      physics: BouncingScrollPhysics(),
      controller: controller,
      children: [
        for (final exercise in exercises)
          ExercisePlayView(
            key: exerciseKeys[exercises.indexOf(exercise)],
            exercises: exercises,
            exercise: exercise,
            onlyOne: exercises.length == 1,
            updateStatus: updateStatus,
            nextExercise: nextExercise,
            startRestTime: startRestTime,
            cancelTimer: cancelTimer,
          ),
      ],
      onPageChanged: (newPage) {
        setState(() {
          currentPage = newPage;
        });
      },
    );
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    try {
      _parentTimer.cancel();
      cancelTimer();
    } catch (e) {}
  }

  /// Initialise le premier exercice et sa première série à [Status.inProgress]
  /// et tous les autres exercices et autres séries à [Status.waiting].
  initStatus(List<Exercise> exercises) {
    for (final exercise in exercises) {
      exercises.indexOf(exercise) == 0
          ? exercise.status = Status.inProgress
          : exercise.status = Status.waiting;
      for (final _set in exercise.sets)
        exercises.indexOf(exercise) == 0 && exercise.sets.indexOf(_set) == 0
            ? _set.status = Status.inProgress
            : _set.status = Status.waiting;
    }
  }

  /// Met à jour le status d'un [exercise] ou d'un [exerciseSet] par [newStatus].
  updateStatus({
    Exercise exercise,
    Set exerciseSet,
    Status newStatus,
  }) {
    try {
      if (exercise != null) setState(() => exercise.status = newStatus);
      if (exerciseSet != null) setState(() => exerciseSet.status = newStatus);
    } catch (e) {}
  }

  /// Passe à l'exercice suivant s'il existe.
  nextExercise() {
    for (final exercise in exercises) {
      if (exercise.status == Status.waiting) {
        try {
          setState(() {
            currentPage = exercises.indexOf(exercise);
            exercise.status = Status.inProgress;
            exercise.sets[0].status = Status.inProgress;
          });
          controller.animateToPage(currentPage,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
          break;
        } catch (e) {}
      }
    }
  }

  /// Réinitialise les status de tous les exercices et de toutes leurs séries à [Status.none].
  disposeStatus() {
    for (final exercise in exercises) {
      exercise.status = Status.none;
      for (final _set in exercise.sets) _set.status = Status.none;
    }
  }

  /// Calcule la progression de l'exercice ou de la séance.
  double calculateProgress() {
    int totalSetCount = 0;
    int doneOrSkippedSetCount = 0;
    for (final exercise in exercises)
      for (final _set in exercise.sets) {
        totalSetCount++;
        if (_set.status == Status.atRest ||
            _set.status == Status.done ||
            _set.status == Status.skipped) doneOrSkippedSetCount++;
      }
    return double.parse(
        (doneOrSkippedSetCount / totalSetCount).toStringAsPrecision(2));
  }

  /// Arrête le timer.
  cancelTimer() {
    try {
      _parentTimer.cancel();
      // for (final key in exerciseKeys) {
      //   key.currentState.cancelTimer();
      //   break;
      // }
    } catch (e) {}
  }

  /// Démarre le timer.
  Future startRestTime(Duration restTimeDuration) async {
    setState(() => dynamicRestTime = restTimeDuration.inSeconds);
    _parentTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        if (dynamicRestTime > 0) {
          setState(() => dynamicRestTime--);
          // debugPrint(dynamicRestTime.toString());
          if (dynamicRestTime == 0) {
            timer.cancel();
            setState(() => dynamicRestTime == 0);
          }
        } else {
          timer.cancel();
          setState(() => dynamicRestTime == 0);
        }
      },
    );
    // await Future.delayed(restTimeDuration, () {});
    await Future.delayed(Duration(seconds: restTimeDuration.inSeconds), () {});
  }

  int getDynamicRestTime() {
    return dynamicRestTime;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _parentTimer.cancel();
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: pageView,
        bottomNavigationBar: exercises.length > 1
            ? buildBottomNavigationBar(exercises: exercises)
            : null,
      ),
    );
  }

  /// Crée la barre supérieure.
  Widget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(85),
      child: SafeArea(
        child: Container(
          // color: Colors.blue[200],
          child: AppBar(
            title: StrongrText(widget.name, bold: true),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: calculateProgress() == 1
                ? BackButton(
                    color: StrongrColors.black,
                    onPressed: () {
                      cancelTimer();
                      disposeStatus();
                      Navigator.pop(context);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.close,
                      color: StrongrColors.black,
                    ),
                    onPressed: () {
                      cancelTimer();
                      disposeStatus();
                      Navigator.pop(context);
                    }),
            bottom: PreferredSize(
              preferredSize: null,
              child: Container(
                // color: Colors.red[200],
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //   // color: Colors.red,
                        //   height: 25,
                        //   width: 50,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              height: 25,
                              width: ScreenSize.width(context) / 1.5,
                              child: LinearProgressIndicator(
                                value: calculateProgress(),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  StrongrColors.blue,
                                ),
                                backgroundColor: StrongrColors.blue20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: StrongrText(
                              (calculateProgress() * 100).toStringAsFixed(1) +
                                  " %"),
                        ),
                      ],
                    ),
                    Divider(
                      height: 0.5,
                      thickness: 0.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Crée la barre de navigation inférieure.
  Widget buildBottomNavigationBar({@required List<Exercise> exercises}) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentPage,
      onTap: (index) {
        setState(() {
          currentPage = index;
        });
        controller.animateToPage(currentPage,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
      items: [
        for (final exercise in exercises)
          BottomNavigationBarItem(
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: bnbItemColor(
                  exercise: exercise,
                  isCurrentPage: currentPage == exercises.indexOf(exercise),
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Center(
                child: StrongrText(
                  (exercises.indexOf(exercise) + 1).toString(),
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(""),
          ),
      ],
    );
  }

  /// Crée les élément de la barre de navigation inférieure.
  Color bnbItemColor({Exercise exercise, bool isCurrentPage}) {
    switch (exercise.status) {
      case Status.skipped:
        return isCurrentPage
            ? StrongrColors.red
            : StrongrColors.red.withOpacity(0.7);
        break;
      case Status.done:
        return isCurrentPage
            ? StrongrColors.blue
            : StrongrColors.blue.withOpacity(0.7);
        break;
      default:
        return isCurrentPage ? StrongrColors.black : Colors.grey;
    }
  }
}
