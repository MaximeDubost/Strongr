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
  final Exercise exercise;
  final bool onlyOne;
  final void Function({
    Exercise exercise,
    Set exerciseSet,
    Status newStatus,
  }) updateStatus;

  ExercisePlayView({
    this.exercise,
    this.onlyOne = false,
    this.updateStatus,
  });

  @override
  _ExercisePlayViewState createState() => _ExercisePlayViewState();
}

class _ExercisePlayViewState extends State<ExercisePlayView> {
  Exercise exercise;

  @override
  initState() {
    super.initState();
    exercise = widget.exercise;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        buildExerciseInfo(),
        buildSetList(),
      ],
    );
  }

  Widget buildExerciseInfo() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
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
          buildRightPartOfExercise(exercise),
        ],
      ),
    );
  }

  Widget buildSetList() {
    List<Widget> setList = List<Widget>();
    for (final _set in widget.exercise.sets)
      setList.add(
        Container(
          padding: EdgeInsets.all(4),
          child: StrongrRoundedContainer(
            width: ScreenSize.width(context),
            borderColor: _set.status == Status.inProgress
                ? StrongrColors.blue80
                : StrongrColors.greyD,
            borderWidth: _set.status == Status.inProgress ? 2 : 1,
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
                          bold: placeBold(_set),
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
                                bold: repetitionCountBold(_set),
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
                                TimeFormater.getDuration(
                                  Duration(seconds: _set.restTime),
                                ).toString(),
                                color: restTimeColor(_set),
                                bold: restTimeBold(_set),
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

  buildRightPartOfExercise(Exercise exercise) {
    switch (exercise.status) {
      case Status.waiting:
        return Padding(
          padding: EdgeInsets.all(16),
          child: StrongrText(
            "En attente...",
            color: StrongrColors.black20,
          ),
        );
        break;
      case Status.inProgress:
      case Status.atRest:
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: StrongrText(
            "Passer",
            color: Colors.grey,
          ),
          onPressed: () {
            widget.updateStatus(exercise: exercise, newStatus: Status.skipped);
            for (final _set in exercise.sets)
              widget.updateStatus(exerciseSet: _set, newStatus: Status.skipped);
            setState(() {});
          },
        );
      case Status.skipped:
        return Padding(
          padding: EdgeInsets.all(16),
          child: StrongrText(
            "Passé",
            color: Colors.red[200],
          ),
        );
        break;
      case Status.done:
        return Padding(
          padding: EdgeInsets.all(16),
          child: StrongrText(
            "Terminé",
            color: StrongrColors.blue,
          ),
        );
        break;
      default:
        return SizedBox();
    }
  }

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
                  color: StrongrColors.blue80,
                ),
              ),
              onTap: () {
                widget.updateStatus(exerciseSet: _set, newStatus: Status.done);
                if (exercise.sets.indexOf(_set) == exercise.sets.length - 1)
                  widget.updateStatus(
                      exercise: exercise, newStatus: Status.done);
                else {
                  widget.updateStatus(
                    exerciseSet: exercise.sets[exercise.sets.indexOf(_set) + 1],
                    newStatus: Status.inProgress,
                  );
                }
                setState(() {});
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
                  "Passer",
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
          onTap: () {},
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
          "Terminé",
          size: 16,
          maxLines: 1,
          color: StrongrColors.blue,
        );
        break;
      default:
        return SizedBox();
        break;
    }
  }

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

  bool placeBold(Set _set) =>
      _set.status == Status.inProgress || _set.status == Status.atRest;

  bool repetitionCountBold(Set _set) => _set.status == Status.inProgress;

  bool restTimeBold(Set _set) => _set.status == Status.atRest;
}
