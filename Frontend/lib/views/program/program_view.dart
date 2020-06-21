import 'package:flutter/material.dart';
import 'package:strongr/models/Program.dart';
import 'package:strongr/services/ProgramService.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/session/session_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ProgramView extends StatefulWidget {
  final String id;
  final String name;
  final String programGoalName;

  ProgramView({this.id, this.name, this.programGoalName});

  @override
  _ProgramViewState createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  String weekday;
  bool isEditMode;
  Future<Program> futureProgram;

  @override
  void initState() {
    isEditMode = false;
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

  List<Widget> buildSessionList({List sessionList}) {
    List<Widget> builtexerciseList = [];
    for (final item in sessionList)
      item.id != null
          ? builtexerciseList.add(
              Container(
                margin: sessionList.indexOf(item) == 0
                    ? EdgeInsets.only(top: 5)
                    : null,
                key: ValueKey(sessionList.indexOf(item)),
                padding: EdgeInsets.all(5),
                height: 110,
                child: StrongrRoundedContainer(
                  width: ScreenSize.width(context),
                  borderColor:
                      item.place == DateTime.now().weekday && !isEditMode
                          ? StrongrColors.blue80
                          : StrongrColors.greyD,
                  borderWidth:
                      item.place == DateTime.now().weekday && !isEditMode
                          ? 3
                          : 1,
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
                                      Icons.accessibility,
                                      color: isEditMode ||
                                              item.sessionTypeName == null
                                          ? Colors.grey
                                          : StrongrColors.black,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      // color: Colors.blue,
                                      child: StrongrText(
                                        item.sessionTypeName ?? "Aucun type",
                                        color: isEditMode ||
                                                item.sessionTypeName == null
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
                                      color: isEditMode ||
                                              item.exerciseCount == null ||
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
                                        color: isEditMode ||
                                                item.exerciseCount == null ||
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
                                            ? "Tonnage de " +
                                                item.tonnage.toString()
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
                      Visibility(
                        visible: isEditMode,
                        child: Container(
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
                      ),
                      Visibility(
                        visible: !isEditMode,
                        child: Container(
                          width: 35,
                          height: 35,
                          child: FloatingActionButton(
                            elevation: 0,
                            heroTag:
                                "fp_session_play_fab_" + item.id.toString(),
                            tooltip: "Démarrer",
                            backgroundColor: StrongrColors.blue,
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: !isEditMode
                      ? () {
                          Navigator.pushNamed(
                            context,
                            SESSION_ROUTE,
                            arguments: SessionView(
                              id: item.id.toString(),
                              name: item.name,
                              sessionTypeName: item.sessionTypeName,
                              fromProgram: true,
                            ),
                          );
                        }
                      : null,
                  onLongPressed: !isEditMode
                      ? () => setState(() => isEditMode = true)
                      : null,
                ),
              ),
            )
          : builtexerciseList.add(
              Container(
                margin: sessionList.indexOf(item) == 0
                    ? EdgeInsets.only(top: 5)
                    : null,
                key: ValueKey(sessionList.indexOf(item)),
                padding: EdgeInsets.all(5),
                height: 110,
                child: Container(
                  width: ScreenSize.width(context) / 1.2,
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
                    onPressed: isEditMode ? () {} : null,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: StrongrText(
                            getShortWeekDay(item.place),
                            size: 42,
                            color: !isEditMode
                                ? StrongrColors.greyC
                                : StrongrColors.greyB,
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          width: ScreenSize.width(context),
                          alignment: Alignment.centerRight,
                          child: Visibility(
                            visible: isEditMode,
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
                  ),
                ),
              ),
            );
    return builtexerciseList;
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
              future: futureProgram,
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
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children:
                          buildSessionList(sessionList: snapshot.data.sessions),
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
              backgroundColor: isEditMode
                  ? Colors.red[800]
                  : snapshot.data.sessions[DateTime.now().weekday - 1].id !=
                          null
                      ? StrongrColors.blue
                      : Colors.grey,
              icon: Icon(
                isEditMode ? Icons.delete_outline : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: isEditMode
                  ? () {}
                  : snapshot.data.sessions[DateTime.now().weekday - 1].id !=
                          null
                      ? () {}
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
