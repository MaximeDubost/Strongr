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
  int currentPage;
  PageController controller;
  PageView pageView;
  double progress;

  @override
  void initState() {
    exercises = widget.exercises;
    initStatus(exercises);
    progress = 0;
    currentPage = 0;
    controller = PageController(initialPage: currentPage);
    pageView = PageView(
      physics: BouncingScrollPhysics(),
      controller: controller,
      children: [
        for (final item in exercises)
          ExercisePlayView(
            exercises: exercises,
            exercise: item,
            onlyOne: exercises.length == 1,
            updateStatus: updateStatus,
            nextExercise: nextExercise,
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
    if (exercise != null) setState(() => exercise.status = newStatus);
    if (exerciseSet != null) setState(() => exerciseSet.status = newStatus);
  }

  nextExercise() {
    for (final exercise in exercises) {
      if (exercise.status == Status.waiting) {
        setState(() {
          currentPage = exercises.indexOf(exercise);
          exercise.status = Status.inProgress;
          exercise.sets[0].status = Status.inProgress;
        });
        controller.animateToPage(currentPage,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
        break;
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

  double calculateProgress() {
    int totalSetCount = 0;
    int doneOrSkippedSetCount = 0;
    for (final exercise in exercises)
      for (final _set in exercise.sets) {
        totalSetCount++;
        if (_set.status == Status.done || _set.status == Status.skipped)
          doneOrSkippedSetCount++;
      }
    return double.parse(
        (doneOrSkippedSetCount / totalSetCount).toStringAsPrecision(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: pageView,
      bottomNavigationBar: exercises.length > 1
          ? buildBottomNavigationBar(itemCount: exercises.length)
          : null,
    );
  }

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
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: StrongrColors.black,
                ),
                onPressed: () {
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

  Widget buildBottomNavigationBar({@required int itemCount}) {
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
        for (int i = 1; i <= itemCount; i++)
          BottomNavigationBarItem(
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: i == 1
                    ? i == currentPage + 1
                        ? StrongrColors.blue
                        : StrongrColors.blue80
                    : i == currentPage + 1
                        ? StrongrColors.black80
                        : Colors.grey,
                border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: StrongrText(
                  i.toString(),
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(""),
          ),
      ],
    );
  }
}
