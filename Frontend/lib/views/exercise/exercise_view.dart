import 'package:flutter/material.dart';
import 'package:strongr/models/Equipment.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/Set.dart';
import 'package:strongr/services/ExerciseService.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/route/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strings.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/utils/time_formater.dart';
import 'package:strongr/views/app_exercise/app_exercise_view.dart';
import 'package:strongr/views/equipment/equipments_view.dart';
import 'package:strongr/widgets/dialogs/delete_dialog.dart';
import 'package:strongr/widgets/dialogs/new_set_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_snackbar_content.dart';
import 'package:strongr/widgets/strongr_text.dart';

import 'exercises_loading_view.dart';

class ExerciseView extends StatefulWidget {
  final int id;
  final String name;
  final String appExerciseName;
  final bool fromSession;
  final bool fromSessionCreation;

  ExerciseView({
    this.id,
    this.name,
    this.appExerciseName,
    this.fromSession = false,
    this.fromSessionCreation = false,
  });

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  final globalKey = GlobalKey<ScaffoldState>();
  bool isEditMode,
      validateButtonEnabled,
      editButtonsEnabled,
      isEdited,
      exerciseUpdated,
      initEquipmentId;
  Future<Exercise> futureExercise;
  List<Set> setsOfExercise;
  TextEditingController exerciseNameController;
  int equipmentId;
  String exerciseName, equipmentName;
  Color textFieldBackgroundColor;

  @override
  void initState() {
    isEditMode = validateButtonEnabled =
        isEdited = exerciseUpdated = initEquipmentId = false;
    editButtonsEnabled = true;
    futureExercise = ExerciseService.getExercise(id: widget.id);
    setsOfExercise = List<Set>();
    exerciseName = widget.name;
    exerciseNameController = TextEditingController(text: exerciseName);
    textFieldBackgroundColor = StrongrColors.blue80;
    super.initState();
  }

  @override
  void dispose() {
    exerciseNameController.dispose();
    super.dispose();
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        height: 400,
        title: "Supprimer cet exercice ?",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StrongrText(
              "Cette action est irréversible.",
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                ),
                Flexible(
                  child: StrongrText(
                    "Les séance contenant uniquement cet exercice seront supprimées.",
                    color: Colors.orange,
                    textAlign: TextAlign.start,
                    maxLines: 6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                ),
                Flexible(
                  child: StrongrText(
                    "Les programmes n'ayant qu'une seule séance contenant uniquement cet exercices seront supprimés.",
                    color: Colors.orange,
                    textAlign: TextAlign.start,
                    maxLines: 6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
        onPressed: () => Navigator.pop(context, true),
      ),
    ).then(
      (delete) async {
        if (delete) {
          setState(() => editButtonsEnabled = false);
          int statusCode = await ExerciseService.deleteExercise(id: widget.id);
          if (statusCode == 200)
            Navigator.pop(context, {
              CREATE: false,
              UPDATE: false,
              DELETE: true,
            });
          else {
            globalKey.currentState.hideCurrentSnackBar();
            globalKey.currentState.showSnackBar(
              SnackBar(
                content: StrongrSnackBarContent(
                  icon: Icons.close,
                  message: "Échec lors de la suppression de l'exercice",
                ),
                backgroundColor: Colors.red.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            );
            setState(() => editButtonsEnabled = true);
          }
        }
      },
    );
  }

  void sendToServer() async {
    setState(() {
      validateButtonEnabled = false;
      editButtonsEnabled = false;
    });
    int statusCode = await ExerciseService.putExercise(
      id: widget.id,
      equipmentId: equipmentId,
      name: exerciseName,
      sets: setsOfExercise,
    );
    if (statusCode == 200) {
      globalKey.currentState.hideCurrentSnackBar();
      globalKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: GestureDetector(
            onVerticalDragStart: (_) => null,
            child: InkWell(
              onTap: () => globalKey.currentState.hideCurrentSnackBar(),
              child: StrongrSnackBarContent(
                message: "Exercice mis à jour avec succès",
              ),
            ),
          ),
          backgroundColor: StrongrColors.blue80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      );
      setState(() {
        exerciseUpdated = true;
        isEditMode = false;
        isEdited = false;
        textFieldBackgroundColor = StrongrColors.blue80;
      });
    } else {
      globalKey.currentState.hideCurrentSnackBar();
      globalKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: StrongrSnackBarContent(
            icon: Icons.close,
            message: "Échec lors de la mise à jour de l'exercice",
          ),
          backgroundColor: Colors.red.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      );
    }
    setState(() {
      validateButtonEnabled = true;
      editButtonsEnabled = true;
    });
  }

  void toggleValidateButton(List<dynamic> list) {
    if (list.length < 1)
      setState(() => validateButtonEnabled = false);
    else
      setState(() => validateButtonEnabled = true);
  }

  void addSet(Object returnedSet) {
    if (returnedSet != null) {
      setState(() {
        isEdited = true;
        setsOfExercise.add(returnedSet);
      });
      setsOfExercise[setsOfExercise.length - 1].place = setsOfExercise.length;
    }
    toggleValidateButton(setsOfExercise);
  }

  void deleteSet(int index) {
    setState(() {
      isEdited = true;
      setsOfExercise.removeAt(index);
      for (final item in setsOfExercise)
        item.place = setsOfExercise.indexOf(item) + 1;
    });
    toggleValidateButton(setsOfExercise);
  }

  void changePlaceOfSet(int index, AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
      case AxisDirection.left:
        if (index > 0) {
          Set transition = setsOfExercise[index - 1];
          setState(() {
            isEdited = true;
            setsOfExercise[index - 1] = setsOfExercise[index];
            setsOfExercise[index] = transition;
            for (final item in setsOfExercise)
              item.place = setsOfExercise.indexOf(item) + 1;
          });
        }
        break;
      case AxisDirection.right:
      case AxisDirection.down:
        if (index < setsOfExercise.indexOf(setsOfExercise.last)) {
          Set transition = setsOfExercise[index + 1];
          setState(() {
            isEdited = true;
            setsOfExercise[index + 1] = setsOfExercise[index];
            setsOfExercise[index] = transition;
            for (final item in setsOfExercise)
              item.place = setsOfExercise.indexOf(item) + 1;
          });
        }
        break;
    }
    toggleValidateButton(setsOfExercise);
  }

  List<Widget> buildSetList({List<Set> setList}) {
    List<Widget> builtSetList = [];
    for (final item in setList)
      builtSetList.add(
        Container(
          margin: setList.indexOf(item) == 0 ? EdgeInsets.only(top: 5) : null,
          key: ValueKey(item.place),
          padding: EdgeInsets.all(5),
          height: 90,
          child: StrongrRoundedContainer(
            width: ScreenSize.width(context),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  // color: Colors.green[100],
                  width: 35,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 20,
                        // color: Colors.blue,
                        child: isEditMode
                            ? RawMaterialButton(
                                onPressed: setList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? null
                                    : () {
                                        changePlaceOfSet(
                                          setList.indexOf(item),
                                          AxisDirection.up,
                                        );
                                      },
                                hoverColor: setList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyE,
                                splashColor: setList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyD,
                                enableFeedback: setList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? false
                                    : true,
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: setList.indexOf(item) == 0 ||
                                          !editButtonsEnabled
                                      ? Colors.grey
                                      : StrongrColors.black,
                                ),
                                shape: CircleBorder(),
                              )
                            : null,
                      ),
                      Container(
                        // color: Colors.yellow,
                        width: 30,
                        child: Center(
                          child: StrongrText(
                            item.place != null ? item.place.toString() : "-",
                            color: item.place != null
                                ? StrongrColors.black
                                : Colors.grey,
                            bold: true,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        // color: Colors.blue,
                        child: isEditMode
                            ? RawMaterialButton(
                                onPressed: setList.indexOf(item) ==
                                            setList.indexOf(setList.last) ||
                                        !editButtonsEnabled
                                    ? null
                                    : () {
                                        changePlaceOfSet(
                                          setList.indexOf(item),
                                          AxisDirection.down,
                                        );
                                      },
                                hoverColor: setList.indexOf(item) ==
                                            setList.indexOf(setList.last) ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyE,
                                splashColor: setList.indexOf(item) ==
                                            setList.indexOf(setList.last) ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyD,
                                enableFeedback: setList.indexOf(item) ==
                                            setList.indexOf(setList.last) ||
                                        !editButtonsEnabled
                                    ? false
                                    : true,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: setList.indexOf(item) ==
                                              setList.indexOf(setList.last) ||
                                          !editButtonsEnabled
                                      ? Colors.grey
                                      : StrongrColors.black,
                                ),
                                shape: CircleBorder(),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    // color: Colors.red[100],
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
                                color: item.repetitionCount == null ||
                                        item.repetitionCount == 0
                                    ? Colors.grey
                                    : StrongrColors.black,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // color: Colors.blue,
                                child: StrongrText(
                                  item.repetitionCount != null &&
                                          item.repetitionCount != 0
                                      ? "Répétitions : " +
                                          item.repetitionCount.toString()
                                      : "Aucune répétition",
                                  color: item.repetitionCount == null ||
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
                                    item.restTime == null || item.restTime == 0
                                        ? Colors.grey
                                        : StrongrColors.black,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // width: 185,
                                child: StrongrText(
                                  item.restTime != null && item.restTime != 0
                                      ? "Repos : " +
                                          TimeFormater.getDuration(
                                            Duration(seconds: item.restTime),
                                          ).toString()
                                      : "Aucun temps de repos",
                                  color: item.restTime == null ||
                                          item.restTime == 0
                                      ? Colors.grey
                                      : StrongrColors.black,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     Container(
                        //       padding: EdgeInsets.only(left: 5, right: 5),
                        //       child: Icon(
                        //         Icons.show_chart,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //     Flexible(
                        //       child: Container(
                        //         // width: 185,
                        //         child: StrongrText(
                        //           "Volume inconnu",
                        //           color: Colors.grey,
                        //           textAlign: TextAlign.start,
                        //           maxLines: 1,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // color: Colors.blue[100],
                  width: 35,
                  height: 35,
                  child: isEditMode
                      ? RawMaterialButton(
                          child: Icon(
                            Icons.close,
                            color: editButtonsEnabled
                                ? Colors.red[800]
                                : Colors.grey,
                          ),
                          shape: CircleBorder(),
                          onPressed: editButtonsEnabled
                              ? () {
                                  deleteSet(setList.indexOf(item));
                                }
                              : null,
                        )
                      : null,
                ),
              ],
            ),
            onPressed: editButtonsEnabled ? () {} : null,
            onLongPressed:
                editButtonsEnabled && !isEditMode && !widget.fromSessionCreation
                    ? () => setState(() => isEditMode = true)
                    : null,
          ),
        ),
      );
    return builtSetList;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          centerTitle: true,
          title: isEditMode
              ? TextField(
                  controller: exerciseNameController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (value != "" && value != null)
                      setState(() {
                        exerciseName = value;
                        isEdited = true;
                        toggleValidateButton(setsOfExercise);
                      });
                  },
                  onTap: () => setState(
                      () => textFieldBackgroundColor = Colors.transparent),
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: textFieldBackgroundColor,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(border: InputBorder.none),
                )
              : Text(exerciseName),
          leading: isEditMode
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => setState(() {
                    isEditMode = isEdited = initEquipmentId = false;
                    textFieldBackgroundColor = StrongrColors.blue80;
                    exerciseNameController.text = exerciseName;
                    futureExercise = ExerciseService.getExercise(id: widget.id);
                    setsOfExercise = [];
                  }),
                )
              : BackButton(onPressed: () {
                  if (exerciseUpdated)
                    Navigator.pop(context, {
                      CREATE: false,
                      UPDATE: true,
                      DELETE: false,
                    });
                  else
                    Navigator.pop(context);
                }),
          actions: <Widget>[
            !widget.fromSessionCreation
                ? isEditMode
                    ? IconButton(
                        icon: Icon(
                          Icons.check,
                          color: isEdited &&
                                  validateButtonEnabled &&
                                  setsOfExercise.length != 0
                              ? Colors.white
                              : Colors.grey,
                        ),
                        onPressed: isEdited &&
                                validateButtonEnabled &&
                                setsOfExercise.length != 0
                            ? () => sendToServer()
                            : null,
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          color:
                              !editButtonsEnabled ? Colors.grey : Colors.white,
                        ),
                        onPressed: editButtonsEnabled
                            ? () {
                                globalKey.currentState.hideCurrentSnackBar();
                                setState(() => isEditMode = true);
                              }
                            : null,
                      )
                : SizedBox(),
          ],
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder(
              future: futureExercise,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  try {
                    if (!initEquipmentId) {
                      equipmentId = snapshot.data.equipment.id;
                      equipmentName = snapshot.data.equipment.name;
                      initEquipmentId = true;
                    }
                  } catch (e) {}
                  return Container(
                    child: InkWell(
                      onTap: !editButtonsEnabled || isEditMode
                          ? null
                          : () {
                              Navigator.pushNamed(
                                context,
                                APP_EXERCISE_ROUTE,
                                arguments: AppExerciseView(
                                  id: snapshot.data.appExercise.id,
                                  name: snapshot.data.appExercise.name,
                                  isBelonged: true,
                                  selectedEquipmentId: equipmentId,
                                ),
                              );
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Visibility(
                            visible: !isEditMode,
                            child: Container(
                              width: 50,
                            ),
                          ),
                          Visibility(
                            visible: !isEditMode,
                            child: Flexible(
                              child: Container(
                                height: 75,
                                padding: EdgeInsets.all(8),
                                // color: Colors.red,
                                child: Center(
                                  child: StrongrText(
                                    widget.appExerciseName,
                                    bold: true,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isEditMode,
                            child: Flexible(
                              child: Container(
                                height: 75,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        // color: Colors.blue,
                                        padding: EdgeInsets.all(8),
                                        child: Center(
                                          child: StrongrText(
                                            widget.appExerciseName,
                                            bold: true,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        height: 50,
                                        width: 1,
                                        color: Colors.grey[350],
                                      ),
                                    ),
                                    Flexible(
                                      child: InkWell(
                                        child: Container(
                                          // color: Colors.green,
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  child: Center(
                                                    child: StrongrText(
                                                      equipmentName != null
                                                          ? equipmentName
                                                          : "Aucun équipement",
                                                      color: equipmentName !=
                                                              null
                                                          ? StrongrColors.black
                                                          : Colors.grey,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: StrongrColors.black,
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          Navigator.pushNamed(
                                            context,
                                            EQUIPMENTS_ROUTE,
                                            arguments: EquipmentsView(
                                              appExerciseId:
                                                  snapshot.data.appExercise.id,
                                              appExerciseName: snapshot
                                                  .data.appExercise.name,
                                              selectedEquipmentId: equipmentId,
                                            ),
                                          ).then(
                                            (selectedEquipment) {
                                              if (selectedEquipment != null) {
                                                Equipment equipment =
                                                    selectedEquipment;
                                                if (equipment.id != equipmentId)
                                                  setState(() {
                                                    equipmentId = equipment.id;
                                                    equipmentName =
                                                        equipment.name;
                                                  });
                                                else
                                                  setState(() {
                                                    equipmentId = null;
                                                    equipmentName = null;
                                                  });
                                                setState(() => isEdited = true);
                                                toggleValidateButton(
                                                    setsOfExercise);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !isEditMode,
                            child: SizedBox(
                              width: 50,
                              child: Icon(
                                Icons.info_outline,
                                color: editButtonsEnabled
                                    ? StrongrColors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error, textAlign: TextAlign.center);
                } else {
                  return Container(
                    width: ScreenSize.width(context),
                    padding: EdgeInsets.all(20),
                    child: StrongrText(
                      widget.appExerciseName,
                      bold: true,
                    ),
                  );
                }
              },
            ),
            Container(
              width: ScreenSize.width(context),
              height: 0.5,
              color: StrongrColors.greyD,
            ),
            Flexible(
              child: Container(
                // color: Colors.red,
                // height: 100,
                // height: ScreenSize.height(context) / 1.6,
                child: FutureBuilder(
                  future: futureExercise,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      setsOfExercise = snapshot.data.sets;
                      return ListView(
                        physics: BouncingScrollPhysics(),
                        children: buildSetList(setList: setsOfExercise),
                      );
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
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 140,
          // color: Colors.blue,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenSize.width(context),
                height: 0.5,
                color: Colors.grey[350],
              ),
              Container(
                height: 70,
                child: !isEditMode
                    ? FutureBuilder(
                        future: futureExercise,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              width: ScreenSize.width(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  StrongrText(
                                    "Créé le " +
                                        DateFormater.format(snapshot
                                            .data.creationDate
                                            .toString()) +
                                        " à " +
                                        DateFormater.format(
                                          snapshot.data.creationDate.toString(),
                                          timeOnly: true,
                                        ),
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  StrongrText(
                                    snapshot.data.creationDate !=
                                            snapshot.data.lastUpdate
                                        ? "Mis à jour le " +
                                            DateFormater.format(snapshot
                                                .data.lastUpdate
                                                .toString()) +
                                            " à " +
                                            DateFormater.format(
                                              snapshot.data.lastUpdate
                                                  .toString(),
                                              timeOnly: true,
                                            )
                                        : "",
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ],
                              ),
                            );
                          }
                          if (snapshot.hasError)
                            return Text(
                              snapshot.error,
                              textAlign: TextAlign.center,
                            );
                          else
                            return Container();
                        },
                      )
                    : Container(
                        padding: EdgeInsets.all(10),
                        width: ScreenSize.width(context),
                        child: Center(
                          child: FloatingActionButton.extended(
                            heroTag: "add_fab",
                            backgroundColor: !editButtonsEnabled ||
                                    setsOfExercise.length >= 10
                                ? Colors.grey
                                : StrongrColors.black,
                            label: StrongrText(
                              "Nouvelle série",
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: !editButtonsEnabled ||
                                    setsOfExercise.length >= 10
                                ? null
                                : () => showDialog(
                                      context: context,
                                      builder: (context) => NewSetDialog(
                                        repetitionCount: 10,
                                        restTime: Duration(seconds: 90),
                                      ),
                                    ).then((value) {
                                      if (value != null) {
                                        Set returnedSet = Set(
                                          repetitionCount:
                                              value["repetitionCount"],
                                          restTime: value["restTime"].inSeconds,
                                        );
                                        addSet(returnedSet);
                                      }
                                    }),
                          ),
                        ),
                      ),
              ),
              Visibility(
                visible: !widget.fromSessionCreation,
                child: FloatingActionButton.extended(
                  heroTag: !widget.fromSession
                      ? 'exercise_play_fab_' + widget.id.toString()
                      : 'fs_exercise_play_fab_' + widget.id.toString(),
                  backgroundColor: !editButtonsEnabled
                      ? Colors.grey
                      : isEditMode ? Colors.red[800] : StrongrColors.blue,
                  icon: Icon(
                    isEditMode ? Icons.delete_outline : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  label: StrongrText(
                    isEditMode ? "Supprimer" : "Démarrer",
                    color: Colors.white,
                  ),
                  onPressed: editButtonsEnabled
                      ? isEditMode
                          ? () => showDeleteDialog()
                          : () {
                              Navigator.pushNamed(
                                context,
                                EXERCISES_LOADING_ROUTE,
                                arguments: ExercisesLoadingView(
                                  exerciseId: widget.id,
                                  name: widget.name,
                                ),
                              );
                            }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
