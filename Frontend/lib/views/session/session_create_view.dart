import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/SessionType.dart';
import 'package:strongr/services/SessionService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/session_type_definitor.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercise_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_snackbar_content.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SessionCreateView extends StatefulWidget {
  _SessionCreateViewState createState() => _SessionCreateViewState();
}

class _SessionCreateViewState extends State<SessionCreateView> {
  final globalKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate, createButtonEnabled, editButtonsEnabled;
  TextEditingController sessionNameController;
  int linesCount = 1;
  String errorText = "";
  List<ExercisePreview> exercisesOfSession;

  @override
  void initState() {
    super.initState();
    _validate = createButtonEnabled = false;
    editButtonsEnabled = true;
    sessionNameController = TextEditingController(text: "");
    exercisesOfSession = List<ExercisePreview>();
  }

  @override
  void dispose() {
    super.dispose();
    sessionNameController.dispose();
  }

  void sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        createButtonEnabled = false;
        editButtonsEnabled = false;
      });
      SessionType sessionType = await SessionTypeDefinitor.defineByExercises(exercisesOfSession);
      int statusCode = await SessionService.postSession(
        name: sessionNameController.text == ""
            ? "Séance perso."
            : sessionNameController.text,
        sessionType: sessionType,
        exercises: exercisesOfSession,
      );
      if (statusCode == 201) {
        Navigator.pop(context, true);
      } else {
        globalKey.currentState.hideCurrentSnackBar();
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: StrongrSnackBarContent(
              icon: Icons.close,
              message: "Échec lors de la création de la séance",
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
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void toggleCreateButton(List<dynamic> list) {
    if (list.length < 2)
      setState(() => createButtonEnabled = false);
    else
      setState(() => createButtonEnabled = true);
  }

  void addExercise(Object returnedExercise) {
    if (returnedExercise != null) {
      bool alreadyExists = false;
      ExercisePreview exercise = returnedExercise;
      for (final item in exercisesOfSession)
        if (exercise.id == item.id) alreadyExists = true;
      if (!alreadyExists) {
        setState(() {
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
    toggleCreateButton(exercisesOfSession);
  }

  void deleteExercise(int index) {
    setState(() {
      exercisesOfSession.removeAt(index);
      for (final item in exercisesOfSession)
        item.place = exercisesOfSession.indexOf(item) + 1;
    });
    toggleCreateButton(exercisesOfSession);
  }

  void changePlaceOfExercise(int index, AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
      case AxisDirection.left:
        if (index > 0) {
          ExercisePreview transition = exercisesOfSession[index - 1];
          setState(() {
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
            exercisesOfSession[index + 1] = exercisesOfSession[index];
            exercisesOfSession[index] = transition;
            for (final item in exercisesOfSession)
              item.place = exercisesOfSession.indexOf(item) + 1;
          });
        }
        break;
    }
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
                        child: RawMaterialButton(
                          onPressed: exerciseList.indexOf(item) == 0 ||
                                  !editButtonsEnabled
                              ? () {}
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
                          enableFeedback: exerciseList.indexOf(item) == 0 ||
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
                        ),
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
                        child: RawMaterialButton(
                          onPressed: exerciseList.indexOf(item) ==
                                      exerciseList.indexOf(exerciseList.last) ||
                                  !editButtonsEnabled
                              ? () {}
                              : () {
                                  changePlaceOfExercise(
                                    exerciseList.indexOf(item),
                                    AxisDirection.down,
                                  );
                                },
                          hoverColor: exerciseList.indexOf(item) ==
                                      exerciseList.indexOf(exerciseList.last) ||
                                  !editButtonsEnabled
                              ? Colors.transparent
                              : StrongrColors.greyE,
                          splashColor: exerciseList.indexOf(item) ==
                                      exerciseList.indexOf(exerciseList.last) ||
                                  !editButtonsEnabled
                              ? Colors.transparent
                              : StrongrColors.greyD,
                          enableFeedback: exerciseList.indexOf(item) ==
                                      exerciseList.indexOf(exerciseList.last) ||
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
                  child: RawMaterialButton(
                    child: Icon(
                      Icons.close,
                      color: editButtonsEnabled ? Colors.red[800] : Colors.grey,
                    ),
                    shape: CircleBorder(),
                    onPressed: editButtonsEnabled
                        ? () {
                            deleteExercise(exerciseList.indexOf(item));
                          }
                        : null,
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                EXERCISE_ROUTE,
                arguments: ExerciseView(
                  id: item.id,
                  name: item.name.toString(),
                  appExerciseName: item.appExerciseName.toString(),
                  fromSessionCreation: true,
                ),
              );
            },
          ),
        ),
      );
    return builtExerciseList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text("Nouvelle séance"),
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
                      enabled: editButtonsEnabled,
                      controller: sessionNameController,
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
                      hint: "Séance perso.",
                      textInputType: TextInputType.text,
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: StrongrText("Exercices"),
                  ),
                  // Container(
                  //   // color: Colors.red,
                  //   height: 50,
                  //   child: Center(
                  //     child: StrongrText(
                  //       "Aucun exercice",
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  Column(
                    children:
                        buildExerciseList(exerciseList: exercisesOfSession),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: ScreenSize.width(context),
                    child: Center(
                      child: FloatingActionButton.extended(
                        heroTag: "add_fab",
                        backgroundColor: editButtonsEnabled
                            ? StrongrColors.black
                            : Colors.grey,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: StrongrText(
                          "Ajouter",
                          color: Colors.white,
                        ),
                        onPressed: editButtonsEnabled
                            ? () {
                                FocusScope.of(context).unfocus();
                                globalKey.currentState.hideCurrentSnackBar();
                                Navigator.pushNamed(
                                  context,
                                  SESSION_NEW_EXERCISE_ROUTE,
                                ).then(addExercise);
                              }
                            : null,
                      ),
                    ),
                  ),
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
