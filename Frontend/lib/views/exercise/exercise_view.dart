import 'package:flutter/material.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/services/exercise_service.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/utils/time_formater.dart';
import 'package:strongr/views/app_exercise/app_exercise_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExerciseView extends StatefulWidget {
  final String id;
  final String name;
  final String appExerciseName;
  final bool fromSession;

  ExerciseView(
      {this.id, this.name, this.appExerciseName, this.fromSession = false});

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  bool isEditMode;
  Future<Exercise> futureExercise;

  @override
  void initState() {
    isEditMode = false;
    futureExercise = ExerciseService.getExercise(id: int.parse(widget.id));
    super.initState();
  }

  List<Widget> buildSetList({List setList}) {
    List<Widget> builtSetList = [];
    for (final item in setList)
      builtSetList.add(
        Container(
          margin: item == 1 ? EdgeInsets.only(top: 5) : null,
          key: ValueKey(item.id),
          padding: EdgeInsets.all(5),
          height: 110,
          child: StrongrRoundedContainer(
            width: ScreenSize.width(context),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Container(
                //   // color: Colors.yellow,
                //   width: 35,
                //   child: Center(
                //     child: StrongrText(
                //       i.toString(),
                //       bold: true,
                //     ),
                //   ),
                // ),
                Container(
                  // color: Colors.red,
                  width: 35,
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 30,
                        // color: Colors.blue,
                        child: RawMaterialButton(
                          onPressed: isEditMode ? () {} : null,
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: isEditMode
                                ? StrongrColors.black
                                : Colors.transparent,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                      Container(
                        // color: Colors.yellow,
                        width: 30,
                        child: Center(
                          child: StrongrText(
                            item.place.toString(),
                            bold: true,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        // color: Colors.blue,
                        child: RawMaterialButton(
                          onPressed: isEditMode ? () {} : null,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: isEditMode
                                ? StrongrColors.black
                                : Colors.transparent,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Icon(
                                Icons.autorenew,
                                color: item.repetitionCount != null ||
                                        item.repetitionCount != 0
                                    ? StrongrColors.black
                                    : Colors.grey,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // color: Colors.blue,
                                child: StrongrText(
                                  item.repetitionCount != null ||
                                          item.repetitionCount != 0
                                      ? "Répétitions : " +
                                          item.repetitionCount.toString()
                                      : "Aucune répétition",
                                  color: isEditMode ||
                                          item.repetitionCount == null ||
                                          item.repetitionCount == 0
                                      ? Colors.grey
                                      : StrongrColors.black,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Icon(
                                Icons.hourglass_empty,
                                color:
                                    item.restTime != null || item.restTime != 0
                                        ? StrongrColors.black
                                        : Colors.grey,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // width: 185,
                                child: StrongrText(
                                  item.restTime != null || item.restTime != 0
                                      ? "Repos : " +
                                          TimeFormater.getDuration(
                                            Duration(seconds: item.restTime),
                                          ).toString()
                                      : "Aucun temps de repos",
                                  color: isEditMode ||
                                          item.restTime == null ||
                                          item.restTime == 0
                                      ? Colors.grey
                                      : StrongrColors.black,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Icon(
                                Icons.show_chart,
                                color: Colors.grey,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // width: 185,
                                child: StrongrText(
                                  "Tonnage non calculé",
                                  color: Colors.grey,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isEditMode,
                  child: Container(
                    // color: Colors.green,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 35,
                          child: RawMaterialButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.close,
                              color: Colors.red[800],
                            ),
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onPressed: !isEditMode ? () {} : null,
          ),
        ),
      );
    return builtSetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        leading: isEditMode
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () => setState(() => isEditMode = false),
              )
            : BackButton(),
        actions: <Widget>[
          isEditMode
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => setState(() => isEditMode = true),
                ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: isEditMode
                  ? null
                  : () {
                      Navigator.pushNamed(
                        context,
                        APP_EXERCISE_ROUTE,
                        arguments: AppExerciseView(
                          id: 1,
                          name: "Crunch",
                          isBelonged: true,
                        ),
                      );
                    },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: ScreenSize.width(context),
                    padding: EdgeInsets.all(20),
                    child: StrongrText(
                      widget.appExerciseName,
                      bold: true,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 15, right: 15),
                    alignment: Alignment.centerRight,
                    child: Opacity(
                      opacity: isEditMode ? 0 : 1,
                      child: Container(
                        child: Icon(Icons.info_outline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenSize.width(context),
              height: 1,
              color: Colors.grey[350],
            ),
            Container(
              // color: Colors.red,
              height: ScreenSize.height(context) / 1.6,
              child: FutureBuilder(
                future: futureExercise,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: buildSetList(setList: snapshot.data.sets),
                    );
                    // return Center(
                    //   child: Text(snapshot.data.toString()),
                    // );
                  }
                  if (snapshot.hasError)
                    return Text(snapshot.error, textAlign: TextAlign.center);
                  else
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
            Container(
              width: ScreenSize.width(context),
              height: 1,
              color: Colors.grey[350],
            ),
            FutureBuilder(
              future: futureExercise,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Visibility(
                    visible: !isEditMode,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: ScreenSize.width(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StrongrText(
                            "Créé le " +
                                DateFormater.format(
                                    snapshot.data.creationDate.toString()) +
                                " à " +
                                DateFormater.format(
                                  snapshot.data.creationDate.toString(),
                                  timeOnly: true,
                                ),
                            color: Colors.grey,
                            size: 16,
                          ),
                          StrongrText(snapshot.data.creationDate != snapshot.data.lastUpdate ?
                            "Mis à jour le " +
                                DateFormater.format(
                                    snapshot.data.lastUpdate.toString()) +
                                " à " +
                                DateFormater.format(
                                  snapshot.data.lastUpdate.toString(),
                                  timeOnly: true,
                                ) : "",
                            color: Colors.grey,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (snapshot.hasError)
                  return Text(snapshot.error, textAlign: TextAlign.center);
                else
                  return Container();
              },
            ),
            Visibility(
              visible: isEditMode,
              child: Container(
                padding: EdgeInsets.all(10),
                width: ScreenSize.width(context),
                child: Center(
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: StrongrColors.blue,
                    onPressed: () {},
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: !widget.fromSession
            ? 'exercise_play_fab_' + widget.id.toString()
            : 'fs_exercise_play_fab_' + widget.id.toString(),
        backgroundColor: isEditMode ? Colors.red[800] : StrongrColors.blue,
        icon: Icon(
          isEditMode ? Icons.delete_outline : Icons.play_arrow,
          color: Colors.white,
        ),
        onPressed: isEditMode ? () {} : () {},
        label: StrongrText(
          isEditMode ? "Supprimer" : "Démarrer",
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
