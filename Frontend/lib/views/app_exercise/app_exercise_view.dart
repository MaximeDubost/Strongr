import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/AppExercise.dart';
import 'package:strongr/services/app_exercise_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercise_create_view.dart';
import 'package:strongr/widgets/dialogs/new_exercise_from_list_dialog.dart';
import 'package:strongr/widgets/strongr_text.dart';

class AppExerciseView extends StatefulWidget {
  final int id;
  final String name;
  final bool isBelonged;
  final bool fromExercises;

  AppExerciseView(
      {this.id,
      this.name,
      this.isBelonged = false,
      this.fromExercises = false});

  @override
  _AppExerciseViewState createState() => _AppExerciseViewState();
}

class _AppExerciseViewState extends State<AppExerciseView> {
  Future<AppExercise> futureAppExercise;

  @override
  void initState() {
    futureAppExercise = AppExerciseService.getAppExercise(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: futureAppExercise,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                // color: Colors.red,
                child: snapshot.data.id != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: StrongrText(
                              snapshot.data.muscleList.length <= 1
                                  ? "Muscle ciblé"
                                  : "Muscles ciblés",
                              size: 22,
                              bold: true,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[350],
                            thickness: 1,
                            indent: ScreenSize.width(context) / 4,
                            endIndent: ScreenSize.width(context) / 4,
                          ),
                          SizedBox(height: 10),
                          snapshot.data.muscleList.length == 0
                              ? Center(
                                  child: StrongrText(
                                    "Aucun élément à afficher",
                                    color: Colors.grey,
                                  ),
                                )
                              : SizedBox(),
                          for (final item in snapshot.data.muscleList)
                            Column(
                              children: <Widget>[
                                StrongrText("• " + item.name),
                                SizedBox(height: 10),
                              ],
                            ),
                          SizedBox(height: 20),
                          Center(
                            child: StrongrText(
                              snapshot.data.equipmentList.length <= 1
                                  ? "Équipement associé"
                                  : "Équipements associés",
                              size: 22,
                              bold: true,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[350],
                            thickness: 1,
                            indent: ScreenSize.width(context) / 4,
                            endIndent: ScreenSize.width(context) / 4,
                          ),
                          SizedBox(height: 10),
                          snapshot.data.equipmentList.length == 0
                              ? Center(
                                  child: StrongrText(
                                    "Aucun",
                                    color: Colors.grey,
                                  ),
                                )
                              : SizedBox(),
                          for (final item in snapshot.data.equipmentList)
                            Column(
                              children: <Widget>[
                                // StrongrText(item.id.toString()),
                                StrongrText("• " + item.name),
                                SizedBox(height: 5),
                              ],
                            )
                        ],
                      )
                    : Center(
                        child: StrongrText(
                          "Aucune donnée existante concernant cet exercice",
                          color: Colors.grey,
                        ),
                      ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error, textAlign: TextAlign.center);
            } else
              return Container(
                alignment: Alignment.center,
                height: ScreenSize.height(context) / 1.25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(StrongrColors.blue),
                ),
              );
          },
        ),
      ),
      floatingActionButton: !widget.isBelonged
          ? FloatingActionButton.extended(
              heroTag: 'fab_' + widget.id.toString(),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: StrongrColors.blue,
              onPressed: widget.fromExercises
                  ? () => Navigator.pushNamed(
                        context,
                        EXERCISE_CREATE_ROUTE,
                        arguments: ExerciseCreateView(
                          id: widget.id,
                          name: widget.name,
                        ),
                      )
                  : () => showDialog(
                      context: context,
                      builder: (context) => NewExerciseFromListDialog()),
              label: StrongrText(
                "Ajouter",
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
