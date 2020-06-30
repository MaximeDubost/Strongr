import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/AppExercise.dart';
import 'package:strongr/services/AppExerciseService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/equipment/equipment_view.dart';
import 'package:strongr/views/exercise/exercise_create_view.dart';
import 'package:strongr/views/muscle/muscle_view.dart';
import 'package:strongr/widgets/dialogs/new_exercise_from_list_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class AppExerciseView extends StatefulWidget {
  final int id;
  final String name;
  final bool isBelonged;
  final bool fromExercises;
  final int selectedEquipmentId;

  AppExerciseView({
    this.id,
    this.name,
    this.isBelonged = false,
    this.fromExercises = false,
    this.selectedEquipmentId,
  });

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
        padding: EdgeInsets.only(left: 5, right: 5),
        child: FutureBuilder(
          future: futureAppExercise,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: snapshot.data.id != null
                    ? ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8),
                            child: StrongrText(
                              snapshot.data.muscleList.length == 1
                                  ? "Zone ciblée"
                                  : "Zones ciblées",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          snapshot.data.muscleList.length == 0
                              ? Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: StrongrText(
                                      "Aucun élément à afficher",
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          for (final item in snapshot.data.muscleList)
                            Column(
                              children: <Widget>[
                                StrongrRoundedContainer(
                                  width: ScreenSize.width(context),
                                  content: Container(
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: StrongrText(
                                              item.name,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 35,
                                          child: Icon(
                                            Icons.info_outline,
                                            color: StrongrColors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    MUSCLE_ROUTE,
                                    arguments: MuscleView(
                                      id: item.id,
                                      name: item.name,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: StrongrText(
                              snapshot.data.equipmentList.length == 1
                                  ? "Équipement associé"
                                  : "Équipements associés",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          snapshot.data.equipmentList.length == 0
                              ? Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: StrongrText(
                                      "Aucun équipement",
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          for (final item in snapshot.data.equipmentList)
                            Column(
                              children: <Widget>[
                                StrongrRoundedContainer(
                                  width: ScreenSize.width(context),
                                  content: Container(
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: StrongrText(
                                              item.name,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 35,
                                          child: Icon(
                                            Icons.info_outline,
                                            color: StrongrColors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  borderColor:
                                      widget.selectedEquipmentId == item.id
                                          ? StrongrColors.blue80
                                          : StrongrColors.greyD,
                                  borderWidth:
                                      widget.selectedEquipmentId == item.id
                                          ? 2
                                          : 1,
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    EQUIPMENT_ROUTE,
                                    arguments: EquipmentView(
                                      id: item.id,
                                      name: item.name,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          SizedBox(height: 75),
                        ],
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: StrongrText(
                            "Aucune donnée existante concernant cet exercice",
                            color: Colors.grey,
                          ),
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
                        builder: (context) => NewExerciseFromListDialog(
                          id: widget.id,
                          name: widget.name,
                        ),
                      ),
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
