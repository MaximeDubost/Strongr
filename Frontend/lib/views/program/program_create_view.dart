import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/models/ProgramGoal.dart';
import 'package:strongr/models/SessionPreview.dart';
import 'package:strongr/services/ProgramGoalService.dart';
import 'package:strongr/services/ProgramService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/session/session_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_snackbar_content.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ProgramCreateView extends StatefulWidget {
  _ProgramCreateViewState createState() => _ProgramCreateViewState();
}

class _ProgramCreateViewState extends State<ProgramCreateView> {
  final globalKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate, createButtonEnabled, editButtonsEnabled;
  int selectedProgramGoalId, lastIndexPressed;
  String errorText = "";
  Future<List<ProgramGoal>> futureProgramGoals;
  List<bool> programGoalSelection;
  TextEditingController programNameController;
  List<SessionPreview> sessionsOfProgram;

  @override
  void initState() {
    super.initState();
    selectedProgramGoalId = 1;
    // print(selectedProgramGoalId);
    programGoalSelection = List<bool>();
    programNameController = TextEditingController(text: "");
    _validate = createButtonEnabled = false;
    editButtonsEnabled = true;
    futureProgramGoals = ProgramGoalService.getProgramGoals();
    sessionsOfProgram = List<SessionPreview>();
    sessionsOfProgram.addAll([
      SessionPreview(id: null, place: 1),
      SessionPreview(id: null, place: 2),
      SessionPreview(id: null, place: 3),
      SessionPreview(id: null, place: 4),
      SessionPreview(id: null, place: 5),
      SessionPreview(id: null, place: 6),
      SessionPreview(id: null, place: 7),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    programNameController.dispose();
  }

  void sendToServer() async {
    FocusScope.of(context).unfocus();
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        createButtonEnabled = false;
        editButtonsEnabled = false;
      });
      int statusCode = await ProgramService.postProgram(
        programGoalId: selectedProgramGoalId,
        name: programNameController.text == ""
            ? "Programme perso."
            : programNameController.text,
        sessions: sessionsOfProgram,
      );
      // statusCode =  0;
      if (statusCode == 201) {
        Navigator.pop(context, true);
      } else {
        try {
          globalKey.currentState.hideCurrentSnackBar();
          globalKey.currentState.showSnackBar(
            SnackBar(
              content: StrongrSnackBarContent(
                icon: Icons.close,
                message: "Échec lors de la création du programme",
              ),
              backgroundColor: Colors.red.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          );
          setState(() {
            createButtonEnabled = true;
            editButtonsEnabled = true;
          });
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void toggleCreateButton(List<dynamic> list) {
    bool atLeastOneNotNullId = false;
    for (final item in list) {
      if (item.id != null) {
        atLeastOneNotNullId = true;
        break;
      }
    }
    if (atLeastOneNotNullId)
      setState(() => createButtonEnabled = true);
    else
      setState(() => createButtonEnabled = false);
  }

  void addSession(Object returnedSession) {
    if (returnedSession != null) {
      SessionPreview session = returnedSession;
      session.place = lastIndexPressed + 1;
      setState(() => sessionsOfProgram[lastIndexPressed] = session);
    }
    toggleCreateButton(sessionsOfProgram);
  }

  void deleteSession(int index) {
    setState(() {
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
            sessionsOfProgram[index + 1] = sessionsOfProgram[index];
            sessionsOfProgram[index] = transition;
            for (final item in sessionsOfProgram)
              item.place = sessionsOfProgram.indexOf(item) + 1;
          });
        }
        break;
    }
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

  List<Widget> buildSessionList({List sessionList}) {
    List<Widget> builtexerciseList = [];
    for (final item in sessionList)
      item.id != null
          ? builtexerciseList.add(
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
                              child: RawMaterialButton(
                                onPressed: sessionList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? () {}
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        changePlaceOfSession(
                                          sessionList.indexOf(item),
                                          AxisDirection.up,
                                        );
                                      },
                                hoverColor: sessionList.indexOf(item) == 0 ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyE,
                                splashColor: sessionList.indexOf(item) == 0 ||
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
                              ),
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
                              child: RawMaterialButton(
                                onPressed: sessionList.indexOf(item) ==
                                            sessionList
                                                .indexOf(sessionList.last) ||
                                        !editButtonsEnabled
                                    ? () {}
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        changePlaceOfSession(
                                          sessionList.indexOf(item),
                                          AxisDirection.down,
                                        );
                                      },
                                hoverColor: sessionList.indexOf(item) ==
                                            sessionList
                                                .indexOf(sessionList.last) ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyE,
                                splashColor: sessionList.indexOf(item) ==
                                            sessionList
                                                .indexOf(sessionList.last) ||
                                        !editButtonsEnabled
                                    ? Colors.transparent
                                    : StrongrColors.greyD,
                                enableFeedback: sessionList.indexOf(item) ==
                                            sessionList
                                                .indexOf(sessionList.last) ||
                                        !editButtonsEnabled
                                    ? false
                                    : true,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: sessionList.indexOf(item) ==
                                              sessionList
                                                  .indexOf(sessionList.last) ||
                                          !editButtonsEnabled
                                      ? Colors.grey
                                      : StrongrColors.black,
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
                        child: RawMaterialButton(
                          onPressed: editButtonsEnabled
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  deleteSession(sessionList.indexOf(item));
                                }
                              : null,
                          child: Icon(
                            Icons.close,
                            color: Colors.red[800],
                          ),
                          shape: CircleBorder(),
                        ),
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
                  onPressed: () {
                    FocusScope.of(context).unfocus();
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
                  },
                ),
              ),
            )
          : builtexerciseList.add(
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
                            visible: true,
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
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      lastIndexPressed = sessionList.indexOf(item);
                      Navigator.pushNamed(context, PROGRAM_NEW_SESSION_ROUTE)
                          .then(addSession);
                    },
                  ),
                ),
              ),
            );
    return builtexerciseList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(onPressed: () => Navigator.pop(context, false)),
        title: Text("Nouveau programme"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.edit),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Form(
              key: _key,
              autovalidate: _validate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: StrongrText("Nom"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: StrongrRoundedTextFormField(
                      controller: programNameController,
                      // validator: null,
                      // onSaved: (String value) => setState(
                      // () => connectId = value.toLowerCase()),
                      onSaved: (value) {},

                      // onChanged: (String value) {
                      //   setState(() => warning = null);
                      //   isEmpty();
                      // },
                      onChanged: (value) {},
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      hint: "Programme perso.",
                      textInputType: TextInputType.text,
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: StrongrText("Objectif"),
                  ),
                  Container(
                    // color: Colors.red,
                    height: 80,
                    width: ScreenSize.width(context),
                    child: FutureBuilder(
                      future: futureProgramGoals,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == null) {
                            return Center(
                              child: StrongrText(
                                "Impossible d'afficher les équipements associés",
                                color: Colors.grey,
                              ),
                            );
                          } else if (snapshot.data.length == 0) {
                            return Center(
                              child: StrongrText(
                                "Aucun équipement à afficher",
                                color: Colors.grey,
                              ),
                            );
                          } else {
                            for (int i = 0; i < snapshot.data.length; i++)
                              i == 0
                                  ? programGoalSelection.add(true)
                                  : programGoalSelection.add(false);
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              // padding: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left: 10, right: 10),
                              children: <Widget>[
                                for (final item in snapshot.data)
                                  StrongrRoundedContainer(
                                    width: ScreenSize.width(context) / 1.5,
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width:
                                              ScreenSize.width(context) / 2.8,
                                          child: Center(
                                            child: StrongrText(
                                              item.name,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          thickness: 1,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.info_outline,
                                            color: editButtonsEnabled
                                                ? StrongrColors.blue
                                                : Colors.grey,
                                          ),
                                          onPressed: editButtonsEnabled
                                              ? () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                }
                                              : null,
                                        ),
                                      ],
                                    ),
                                    borderColor: programGoalSelection[
                                            snapshot.data.indexOf(item)]
                                        ? StrongrColors.blue80
                                        : StrongrColors.greyD,
                                    borderWidth: programGoalSelection[
                                            snapshot.data.indexOf(item)]
                                        ? 2
                                        : 1,
                                    onPressed: editButtonsEnabled
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            // if (selectedProgramGoalId ==
                                            //     item.id) {
                                            //   setState(() {
                                            //     selectedProgramGoalId = null;
                                            //     programGoalSelection[snapshot
                                            //         .data
                                            //         .indexOf(item)] = false;
                                            //   });
                                            // } else
                                            setState(() {
                                              for (int i = 0;
                                                  i <
                                                      programGoalSelection
                                                          .length;
                                                  i++)
                                                programGoalSelection[i] = false;
                                              programGoalSelection[snapshot.data
                                                  .indexOf(item)] = true;
                                              selectedProgramGoalId = item.id;
                                            });
                                            // print(selectedProgramGoalId);
                                          }
                                        : null,
                                  ),
                              ],
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Text(
                            snapshot.error,
                            textAlign: TextAlign.center,
                          );
                        } else
                          return Container(
                            alignment: Alignment.center,
                            height: ScreenSize.height(context) / 1.25,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                StrongrColors.blue,
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: StrongrText("Séances"),
                  ),
                  // Container(
                  //   // color: Colors.red,
                  //   height: 50,
                  //   child: Center(
                  //     child: StrongrText(
                  //       "Aucune séance",
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  Column(
                    children: buildSessionList(sessionList: sessionsOfProgram),
                  )
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   width: ScreenSize.width(context),
                  //   child: Center(
                  //     child: FloatingActionButton.extended(
                  //       heroTag: "add_fab",
                  //       backgroundColor: StrongrColors.black,
                  //       onPressed: () {},
                  //       label: StrongrText("Ajouter", color: Colors.white,),
                  //       icon: Icon(Icons.add, color: Colors.white,),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // color: Colors.red,
        height: 80,
        child: Stack(
          children: <Widget>[
            Divider(
              thickness: 0.5,
              color: Colors.grey,
              height: 1,
            ),
            Center(
              child: FloatingActionButton.extended(
                backgroundColor:
                    createButtonEnabled ? StrongrColors.blue : Colors.grey,
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: createButtonEnabled ? () => sendToServer() : null,
                label: StrongrText(
                  "Créer",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
