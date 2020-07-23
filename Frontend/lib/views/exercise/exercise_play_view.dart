import 'package:flutter/material.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/Status.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/utils/time_formater.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisePlayView extends StatefulWidget {
  final Exercise exercise;

  ExercisePlayView({this.exercise});

  @override
  _ExercisePlayViewState createState() => _ExercisePlayViewState();
}

class _ExercisePlayViewState extends State<ExercisePlayView> {
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

  buildExerciseInfo() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StrongrText(
                widget.exercise.name,
                textAlign: TextAlign.start,
                bold: true,
              ),
              widget.exercise.appExercise.name != widget.exercise.name
                  ? StrongrText(
                      widget.exercise.appExercise.name,
                      textAlign: TextAlign.start,
                      size: 18,
                    )
                  : SizedBox(),
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
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: StrongrText(
              "Passer",
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  buildSetList() {
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
                          bold: true,
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
                                  color: StrongrColors.black,
                                ),
                              ),
                              StrongrText(
                                _set.repetitionCount.toString(),
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
                                  color: StrongrColors.black,
                                ),
                              ),
                              StrongrText(
                                TimeFormater.getDuration(
                                  Duration(seconds: _set.restTime),
                                ).toString(),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
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
                        onTap: () {},
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
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    return Column(children: setList);
  }
}
