import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/services/exercise_service.dart';
import 'package:strongr/utils/app_exercises_filters.dart';
import 'package:strongr/utils/diacritics.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/filters_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

import 'exercise_view.dart';

class ExercisesView extends StatefulWidget {
  final GlobalKey<dynamic> key;
  final int id;
  final String name;
  final bool fromSessionCreation;

  ExercisesView(
      {this.key, this.id, this.name, this.fromSessionCreation = false});

  @override
  _ExercisesViewState createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController searchbarController;
  Future<List<ExercisePreview>> futureExercises;
  bool sortedByRecent, needToRefresh;
  // List<String> popupMenuItems;

  @override
  void initState() {
    searchbarController = TextEditingController(text: "");
    futureExercises = ExerciseService.getExercises();
    sortedByRecent = true;
    needToRefresh = false;
    // popupMenuItems = ["Filtres", "Créer"];
    super.initState();
  }

  /// Retourne le nombre de résultats d'une liste d'[exercises] après recherche et filtres.
  int resultCount(List<ExercisePreview> exercises) {
    int result = 0;
    for (final appExercise in exercises)
      if ((searchbarController.text == "" ||
              Diacritics.remove(
                exercises[exercises.indexOf(appExercise)]
                    .name
                    .toString()
                    .toLowerCase(),
              ).contains(
                Diacritics.remove(
                  searchbarController.text.toLowerCase(),
                ),
              ))
          //     &&
          // (AppExercisesFilters.areAllDisabled() ||
          //     compareMusclesWithFilters(
          //       appExercise.muscleList,
          //       AppExercisesFilters.allEnabledFiltersToList(),
          //     ))
          ) result++;
    return result;
  }

  /// Affiche une liste d'[exercises].
  Widget buildExercisesList(List<ExercisePreview> exercises) {
    return Column(
      verticalDirection:
          sortedByRecent ? VerticalDirection.down : VerticalDirection.up,
      children: <Widget>[
        for (final item in exercises)
          if ((searchbarController.text == "" ||
              Diacritics.remove(
                exercises[exercises.indexOf(item)]
                    .name
                    .toString()
                    .toLowerCase(),
              ).contains(
                Diacritics.remove(
                  searchbarController.text.toLowerCase(),
                ),
              ))
          //     &&
          // (AppExercisesFilters.areAllDisabled() ||
          //     compareMusclesWithFilters(
          //       appExercise.muscleList,
          //       AppExercisesFilters.allEnabledFiltersToList(),
          //     ))
          )
            Container(
              padding: EdgeInsets.all(5),
              height: 140,
              child: StrongrRoundedContainer(
                width: ScreenSize.width(context),
                content: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: StrongrText(
                              item.name,
                              bold: true,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.fitness_center,
                                  color: item.appExerciseName != null
                                      ? StrongrColors.black
                                      : Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: StrongrText(
                                    item.appExerciseName != null
                                        ? item.appExerciseName
                                        : "Aucun exercice",
                                    color: item.appExerciseName != null
                                        ? StrongrColors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.refresh,
                                  color: int.parse(item.setCount) > 0 ||
                                          int.parse(item.setCount) != null
                                      ? StrongrColors.black
                                      : Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: StrongrText(
                                    int.parse(item.setCount) > 0 ||
                                            int.parse(item.setCount) != null
                                        ? int.parse(item.setCount) <= 1
                                            ? item.setCount + " série"
                                            : item.setCount + " séries"
                                        : "Aucune série",
                                    color: int.parse(item.setCount) > 0 ||
                                            int.parse(item.setCount) != null
                                        ? StrongrColors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.show_chart,
                                  color: item.tonnage != null
                                      ? StrongrColors.black
                                      : Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: StrongrText(
                                    item.tonnage != null
                                        ? "Tonnage de " +
                                            item.tonnage.toString() +
                                            "kg"
                                        : "Tonnage non calculé",
                                    color: item.tonnage != null
                                        ? StrongrColors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.black12,
                      padding: EdgeInsets.all(10),
                      alignment: !widget.fromSessionCreation
                          ? Alignment.bottomRight
                          : Alignment.centerRight,
                      child: !widget.fromSessionCreation
                          ? Container(
                              // color: Colors.red,
                              width: 35,
                              height: 35,
                              child: FloatingActionButton(
                                elevation: 0,
                                heroTag:
                                    'exercise_play_fab_' + item.id.toString(),
                                tooltip: "Démarrer",
                                backgroundColor: StrongrColors.blue,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            )
                          : Container(
                              // color: Colors.red,
                              width: 35,
                              height: 35,
                              child: RawMaterialButton(
                                shape: CircleBorder(),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    EXERCISE_ROUTE,
                                    arguments: ExerciseView(
                                      id: item.id.toString(),
                                      name: item.name,
                                      appExerciseName: item.appExerciseName,
                                      fromSessionAddExercise: true,
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.info_outline,
                                  color: StrongrColors.blue,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                onPressed: () {
                  !widget.fromSessionCreation
                      ? Navigator.pushNamed(
                          context,
                          EXERCISE_ROUTE,
                          arguments: ExerciseView(
                            id: item.id.toString(),
                            name: item.name,
                            appExerciseName: item.appExerciseName,
                          ),
                        )
                      : Navigator.pop(
                          context,
                          ExercisePreview(
                            id: item.id,
                            name: item.name,
                            appExerciseName: item.appExerciseName,
                            setCount: item.setCount,
                            tonnage: item.tonnage,
                          ),
                        );
                },
              ),
            ),
      ],
    );
  }

  /// Actualise la liste des exercices.
  void refreshExercises() async {
    setState(() {
      futureExercises = ExerciseService.getExercises();
      needToRefresh = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: globalKey,
        resizeToAvoidBottomPadding: false,
        appBar: !widget.fromSessionCreation
            ? AppBar(
                centerTitle: true,
                leading: BackButton(
                  onPressed: () => Navigator.pop(context, needToRefresh),
                ),
                title: Text("Vos exerices"),
                actions: <Widget>[
                  // PopupMenuButton<String>(
                  //   tooltip: "Menu",
                  //   onSelected: (value) async {
                  //     switch (value) {
                  //       case "Filtres":
                  //         break;
                  //       case "Créer":
                  //         await Navigator.pushNamed(
                  //           context,
                  //           EXERCISE_ADD_ROUTE,
                  //         ).then((val) {
                  //           if (val == true) {
                  //             setState(() {});
                  //           }
                  //         });
                  //         break;
                  //     }
                  //   },
                  //   itemBuilder: (BuildContext context) {
                  //     return popupMenuItems.map(
                  //       (String choice) {
                  //         return PopupMenuItem<String>(
                  //           value: choice,
                  //           child: Text(choice),
                  //         );
                  //       },
                  //     ).toList();
                  //   },
                  // ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      await Navigator.pushNamed(
                        context,
                        EXERCISE_ADD_ROUTE,
                      ).then(
                        (exerciseCreated) {
                          if (exerciseCreated) {
                            refreshExercises();
                            globalKey.currentState.showSnackBar(
                              SnackBar(
                                content: Container(
                                  height: 35,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: StrongrText(
                                          "Exercice créé avec succès",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor: StrongrColors.blue80,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              )
            : null,
        body: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 5),
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 60,
                width: ScreenSize.width(context),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  child: TextField(
                    controller: searchbarController,
                    style: TextStyle(
                        color: StrongrColors.black,
                        fontFamily: 'Futura',
                        fontSize: 18),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    onChanged: (newValue) => setState(() {}),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search, color: StrongrColors.blue),
                      hintText: "Rechercher votre exercice...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(color: StrongrColors.blue, width: 1.5),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !AppExercisesFilters.areAllDisabled() &&
                    AppExercisesFilters.atLeastOneDisabled(),
                child: Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await showDialog(
                        context: context,
                        builder: (context) => FiltersDialog(),
                      );
                      // .then((val) {
                      //   if (val == true) refresh();
                      // });
                    },
                    child: StrongrText(
                      !AppExercisesFilters.filterMode
                          ? AppExercisesFilters.allEnabledFiltersToList()
                                      .length ==
                                  1
                              ? "Filtre : " +
                                  AppExercisesFilters
                                      .allEnabledFiltersToString()
                              : "Filtres : " +
                                  AppExercisesFilters
                                      .allEnabledFiltersToString()
                          : "Filtres : Tout sauf " +
                              AppExercisesFilters.allDisabledFiltersToString(),
                      textAlign: TextAlign.start,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
              ),
              Container(
                height: 25,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Divider(
                        color: Colors.grey[350],
                        height: 0,
                        thickness: 1,
                        indent: ScreenSize.width(context) / 4,
                        endIndent: ScreenSize.width(context) / 4,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 25),
                        width: 70,
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () =>
                              setState(() => sortedByRecent = !sortedByRecent),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                sortedByRecent
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.black87,
                              ),
                              Container(
                                // color: Colors.red,
                                child: StrongrText(
                                  sortedByRecent ? "Récent" : "Ancien",
                                  color: Colors.black87,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: futureExercises,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        snapshot.data.length != 0
                            ? SizedBox()
                            : Container(
                                alignment: Alignment.center,
                                height: ScreenSize.height(context) / 1.75,
                                child: StrongrText(
                                  "Aucun exercice à afficher",
                                  color: Colors.grey,
                                ),
                              ),
                        resultCount(snapshot.data) != 0 ||
                                snapshot.data.length == 0
                            ? Container(
                                child: buildExercisesList(snapshot.data),
                              )
                            : Container(
                                height: ScreenSize.height(context) / 1.75,
                                child: Center(
                                  child: StrongrText(
                                    "Aucun exercice trouvé",
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ],
                    );
                  } else if (snapshot.hasError)
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
            ],
          ),
        ),
      ),
    );
  }
}
