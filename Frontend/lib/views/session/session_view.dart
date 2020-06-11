import 'package:flutter/material.dart';
import 'package:strongr/models/Session.dart';
import 'package:strongr/services/session_service.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercise_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SessionView extends StatefulWidget {
  final String id;
  final String name;
  final String sessionTypeName;
  final bool fromProgram;

  SessionView(
      {this.id, this.name, this.sessionTypeName, this.fromProgram = false});

  @override
  _SessionViewState createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  bool isEditMode;
  Future<Session> futureSession;

  @override
  void initState() {
    isEditMode = false;
    futureSession = SessionService.getSession(id: int.parse(widget.id));
    super.initState();
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
                            item.place != null || item.place >= 1
                                ? item.place.toString()
                                : "-",
                            color: isEditMode ||
                                    item.place != null ||
                                    item.place >= 1
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
                !isEditMode
                    ? Container(
                        width: 35,
                        height: 35,
                        child: FloatingActionButton(
                          elevation: 0,
                          heroTag: "fs_exercise_play_fab_" + item.id.toString(),
                          tooltip: !isEditMode ? "Démarrer" : "Supprimer",
                          backgroundColor: !isEditMode
                              ? StrongrColors.blue
                              : Colors.red[800],
                          child: Icon(
                            !isEditMode
                                ? Icons.play_arrow
                                : Icons.delete_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      )
                    : Container(
                        width: 35,
                        height: 35,
                        child: RawMaterialButton(
                          child: Icon(
                            Icons.close,
                            color: Colors.red[800],
                          ),
                          shape: CircleBorder(),
                          onPressed: () {},
                        ),
                      ),
              ],
            ),
            onPressed: !isEditMode
                ? () {
                    Navigator.pushNamed(
                      context,
                      EXERCISE_ROUTE,
                      arguments: ExerciseView(
                        id: item.id.toString(),
                        name: item.name.toString(),
                        appExerciseName: item.appExerciseName,
                        fromSession: true,
                      ),
                    );
                  }
                : null,
            onLongPressed:
                !isEditMode ? () => setState(() => isEditMode = true) : null,
          ),
        ),
      );
    return builtExerciseList;
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
            FutureBuilder(
              future: futureSession,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data);
                  return Container(
                    // color: Colors.red,
                    child: InkWell(
                      onTap: isEditMode ? null : () {},
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
                                child: Icon(Icons.info_outline),
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
                    backgroundColor: StrongrColors.black,
                    label: StrongrText(
                      "Nouvel exercice",
                      color: Colors.white,
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: !widget.fromProgram
            ? 'session_play_fab_' + widget.id.toString()
            : 'fp_session_play_fab_' + widget.id.toString(),
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
