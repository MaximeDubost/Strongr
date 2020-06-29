import 'package:flutter/material.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/Session.dart';
import 'package:strongr/services/SessionService.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/string_constants.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercise_view.dart';
import 'package:strongr/widgets/dialogs/delete_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_snackbar_content.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SessionView extends StatefulWidget {
  final int id;
  final String name;
  final String sessionTypeName;
  final bool fromProgram;
  final bool fromProgramCreation;

  SessionView({
    this.id,
    this.name,
    this.sessionTypeName,
    this.fromProgram = false,
    this.fromProgramCreation = false,
  });

  @override
  _SessionViewState createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  final globalKey = GlobalKey<ScaffoldState>();
  bool isEditMode,
      validateButtonEnabled,
      editButtonsEnabled,
      isEdited,
      sessionUpdated;
  Future<Session> futureSession;
  List<ExercisePreview> exercisesOfSession;
  TextEditingController sessionNameController;
  String sessionName;
  Color textFieldBackgroundColor;

  @override
  void initState() {
    isEditMode = validateButtonEnabled = isEdited = sessionUpdated = false;
    editButtonsEnabled = true;
    exercisesOfSession = List<ExercisePreview>();
    futureSession = SessionService.getSession(id: widget.id);
    sessionName = widget.name;
    sessionNameController = TextEditingController(text: sessionName);
    textFieldBackgroundColor = StrongrColors.blue80;
    super.initState();
  }

  @override
  void dispose() {
    sessionNameController.dispose();
    super.dispose();
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        height: 400,
        title: "Supprimer cette séance ?",
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
                    Icons.check,
                    color: Colors.grey,
                  ),
                ),
                Flexible(
                  child: StrongrText(
                    "Les exercices contenus dans cette séance ne seront pas supprimés.",
                    color: Colors.grey,
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
                    "Les programmes contenant uniquement cet séance seront supprimés.",
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
          int statusCode = await SessionService.deleteSession(id: widget.id);
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
                  message: "Échec lors de la suppression de la séance",
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
    int statusCode = await SessionService.putSession(
      id: widget.id,
      name: sessionName,
      exercises: exercisesOfSession,
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
                message: "Séance mise à jour avec succès",
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
        sessionUpdated = true;
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
            message: "Échec lors de la mise à jour de la séance",
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
    if (list.length < 2)
      setState(() => validateButtonEnabled = false);
    else
      setState(() => validateButtonEnabled = true);
  }

  void addExercise(Object returnedExercise) {
    if (returnedExercise != null) {
      bool alreadyExists = false;
      ExercisePreview exercise = returnedExercise;
      for (final item in exercisesOfSession)
        if (exercise.id == item.id) alreadyExists = true;
      if (!alreadyExists) {
        setState(() {
          isEdited = true;
          exercisesOfSession.add(returnedExercise);
        });
        exercisesOfSession[exercisesOfSession.length - 1].place =
            exercisesOfSession.length;
      } else {
        globalKey.currentState.hideCurrentSnackBar();
        globalKey.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: GestureDetector(
              onVerticalDragStart: (_) => null,
              child: InkWell(
                onTap: () => globalKey.currentState.hideCurrentSnackBar(),
                child: StrongrSnackBarContent(
                  icon: Icons.close,
                  message: "Cet exercice a déjà été ajouté",
                ),
              ),
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
    }
    toggleValidateButton(exercisesOfSession);
  }

  void deleteExercise(int index) {
    setState(() {
      isEdited = true;
      exercisesOfSession.removeAt(index);
      for (final item in exercisesOfSession)
        item.place = exercisesOfSession.indexOf(item) + 1;
    });
    toggleValidateButton(exercisesOfSession);
  }

  void changePlaceOfExercise(int index, AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
      case AxisDirection.left:
        if (index > 0) {
          ExercisePreview transition = exercisesOfSession[index - 1];
          setState(() {
            isEdited = true;
            exercisesOfSession[index - 1] = exercisesOfSession[index];
            exercisesOfSession[index] = transition;
            for (final item in exercisesOfSession)
              item.place = exercisesOfSession.indexOf(item) + 1;
          });
        }
        break;
      case AxisDirection.right:
      case AxisDirection.down:
        if (index < exercisesOfSession.indexOf(exercisesOfSession.last)) {
          ExercisePreview transition = exercisesOfSession[index + 1];
          setState(() {
            isEdited = true;
            exercisesOfSession[index + 1] = exercisesOfSession[index];
            exercisesOfSession[index] = transition;
            for (final item in exercisesOfSession)
              item.place = exercisesOfSession.indexOf(item) + 1;
          });
        }
        break;
    }
    toggleValidateButton(exercisesOfSession);
  }

  List<Widget> buildExerciseList({List exerciseList}) {
    List<Widget> builtExerciseList = [];
    for (final item in exerciseList)
      builtExerciseList.add(
        Container(
          margin:
              exerciseList.indexOf(item) == 0 ? EdgeInsets.only(top: 5) : null,
          key: ValueKey(item.id),
          padding: EdgeInsets.all(5),
          height: 110,
          child: StrongrRoundedContainer(
            width: ScreenSize.width(context),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  // color: Colors.red,
                  width: 35,
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 30,
                        // color: Colors.blue,
                        child: isEditMode
                            ? RawMaterialButton(
                                onPressed: exerciseList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? null
                                    : () {
                                        changePlaceOfExercise(
                                          exerciseList.indexOf(item),
                                          AxisDirection.up,
                                        );
                                      },
                                hoverColor: exerciseList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyE,
                                splashColor: exerciseList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyD,
                                enableFeedback:
                                    exerciseList.indexOf(item) == 0 ||
                                            !editButtonsEnabled
                                        ? false
                                        : true,
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: exerciseList.indexOf(item) == 0 ||
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
                        height: 30,
                        // color: Colors.blue,
                        child: isEditMode
                            ? RawMaterialButton(
                                onPressed: exerciseList.indexOf(item) ==
                                            exerciseList
                                                .indexOf(exerciseList.last) ||
                                        !editButtonsEnabled
                                    ? null
                                    : () {
                                        changePlaceOfExercise(
                                          exerciseList.indexOf(item),
                                          AxisDirection.down,
                                        );
                                      },
                                hoverColor: exerciseList.indexOf(item) ==
                                            exerciseList
                                                .indexOf(exerciseList.last) ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyE,
                                splashColor: exerciseList.indexOf(item) ==
                                            exerciseList
                                                .indexOf(exerciseList.last) ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyD,
                                enableFeedback: exerciseList.indexOf(item) ==
                                            exerciseList
                                                .indexOf(exerciseList.last) ||
                                        !editButtonsEnabled
                                    ? false
                                    : true,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: exerciseList.indexOf(item) ==
                                              exerciseList
                                                  .indexOf(exerciseList.last) ||
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
                                Icons.fitness_center,
                                color: item.appExerciseName == null
                                    ? Colors.grey
                                    : StrongrColors.black,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // color: Colors.blue,
                                child: StrongrText(
                                  item.appExerciseName ?? "Aucun exercice",
                                  color: item.appExerciseName == null
                                      ? Colors.grey
                                      : StrongrColors.black,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
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
                                Icons.refresh,
                                color: item.setCount == null ||
                                        int.parse(item.setCount) < 1
                                    ? Colors.grey
                                    : StrongrColors.black,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // width: 185,
                                child: StrongrText(
                                  item.setCount == null ||
                                          int.parse(item.setCount) < 1
                                      ? "Aucune série"
                                      : item.setCount == 1
                                          ? item.setCount + " série"
                                          : item.setCount + " séries",
                                  color: item.setCount == null ||
                                          int.parse(item.setCount) < 1
                                      ? Colors.grey
                                      : StrongrColors.black,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
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
                                color: item.tonnage == null
                                    ? Colors.grey
                                    : StrongrColors.black,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // width: 185,
                                child: StrongrText(
                                  item.tonnage != null
                                      ? "Tonnage de " + item.tonnage.toString()
                                      : "Tonnage inconnu",
                                  color: item.tonnage == null
                                      ? Colors.grey
                                      : StrongrColors.black,
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
                Container(
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
                                  deleteExercise(exerciseList.indexOf(item));
                                }
                              : null,
                        )
                      : null,
                ),
                Visibility(
                  visible: !isEditMode,
                  child: Container(
                    // color: Colors.red,
                    width: 35,
                    height: 35,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "fs_exercise_play_fab_" + item.id.toString(),
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
            onPressed: editButtonsEnabled && !isEditMode
                ? () {
                    Navigator.pushNamed(
                      context,
                      EXERCISE_ROUTE,
                      arguments: ExerciseView(
                        id: item.id,
                        name: item.name.toString(),
                        appExerciseName: item.appExerciseName.toString(),
                        fromSession: true,
                        fromSessionCreation: false,
                      ),
                    );
                  }
                : null,
            onLongPressed:
                editButtonsEnabled && !isEditMode && !widget.fromProgramCreation
                    ? () => setState(() => isEditMode = true)
                    : null,
          ),
        ),
      );
    return builtExerciseList;
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
                  controller: sessionNameController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (value != "" && value != null)
                      setState(() {
                        sessionName = value;
                        isEdited = true;
                        toggleValidateButton(exercisesOfSession);
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
              : Text(sessionName),
          leading: isEditMode
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => setState(() {
                    isEditMode = false;
                    isEdited = false;
                    textFieldBackgroundColor = StrongrColors.blue80;
                    sessionNameController.text = sessionName;
                    futureSession = SessionService.getSession(id: widget.id);
                    exercisesOfSession = [];
                  }),
                )
              : BackButton(onPressed: () {
                  if (sessionUpdated)
                    Navigator.pop(context, {
                      CREATE: false,
                      UPDATE: true,
                      DELETE: false,
                    });
                  else
                    Navigator.pop(context);
                }),
          actions: <Widget>[
            !widget.fromProgramCreation
                ? isEditMode
                    ? IconButton(
                        icon: Icon(
                          Icons.check,
                          color: isEdited &&
                                  validateButtonEnabled &&
                                  exercisesOfSession.length != 0
                              ? Colors.white
                              : Colors.grey,
                        ),
                        onPressed: isEdited &&
                                validateButtonEnabled &&
                                exercisesOfSession.length != 0
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
        body: Container(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: futureSession,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data);
                    return Container(
                      // color: Colors.red,
                      child: InkWell(
                        onTap: !editButtonsEnabled || isEditMode ? null : () {},
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: ScreenSize.width(context),
                              padding: EdgeInsets.all(20),
                              child: StrongrText(
                                widget.sessionTypeName,
                                bold: true,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 15,
                                right: 15,
                              ),
                              alignment: Alignment.centerRight,
                              child: Opacity(
                                opacity: isEditMode ? 0 : 1,
                                child: Container(
                                  child: Icon(
                                    Icons.info_outline,
                                    color: editButtonsEnabled
                                        ? StrongrColors.black
                                        : Colors.grey,
                                  ),
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
                        widget.sessionTypeName,
                        bold: true,
                      ),
                    );
                  }
                },
              ),
              Container(
                width: ScreenSize.width(context),
                height: 1,
                color: Colors.grey[350],
              ),
              Flexible(
                child: Container(
                  // color: Colors.red,
                  // height: ScreenSize.height(context) / 1.6,
                  child: FutureBuilder(
                    future: futureSession,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        exercisesOfSession = snapshot.data.exercises;
                        return ListView(
                          physics: BouncingScrollPhysics(),
                          children: buildExerciseList(
                              exerciseList: exercisesOfSession),
                        );
                      }
                      if (snapshot.hasError)
                        return Text(snapshot.error,
                            textAlign: TextAlign.center);
                      else
                        return Container(
                          alignment: Alignment.center,
                          height: ScreenSize.height(context) / 1.75,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                StrongrColors.blue),
                          ),
                        );
                    },
                  ),
                ),
              ),
              // Container(
              //   width: ScreenSize.width(context),
              //   height: 1,
              //   color: Colors.grey[350],
              // ),
              // FutureBuilder(
              //   future: futureSession,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Visibility(
              //         visible: !isEditMode,
              //         child: Container(
              //           padding: EdgeInsets.all(10),
              //           width: ScreenSize.width(context),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               StrongrText(
              //                 "Créé le " +
              //                     DateFormater.format(
              //                         snapshot.data.creationDate.toString()) +
              //                     " à " +
              //                     DateFormater.format(
              //                       snapshot.data.creationDate.toString(),
              //                       timeOnly: true,
              //                     ),
              //                 color: Colors.grey,
              //                 size: 16,
              //               ),
              //               StrongrText(
              //                 snapshot.data.creationDate !=
              //                         snapshot.data.lastUpdate
              //                     ? "Mis à jour le " +
              //                         DateFormater.format(
              //                             snapshot.data.lastUpdate.toString()) +
              //                         " à " +
              //                         DateFormater.format(
              //                           snapshot.data.lastUpdate.toString(),
              //                           timeOnly: true,
              //                         )
              //                     : "",
              //                 color: Colors.grey,
              //                 size: 16,
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     }
              //     if (snapshot.hasError)
              //       return Text(snapshot.error, textAlign: TextAlign.center);
              //     else
              //       return Container();
              //   },
              // ),
              // Visibility(
              //   visible: isEditMode,
              //   child: Container(
              //     padding: EdgeInsets.all(10),
              //     width: ScreenSize.width(context),
              //     child: Center(
              //       child: FloatingActionButton.extended(
              //         heroTag: "add_fab",
              //         backgroundColor:
              //             !editButtonsEnabled || exercisesOfSession.length >= 20
              //                 ? Colors.grey
              //                 : StrongrColors.black,
              //         label: StrongrText(
              //           "Nouvel exercice",
              //           color: Colors.white,
              //         ),
              //         icon: Icon(
              //           Icons.add,
              //           color: Colors.white,
              //         ),
              //         onPressed:
              //             !editButtonsEnabled || exercisesOfSession.length >= 20
              //                 ? null
              //                 : () {
              //                     Navigator.pushNamed(
              //                       context,
              //                       SESSION_NEW_EXERCISE_ROUTE,
              //                     ).then(addExercise);
              //                   },
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        // floatingActionButton: !widget.fromProgramCreation
        //     ? FloatingActionButton.extended(
        //         // heroTag: !widget.fromProgram
        //         //     ? 'session_play_fab_' + widget.id.toString()
        //         //     : 'fp_session_play_fab_' + widget.id.toString(),
        //         backgroundColor: !editButtonsEnabled
        //             ? Colors.grey
        //             : isEditMode ? Colors.red[800] : StrongrColors.blue,
        //         icon: Icon(
        //           isEditMode ? Icons.delete_outline : Icons.play_arrow,
        //           color: Colors.white,
        //         ),
        //         label: StrongrText(
        //           isEditMode ? "Supprimer" : "Démarrer",
        //           color: Colors.white,
        //         ),
        //         onPressed: editButtonsEnabled
        //             ? isEditMode ? () => showDeleteDialog() : () {}
        //             : null,
        //       )
        //     : null,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: Container(
          height: 140,
          // color: Colors.blue,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenSize.width(context),
                height: 1,
                color: Colors.grey[350],
              ),
              Container(
                height: 70,
                child: !isEditMode
                    ? FutureBuilder(
                        future: futureSession,
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
                                    exercisesOfSession.length >= 20
                                ? Colors.grey
                                : StrongrColors.black,
                            label: StrongrText(
                              "Nouvel exercice",
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: !editButtonsEnabled ||
                                    exercisesOfSession.length >= 20
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                      context,
                                      SESSION_NEW_EXERCISE_ROUTE,
                                    ).then(addExercise);
                                  },
                            // : () => showDialog(
                            //       context: context,
                            //       builder: (context) => NewSetDialog(
                            //         repetitionCount: 10,
                            //         restTime: Duration(seconds: 90),
                            //       ),
                            //     ).then((value) {
                            //       if (value != null) {
                            //         Set returnedSet = Set(
                            //           repetitionCount:
                            //               value["repetitionCount"],
                            //           restTime: value["restTime"].inSeconds,
                            //         );
                            //         addSet(returnedSet);
                            //       }
                            //     }),
                          ),
                        ),
                      ),
              ),
              Visibility(
                visible: !widget.fromProgramCreation,
                child: FloatingActionButton.extended(
                  heroTag: !widget.fromProgram
                      ? 'session_play_fab_' + widget.id.toString()
                      : 'fp_session_play_fab_' + widget.id.toString(),
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
                      ? isEditMode ? () => showDeleteDialog() : () {}
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
