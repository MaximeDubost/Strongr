import 'dart:async';

import 'package:flutter/material.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/Status.dart';
import 'package:strongr/models/Set.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/utils/time_formater.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisePlayView extends StatefulWidget {
  final GlobalKey<ExercisePlayViewState> key;
  final List<Exercise> exercises;
  final Exercise exercise;
  final bool onlyOne;
  final void Function({
    Exercise exercise,
    Set exerciseSet,
    Status newStatus,
  }) updateStatus;
  final void Function() nextExercise;
  final Future Function(Duration restTimeDuration) startRestTime;
  final void Function() cancelTimer;
  final int Function() getDynamicRestTime;
  final void Function(String message) showMessage;

  ExercisePlayView({
    this.key,
    this.exercises,
    this.exercise,
    this.onlyOne = false,
    this.updateStatus,
    this.nextExercise,
    this.startRestTime,
    this.cancelTimer,
    this.getDynamicRestTime,
    this.showMessage,
  });

  @override
  ExercisePlayViewState createState() => ExercisePlayViewState();
}

class ExercisePlayViewState extends State<ExercisePlayView> {
  Exercise exercise;
  // int dynamicRestTime;
  // Timer _timer;
  bool isSkipped;

  @override
  initState() {
    super.initState();
    exercise = widget.exercise;
    isSkipped = false;
  }

  @override
  dispose() {
    super.dispose();
    // try {
    //   _timer.cancel();
    // } catch (e) {}
  }

  /// Arrête le timer.
  // cancelTimer() {
  //   _timer.cancel();
  // }

  /// Démarre le timer.
  // startRestTime(Duration restTimeDuration) async {
  //   setState(() => dynamicRestTime = restTimeDuration.inSeconds);
  //   _timer = Timer.periodic(
  //     Duration(seconds: 1),
  //     (timer) async {
  //       if (dynamicRestTime > 0) {
  //         setState(() => dynamicRestTime--);
  //         // debugPrint(dynamicRestTime.toString());
  //         if (dynamicRestTime == 0) {
  //           timer.cancel();
  //           setState(() => dynamicRestTime == 0);
  //         }
  //       } else {
  //         timer.cancel();
  //         setState(() => dynamicRestTime == 0);
  //       }
  //     },
  //   );
  //   // await Future.delayed(restTimeDuration, () {});
  //   await Future.delayed(Duration(seconds: restTimeDuration.inSeconds), () {});
  // }

  @override
  Widget build(BuildContext context) {
    // debugPrint("Key of the exercise " + widget.exercise.id.toString() + " : " + widget.key.toString());
    // debugPrint("WIDGET DynamicRestType : " + (widget.getDynamicRestTime()).toString());
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        buildExerciseInfo(),
        buildSetList(),
      ],
    );
  }

  /// Crée la partie description de l'exercice.
  Widget buildExerciseInfo() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: !widget.onlyOne,
                  child: StrongrText(
                    widget.exercise.name,
                    textAlign: TextAlign.start,
                    bold: true,
                  ),
                ),
                Visibility(
                  visible: widget.onlyOne ||
                      widget.exercise.appExercise.name != widget.exercise.name,
                  child: StrongrText(
                    widget.exercise.appExercise.name,
                    textAlign: TextAlign.start,
                    size: 18,
                  ),
                ),
                StrongrText(
                  widget.exercise.equipment != null
                      ? widget.exercise.equipment.name
                      : "Aucun équipement",
                  textAlign: TextAlign.start,
                  color: widget.exercise.equipment != null
                      ? StrongrColors.black
                      : Colors.grey,
                  size: 18,
                ),
              ],
            ),
          ),
          buildRightPartOfExercise(exercise),
        ],
      ),
    );
  }

  /// Crée la liste des séries de l'exercice.
  Widget buildSetList() {
    List<Widget> setList = List<Widget>();
    for (final _set in widget.exercise.sets)
      setList.add(
        Container(
          padding: EdgeInsets.all(4),
          child: StrongrRoundedContainer(
            width: ScreenSize.width(context),
            borderColor:
                _set.status == Status.inProgress || _set.status == Status.atRest
                    ? StrongrColors.blue80
                    : StrongrColors.greyD,
            borderWidth:
                _set.status == Status.inProgress || _set.status == Status.atRest
                    ? 2
                    : 1,
            onPressed: null,
            content: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 24,
                        child: StrongrText(
                          _set.place.toString(),
                          color: placeColor(_set),
                          bold: true,
                          maxLines: 1,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 32,
                                child: Icon(
                                  Icons.autorenew,
                                  color: repetitionCountColor(_set),
                                ),
                              ),
                              StrongrText(
                                _set.repetitionCount.toString(),
                                color: repetitionCountColor(_set),
                                bold: _set.status == Status.inProgress,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 32,
                                child: Icon(
                                  Icons.hourglass_empty,
                                  color: restTimeColor(_set),
                                ),
                              ),
                              StrongrText(
                                _set.status != Status.atRest
                                    ? TimeFormater.getDuration(
                                        Duration(seconds: _set.restTime),
                                      ).toString()
                                    : TimeFormater.getDuration(
                                        // Duration(seconds: dynamicRestTime),
                                        Duration(
                                            seconds:
                                                widget.getDynamicRestTime()),
                                      ).toString(),
                                color: restTimeColor(_set),
                                bold: _set.status == Status.atRest,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildRightPartOfSet(_set),
                ],
              ),
            ),
          ),
        ),
      );
    return Column(children: setList);
  }

  /// Crée la partie droite de la description de l'exercice (action "Passer" ou status courant).
  Widget buildRightPartOfExercise(Exercise exercise) {
    switch (exercise.status) {
      case Status.waiting:
        return FlatButton(
          onPressed: null,
          child: StrongrText(
            "En attente...",
            color: StrongrColors.black20,
          ),
        );
        break;
      case Status.inProgress:
      case Status.atRest:
        return Visibility(
          visible: widget.exercises.length > 1,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: StrongrText(
              "Passer", // Exercice
              color: Colors.grey,
            ),
            onPressed: () {
              // _timer.cancel();
              widget.cancelTimer();
              widget.updateStatus(
                  exercise: exercise, newStatus: Status.skipped);
              for (final _set in exercise.sets)
                widget.updateStatus(
                    exerciseSet: _set, newStatus: Status.skipped);
              if (widget.exercises.indexOf(exercise) !=
                  widget.exercises.length - 1)
                widget.nextExercise();
              else
                widget.showMessage(
                  widget.exercises.length > 1
                      ? "Séance terminée !"
                      : "Exercice terminé",
                );
              setState(() {});
            },
          ),
        );
      case Status.skipped:
        return FlatButton(
          onPressed: null,
          child: StrongrText(
            "Passé",
            color: Colors.red[200],
          ),
        );
        break;
      case Status.done:
        return FlatButton(
          onPressed: null,
          child: StrongrText(
            "Terminé",
            color: StrongrColors.blue80,
          ),
        );
        break;
      default:
        return SizedBox();
    }
  }

  /// Crée la partie droite de la série (actions "Valider" et "Passer" ou status courant).
  Widget buildRightPartOfSet(Set _set) {
    switch (_set.status) {
      case Status.waiting:
        return StrongrText(
          "En attente...",
          size: 16,
          maxLines: 1,
          color: StrongrColors.black20,
        );
        break;
      case Status.inProgress:
        return Row(
          children: <Widget>[
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: StrongrText(
                  "Valider",
                  size: 16,
                  maxLines: 1,
                  color: StrongrColors.blue,
                ),
              ),
              onTap: () async {
                widget.updateStatus(
                    exerciseSet: _set, newStatus: Status.atRest);
                setState(() {});
                // Méthode asynchrone de gestion du temps de repos
                await widget.startRestTime(Duration(seconds: _set.restTime));
                // Créer un booléen "isSkipped" qui vérifie si le temps de repos n'a pas été passé,
                // et exécuter la suite du code seulement si ce cas est vrai (!isSkipped).
                if (!isSkipped) {
                  widget.updateStatus(
                      exerciseSet: _set, newStatus: Status.done);
                  if (exercise.sets.indexOf(_set) == exercise.sets.length - 1) {
                    widget.updateStatus(
                        exercise: exercise, newStatus: Status.done);
                    if (widget.exercises.indexOf(exercise) !=
                        widget.exercises.length - 1) widget.nextExercise();
                  } else {
                    if (exercise.sets[exercise.sets.indexOf(_set) + 1].status ==
                        Status.waiting)
                      widget.updateStatus(
                        exerciseSet:
                            exercise.sets[exercise.sets.indexOf(_set) + 1],
                        newStatus: Status.inProgress,
                      );
                  }
                }
                try {
                  setState(() => isSkipped = false);
                } catch (e) {}
              },
            ),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: StrongrText(
                  "Passer", // Série
                  size: 16,
                  maxLines: 1,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                widget.updateStatus(
                    exerciseSet: _set, newStatus: Status.skipped);
                if (exercise.sets.indexOf(_set) == exercise.sets.length - 1) {
                  int skippedSetCount = 0;
                  for (final _set in exercise.sets)
                    if (_set.status == Status.skipped) skippedSetCount++;
                  if (skippedSetCount != exercise.sets.length)
                    widget.updateStatus(
                        exercise: exercise, newStatus: Status.done);
                  else
                    widget.updateStatus(
                        exercise: exercise, newStatus: Status.skipped);
                  if (widget.exercises.indexOf(exercise) !=
                      widget.exercises.length - 1)
                    widget.nextExercise();
                  else
                    widget.showMessage(
                      widget.exercises.length > 1
                          ? "Séance terminée !"
                          : "Exercice terminé",
                    );
                } else {
                  widget.updateStatus(
                    exerciseSet: exercise.sets[exercise.sets.indexOf(_set) + 1],
                    newStatus: Status.inProgress,
                  );
                }
                setState(() {});
              },
            ),
          ],
        );
        break;
      case Status.atRest:
        return InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: StrongrText(
              "Passer le repos",
              size: 16,
              maxLines: 1,
              color: Colors.grey,
            ),
          ),
          onTap: () => setState(() {
            // _timer.cancel();
            widget.cancelTimer();
            isSkipped = true;
            widget.updateStatus(exerciseSet: _set, newStatus: Status.done);
            if (exercise.sets.indexOf(_set) == exercise.sets.length - 1) {
              widget.updateStatus(exercise: exercise, newStatus: Status.done);
              if (widget.exercises.indexOf(exercise) !=
                  widget.exercises.length - 1) widget.nextExercise();
            } else {
              widget.updateStatus(
                exerciseSet: exercise.sets[exercise.sets.indexOf(_set) + 1],
                newStatus: Status.inProgress,
              );
            }
          }),
        );
        break;
      case Status.skipped:
        return StrongrText(
          "Passée",
          size: 16,
          maxLines: 1,
          color: Colors.red[200],
        );
        break;
      case Status.done:
        return StrongrText(
          "Terminée",
          size: 16,
          maxLines: 1,
          color: StrongrColors.blue80,
        );
        break;
      default:
        return SizedBox();
        break;
    }
  }

  /// Détermine la couleur de la place de la série.
  Color placeColor(Set _set) {
    switch (_set.status) {
      case Status.inProgress:
      case Status.atRest:
      case Status.done:
        return StrongrColors.black;
      default:
        return Colors.grey;
    }
  }

  /// Détermine la couleur du nombre de répétitions de la série.
  Color repetitionCountColor(Set _set) {
    switch (_set.status) {
      case Status.inProgress:
        return StrongrColors.blue;
        break;
      case Status.atRest:
      case Status.done:
        return StrongrColors.black;
        break;
      default:
        return Colors.grey;
    }
  }

  /// Détermine la couleur du temps de repos de la série.
  Color restTimeColor(Set _set) {
    switch (_set.status) {
      case Status.atRest:
        return StrongrColors.blue;
        break;
      case Status.inProgress:
      case Status.done:
        return StrongrColors.black;
        break;
      default:
        return Colors.grey;
    }
  }

  refresh() {
    setState(() {});
  }
}
