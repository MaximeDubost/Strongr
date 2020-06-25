import 'package:flutter/material.dart';
import 'package:strongr/models/Program.dart';
import 'package:strongr/models/SessionPreview.dart';
import 'package:strongr/services/ProgramService.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/string_constants.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/session/session_view.dart';
import 'package:strongr/widgets/dialogs/delete_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_snackbar_content.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ProgramView extends StatefulWidget {
  final int id;
  final String name;
  final String programGoalName;

  ProgramView({this.id, this.name, this.programGoalName});

  @override
  _ProgramViewState createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  final globalKey = GlobalKey<ScaffoldState>();
  bool isEditMode, validateButtonEnabled, editButtonsEnabled, isEdited;
  String weekday;
  int lastIndexPressed;
  Future<Program> futureProgram;
  List<SessionPreview> sessionsOfProgram;

  @override
  void initState() {
    isEditMode = validateButtonEnabled = isEdited = false;
    editButtonsEnabled = true;
    switch (DateTime.now().weekday) {
      case DateTime.monday:
        weekday = "Lundi";
        break;
      case DateTime.tuesday:
        weekday = "Mardi";
        break;
      case DateTime.wednesday:
        weekday = "Mercredi";
        break;
      case DateTime.thursday:
        weekday = "Jeudi";
        break;
      case DateTime.friday:
        weekday = "Vendredi";
        break;
      case DateTime.saturday:
        weekday = "Samedi";
        break;
      case DateTime.sunday:
        weekday = "Dimanche";
        break;
    }
    futureProgram = ProgramService.getProgram(id: widget.id);
    sessionsOfProgram = List<SessionPreview>();
    sessionsOfProgram.addAll([
      SessionPreview(place: 1),
      SessionPreview(place: 2),
      SessionPreview(place: 3),
      SessionPreview(place: 4),
      SessionPreview(place: 5),
      SessionPreview(place: 6),
      SessionPreview(place: 7),
    ]);
    super.initState();
  }

  String getShortWeekDay(int day) {
    switch (day) {
      case DateTime.monday:
        return "Lun.";
        break;
      case DateTime.tuesday:
        return "Mar.";
        break;
      case DateTime.wednesday:
        return "Mer.";
        break;
      case DateTime.thursday:
        return "Jeu.";
        break;
      case DateTime.friday:
        return "Ven.";
        break;
      case DateTime.saturday:
        return "Sam.";
        break;
      case DateTime.sunday:
        return "Dim.";
        break;
    }
    return "";
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        height: 300,
        title: "Supprimer ce programme ?",
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
                    "Les séances contenues dans ce programme ne seront pas supprimées.",
                    color: Colors.grey,
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
          int statusCode = await ProgramService.deleteProgram(id: widget.id);
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
                  message: "Échec lors de la suppression du programme",
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
    int statusCode = await ProgramService.putProgram(
      id: widget.id,
      programGoalName: widget.programGoalName,
      name: widget.name,
      sessions: sessionsOfProgram,
    );
    if (statusCode == 200) {
      globalKey.currentState.hideCurrentSnackBar();
      globalKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: StrongrSnackBarContent(
            message: "Programme mis à jour avec succès",
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
        isEditMode = false;
        isEdited = false;
      });
    } else {
      globalKey.currentState.hideCurrentSnackBar();
      globalKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: StrongrSnackBarContent(
            icon: Icons.close,
            message: "Échec lors de la mise à jour du programme",
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

  void toggleCreateButton(List<dynamic> list) {
    bool atLeastTwoElements = false;
    int elementCount = 0;
    for (final item in list) {
      if (item.id != null) {
        elementCount++;
        if (elementCount >= 2) {
          atLeastTwoElements = true;
          break;
        }
      }
    }

    if (atLeastTwoElements)
      setState(() => validateButtonEnabled = true);
    else
      setState(() => validateButtonEnabled = false);
  }

  void addSession(Object returnedSession) {
    if (returnedSession != null) {
      bool alreadyExists = false;
      SessionPreview session = returnedSession;
      for (final item in sessionsOfProgram)
        if (session.id == item.id) alreadyExists = true;
      if (!alreadyExists) {
        session.place = lastIndexPressed + 1;
        setState(() {
          isEdited = true;
          sessionsOfProgram[lastIndexPressed] = session;
        });
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
                  message: "Cette séance a déjà été ajoutée",
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
    toggleCreateButton(sessionsOfProgram);
  }

  void deleteSession(int index) {
    setState(() {
      isEdited = true;
      sessionsOfProgram[index] = SessionPreview(place: index + 1);
    });
    toggleCreateButton(sessionsOfProgram);
  }

  void changePlaceOfSession(int index, AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
      case AxisDirection.left:
        if (index > 0) {
          SessionPreview transition = sessionsOfProgram[index - 1];
          setState(() {
            isEdited = true;
            sessionsOfProgram[index - 1] = sessionsOfProgram[index];
            sessionsOfProgram[index] = transition;
            for (final item in sessionsOfProgram)
              item.place = sessionsOfProgram.indexOf(item) + 1;
          });
        }
        break;
      case AxisDirection.right:
      case AxisDirection.down:
        if (index < sessionsOfProgram.indexOf(sessionsOfProgram.last)) {
          SessionPreview transition = sessionsOfProgram[index + 1];
          setState(() {
            isEdited = true;
            sessionsOfProgram[index + 1] = sessionsOfProgram[index];
            sessionsOfProgram[index] = transition;
            for (final item in sessionsOfProgram)
              item.place = sessionsOfProgram.indexOf(item) + 1;
          });
        }
        break;
    }
  }

  List<Widget> buildSessionList({List sessionList}) {
    List<Widget> builtSessionList = [];
    for (final item in sessionList)
      item.id != null
          ? builtSessionList.add(
              Container(
                // color: Colors.blue,
                margin: sessionList.indexOf(item) == 0
                    ? EdgeInsets.only(top: 5)
                    : null,
                key: ValueKey(sessionList.indexOf(item)),
                padding: EdgeInsets.all(5),
                height: 110,
                child: StrongrRoundedContainer(
                  width: ScreenSize.width(context),
                  borderColor: StrongrColors.greyD,
                  borderWidth: 1,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Container(
                      //   // color: Colors.yellow,
                      //   width: 50,
                      //   child: Center(
                      //     child: StrongrText(
                      //       getShortWeekDay(i),
                      //       bold: true,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        // color: Colors.red,
                        width: 50,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 30,
                              // color: Colors.blue,
                              child: isEditMode
                                  ? RawMaterialButton(
                                      onPressed: sessionList.indexOf(item) ==
                                                  0 ||
                                              !editButtonsEnabled
                                          ? null
                                          : () {
                                              FocusScope.of(context).unfocus();
                                              changePlaceOfSession(
                                                sessionList.indexOf(item),
                                                AxisDirection.up,
                                              );
                                            },
                                      hoverColor:
                                          sessionList.indexOf(item) == 0 ||
                                                  !editButtonsEnabled
                                              ? Colors.transparent
                                              : StrongrColors.greyE,
                                      splashColor:
                                          sessionList.indexOf(item) == 0 ||
                                                  !editButtonsEnabled
                                              ? Colors.transparent
                                              : StrongrColors.greyD,
                                      enableFeedback:
                                          sessionList.indexOf(item) == 0 ||
                                                  !editButtonsEnabled
                                              ? false
                                              : true,
                                      child: Icon(
                                        Icons.keyboard_arrow_up,
                                        color: sessionList.indexOf(item) == 0 ||
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
                              width: 50,
                              child: Center(
                                child: StrongrText(
                                  getShortWeekDay(item.place) ?? "-",
                                  bold: true,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              // color: Colors.blue,
                              child: isEditMode
                                  ? RawMaterialButton(
                                      onPressed: sessionList.indexOf(item) ==
                                                  sessionList.indexOf(
                                                      sessionList.last) ||
                                              !editButtonsEnabled
                                          ? null
                                          : () {
                                              FocusScope.of(context).unfocus();
                                              changePlaceOfSession(
                                                sessionList.indexOf(item),
                                                AxisDirection.down,
                                              );
                                            },
                                      hoverColor: sessionList.indexOf(item) ==
                                                  sessionList.indexOf(
                                                      sessionList.last) ||
                                              !editButtonsEnabled
                                          ? Colors.transparent
                                          : StrongrColors.greyE,
                                      splashColor: sessionList.indexOf(item) ==
                                                  sessionList.indexOf(
                                                      sessionList.last) ||
                                              !editButtonsEnabled
                                          ? Colors.transparent
                                          : StrongrColors.greyD,
                                      enableFeedback:
                                          sessionList.indexOf(item) ==
                                                      sessionList.indexOf(
                                                          sessionList.last) ||
                                                  !editButtonsEnabled
                                              ? false
                                              : true,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: sessionList.indexOf(item) ==
                                                    sessionList.indexOf(
                                                        sessionList.last) ||
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
                                      Icons.accessibility,
                                      color: item.sessionTypeName == null
                                          ? Colors.grey
                                          : StrongrColors.black,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      // color: Colors.blue,
                                      child: StrongrText(
                                        item.sessionTypeName ?? "Aucun type",
                                        color: item.sessionTypeName == null
                                            ? Colors.grey
                                            : StrongrColors.black,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
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
                                      Icons.fitness_center,
                                      color: item.exerciseCount == null ||
                                              int.parse(item.exerciseCount) < 1
                                          ? Colors.grey
                                          : StrongrColors.black,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      // width: 185,
                                      child: StrongrText(
                                        item.exerciseCount == null ||
                                                int.parse(item.exerciseCount) <
                                                    1
                                            ? "Aucun exercice"
                                            : item.exerciseCount == 1
                                                ? item.exerciseCount +
                                                    " exercice"
                                                : item.exerciseCount +
                                                    " exercices",
                                        color: item.exerciseCount == null ||
                                                int.parse(item.exerciseCount) <
                                                    1
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
                                            ? "Tonnage de " +
                                                item.tonnage.toString()
                                            : "Tonnage non calculé",
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
                        child: isEditMode
                            ? RawMaterialButton(
                                onPressed: editButtonsEnabled
                                    ? () {
                                        FocusScope.of(context).unfocus();
                                        deleteSession(
                                            sessionList.indexOf(item));
                                      }
                                    : null,
                                child: Icon(
                                  Icons.close,
                                  color: editButtonsEnabled
                                      ? Colors.red[800]
                                      : Colors.grey,
                                ),
                                shape: CircleBorder(),
                              )
                            : null,
                      ),
                      // Visibility(
                      //   visible: !isEditMode,
                      //   child: Container(
                      //     width: 35,
                      //     height: 35,
                      //     child: FloatingActionButton(
                      //       elevation: 0,
                      //       heroTag:
                      //           "fp_session_play_fab_" + item.id.toString(),
                      //       tooltip: "Démarrer",
                      //       backgroundColor: StrongrColors.blue,
                      //       child: Icon(
                      //         Icons.play_arrow,
                      //         color: Colors.white,
                      //       ),
                      //       onPressed: () {},
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  onPressed: editButtonsEnabled ? () {
                    FocusScope.of(context).unfocus();
                    globalKey.currentState.hideCurrentSnackBar();
                    Navigator.pushNamed(
                      context,
                      SESSION_ROUTE,
                      arguments: SessionView(
                        id: item.id,
                        name: item.name,
                        sessionTypeName: item.sessionTypeName,
                        fromProgram: false,
                        fromProgramCreation: true,
                      ),
                    );
                  } : null,
                ),
              ),
            )
          : builtSessionList.add(
              Container(
                // color: Colors.red,
                margin: sessionList.indexOf(item) == 0
                    ? EdgeInsets.only(top: 5)
                    : null,
                key: ValueKey(sessionList.indexOf(item)),
                padding: EdgeInsets.all(5),
                height: 110,
                child: Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: StrongrColors.greyE,
                    border: Border.all(color: StrongrColors.greyD),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: StrongrText(
                            getShortWeekDay(item.place),
                            size: 42,
                            color: StrongrColors.greyB,
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          width: ScreenSize.width(context),
                          alignment: Alignment.centerRight,
                          child: Visibility(
                            visible: isEditMode && editButtonsEnabled,
                            child: Container(
                              width: 35,
                              child: Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: isEditMode && editButtonsEnabled
                        ? () {
                            FocusScope.of(context).unfocus();
                            globalKey.currentState.hideCurrentSnackBar();
                            lastIndexPressed = sessionList.indexOf(item);
                            Navigator.pushNamed(
                                    context, PROGRAM_NEW_SESSION_ROUTE)
                                .then(addSession);
                          }
                        : null,
                  ),
                ),
              ),
            );
    return builtSessionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        leading: isEditMode
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () => setState(() {
                  isEditMode = false;
                  isEdited = false;
                  futureProgram = ProgramService.getProgram(id: widget.id);
                  sessionsOfProgram = [];
                }),
              )
            : BackButton(),
        actions: <Widget>[
          isEditMode
              ? IconButton(
                  icon: Icon(
                    Icons.check,
                    color: isEdited &&
                            validateButtonEnabled &&
                            sessionsOfProgram.length != 0
                        ? Colors.white
                        : Colors.grey,
                  ),
                  onPressed: isEdited &&
                          validateButtonEnabled &&
                          sessionsOfProgram.length != 0
                      ? () => sendToServer()
                      : null,
                )
              : IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: !editButtonsEnabled ? Colors.grey : Colors.white,
                  ),
                   onPressed: editButtonsEnabled
                          ? () {
                            globalKey.currentState.hideCurrentSnackBar();
                            setState(() => isEditMode = true);
                          } 
                          : null,
                )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: futureProgram,
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
                              widget.programGoalName,
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
                      widget.programGoalName,
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
            Container(
              // color: Colors.red,
              height: ScreenSize.height(context) / 1.6,
              child: FutureBuilder(
                future: futureProgram,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    sessionsOfProgram = snapshot.data.sessions;
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children:
                          buildSessionList(sessionList: sessionsOfProgram),
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
            Container(
              width: ScreenSize.width(context),
              height: 1,
              color: Colors.grey[350],
            ),
            FutureBuilder(
              future: futureProgram,
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
                          StrongrText(
                            snapshot.data.creationDate !=
                                    snapshot.data.lastUpdate
                                ? "Mis à jour le " +
                                    DateFormater.format(
                                        snapshot.data.lastUpdate.toString()) +
                                    " à " +
                                    DateFormater.format(
                                      snapshot.data.lastUpdate.toString(),
                                      timeOnly: true,
                                    )
                                : "",
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
          ],
        ),
      ),
      floatingActionButton: FutureBuilder(
        future: futureProgram,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              heroTag: 'program_play_fab_' + widget.id.toString(),
              backgroundColor: !editButtonsEnabled
                  ? Colors.grey
                  : isEditMode
                      ? Colors.red[800]
                      : snapshot.data.sessions[DateTime.now().weekday - 1].id !=
                              null
                          ? StrongrColors.blue
                          : Colors.grey,
              icon: Icon(
                isEditMode ? Icons.delete_outline : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: editButtonsEnabled
                  ? isEditMode
                      ? () => showDeleteDialog()
                      : snapshot.data.sessions[DateTime.now().weekday - 1].id !=
                              null
                          ? () {}
                          : null
                  : null,
              label: StrongrText(
                isEditMode ? "Supprimer" : "Démarrer (" + weekday + ")",
                color: Colors.white,
              ),
            );
          }
          if (snapshot.hasError)
            return Text(snapshot.error, textAlign: TextAlign.center);
          else
            // return Container();
            return FloatingActionButton.extended(
              heroTag: 'program_play_fab_' + widget.id.toString(),
              backgroundColor: isEditMode ? Colors.red[800] : Colors.grey,
              onPressed: isEditMode ? () {} : null,
              label: Container(
                height: 25,
                width: 100,
                child: Center(
                  child: Container(
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
            );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
