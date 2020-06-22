import 'package:flutter/material.dart';
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
  bool isEditMode, editButtonsEnabled;
  Future<Session> futureSession;

  @override
  void initState() {
    isEditMode = false;
    editButtonsEnabled = true;
    futureSession = SessionService.getSession(id: widget.id);
    super.initState();
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

  List<Widget> buildExerciseList({List exerciseList}) {
    List<Widget> builtExerciseList = [];
    for (final item in exerciseList)
      builtExerciseList.add(
        Container(
          margin:
              exerciseList.indexOf(item) == 0 ? EdgeInsets.only(top: 5) : null,
          key: ValueKey(exerciseList.indexOf(item)),
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
                          onPressed:
                              editButtonsEnabled && isEditMode ? () {} : null,
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: !editButtonsEnabled
                                ? Colors.grey
                                : isEditMode
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
                            item.place != null ? item.place.toString() : "-",
                            color: isEditMode || item.place != null
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
                          onPressed:
                              editButtonsEnabled && isEditMode ? () {} : null,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: !editButtonsEnabled
                                ? Colors.grey
                                : isEditMode
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
                                Icons.fitness_center,
                                color:
                                    isEditMode || item.appExerciseName == null
                                        ? Colors.grey
                                        : StrongrColors.black,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // color: Colors.blue,
                                child: StrongrText(
                                  item.appExerciseName ?? "Aucun exercice",
                                  color:
                                      isEditMode || item.appExerciseName == null
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
                                Icons.refresh,
                                color: isEditMode ||
                                        item.setCount == null ||
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
                                  color: isEditMode ||
                                          item.setCount == null ||
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
                                color: isEditMode || item.tonnage == null
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
                                      : "Tonnage non calculé",
                                  color: isEditMode || item.tonnage == null
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
                !widget.fromProgramCreation
                    ? !isEditMode
                        ? Container(
                            width: 35,
                            height: 35,
                            child: FloatingActionButton(
                              elevation: 0,
                              heroTag:
                                  "fs_exercise_play_fab_" + item.id.toString(),
                              tooltip: "Démarrer",
                              backgroundColor: editButtonsEnabled
                                  ? StrongrColors.blue
                                  : Colors.grey,
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: editButtonsEnabled ? () {} : null,
                            ),
                          )
                        : Container(
                            width: 35,
                            height: 35,
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.close,
                                color: editButtonsEnabled
                                    ? Colors.red[800]
                                    : Colors.grey,
                              ),
                              onPressed: editButtonsEnabled ? () {} : null,
                            ),
                          )
                    : SizedBox(),
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
                        appExerciseName: item.appExerciseName,
                        fromSession: true,
                        fromSessionCreation:
                            widget.fromProgramCreation ? true : false,
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
    return Scaffold(
      key: globalKey,
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
          !widget.fromProgramCreation
              ? isEditMode
                  ? IconButton(
                      icon: Icon(
                        Icons.check,
                        color: !editButtonsEnabled ? Colors.grey : Colors.white,
                      ),
                      onPressed: () {},
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: !editButtonsEnabled ? Colors.grey : Colors.white,
                      ),
                      onPressed: editButtonsEnabled
                          ? () => setState(() => isEditMode = true)
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
            Container(
              // color: Colors.red,
              height: ScreenSize.height(context) / 1.6,
              child: FutureBuilder(
                future: futureSession,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: buildExerciseList(
                          exerciseList: snapshot.data.exercises),
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
              future: futureSession,
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
            Visibility(
              visible: isEditMode,
              child: Container(
                padding: EdgeInsets.all(10),
                width: ScreenSize.width(context),
                child: Center(
                  child: FloatingActionButton.extended(
                    heroTag: "add_fab",
                    backgroundColor:
                        !editButtonsEnabled ? Colors.grey : StrongrColors.black,
                    label: StrongrText(
                      "Nouvel exercice",
                      color: Colors.white,
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: editButtonsEnabled ? () {} : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !widget.fromProgramCreation
          ? FloatingActionButton.extended(
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
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
