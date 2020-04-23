import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/models/muscle.dart';
import 'package:strongr/models/app_exercise.dart';
import 'package:strongr/services/app_exercise_service.dart';
import 'package:strongr/utils/app_exercises_filters.dart';
import 'package:strongr/utils/diacritics.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/new_exercise_from_list_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisesPage extends StatefulWidget {
  final GlobalKey<dynamic> key;
  final int id;
  final String name;

  ExercisesPage({this.key, this.id, this.name});

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  TextEditingController searchbarController;
  Future<List<AppExercise>> futureAppExercisesList;
  bool sortedByAlpha;

  @override
  void initState() {
    searchbarController = TextEditingController(text: "");
    futureAppExercisesList = AppExerciseService.getAppExercises();
    sortedByAlpha = true;
    super.initState();
  }

  // int resultCountOnResearch(dynamic data) {
  //   int result = 0;
  //   for (final item in data) {
  //     if (Diacritics.remove(
  //             data[data.indexOf(item)].name.toString().toLowerCase())
  //         .contains(
  //             Diacritics.remove(searchbarController.text.toLowerCase()))) {
  //       result++;
  //     }
  //   }
  //   return result;
  // }

  String displayMuscleListToString(List muscleList) {
    String result = "";
    for (final item in muscleList) {
      result += item.name;
      if (muscleList.indexOf(item) != muscleList.length - 1) result += ", ";
    }
    return result;
  }

  /// Méthode vérifiant si un [muscleName] est compris dans la [muscleList] d'un exercice
  bool muscleListContains(
      {@required List<Muscle> muscleList, @required String muscleName}) {
    for (final item in muscleList) if (item.name == muscleName) return true;
    return false;
  }

  // static List<Muscle> mList;
  // static List<String> test = AppExercisesFilters.allEnabledFiltersToList();
  // int c = test.length;
  // Column col = Column(
  //   children: <Widget>[
  //     for(final item in mList)
  //       if(true)
  //         Container()
  //       else
  //         SizedBox()
  //   ],
  // );

  int resultCount(List<AppExercise> appExercises) {
    int result = 0;
    for (final appExercise in appExercises)
      if ((searchbarController.text == "" ||
              Diacritics.remove(
                appExercises[appExercises.indexOf(appExercise)]
                    .name
                    .toString()
                    .toLowerCase(),
              ).contains(
                Diacritics.remove(
                  searchbarController.text.toLowerCase(),
                ),
              )) &&
          (AppExercisesFilters.areAllDisabled() ||
              compareMusclesWithFilters(
                appExercise.muscleList,
                AppExercisesFilters.allEnabledFiltersToList(),
              ))) result++;
    return result;
  }

  Widget buildAppExercisesList(List<AppExercise> appExercises) {
    return Column(
      verticalDirection:
          sortedByAlpha ? VerticalDirection.down : VerticalDirection.up,
      children: <Widget>[
        for (final appExercise in appExercises)
          if ((searchbarController.text == "" ||
                  Diacritics.remove(
                    appExercises[appExercises.indexOf(appExercise)]
                        .name
                        .toString()
                        .toLowerCase(),
                  ).contains(
                    Diacritics.remove(
                      searchbarController.text.toLowerCase(),
                    ),
                  )) &&
              (AppExercisesFilters.areAllDisabled() ||
                  compareMusclesWithFilters(
                    appExercise.muscleList,
                    AppExercisesFilters.allEnabledFiltersToList(),
                  )))
            Container(
              padding: EdgeInsets.all(5),
              height: 90,
              child: StrongrRoundedContainer(
                width: ScreenSize.width(context),
                content: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StrongrText(
                            appExercises[appExercises.indexOf(appExercise)]
                                .name,
                            textAlign: TextAlign.start,
                            bold: true,
                          ),
                          StrongrText(
                            displayMuscleListToString(
                                appExercises[appExercises.indexOf(appExercise)]
                                    .muscleList),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 35,
                        height: 35,
                        child: FloatingActionButton(
                          elevation: 0,
                          heroTag: 'fab_' +
                              (appExercises.indexOf(appExercise) + 1)
                                  .toString(),
                          tooltip: "Ajouter",
                          backgroundColor: StrongrColors.blue,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => NewExerciseFromListDialog(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(
                    context,
                    EXERCISE_ROUTE,
                    arguments: ExercisesPage(
                      id: appExercises[appExercises.indexOf(appExercise)].id,
                      name:
                          appExercises[appExercises.indexOf(appExercise)].name,
                    ),
                  );
                },
              ),
            ),
      ],
    );
  }

  /// Compare une liste de muscles avec une liste de filtres, retourne vrai s'il y a au moins une correspondance, faux sinon
  bool compareMusclesWithFilters(List<Muscle> muscles, List<String> filters) {
    for (final muscle in muscles)
      for (final filter in filters) if (muscle.name == filter) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 5),
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 60,
            width: ScreenSize.width(context),
            // color: Colors.blue,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              // color: Colors.grey,
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
                  hintText: "Rechercher un exercice...",
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
            visible: !AppExercisesFilters.areAllDisabled(),
            child: Container(
              padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
              alignment: Alignment.centerLeft,
              child: StrongrText(
                "Filtres : " + AppExercisesFilters.allEnabledFiltersToString(),
                textAlign: TextAlign.start,
                color: Colors.grey,
                size: 16,
              ),
            ),
          ),
          Container(
            height: 25,
            // color: Colors.red,
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
                    width: 55,
                    child: InkWell(
                      onTap: () =>
                          setState(() => sortedByAlpha = !sortedByAlpha),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            sortedByAlpha
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.black87,
                          ),
                          StrongrText(
                            sortedByAlpha ? "A-Z" : "Z-A",
                            color: Colors.black87,
                            size: 14,
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
            future: futureAppExercisesList,
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
                              "Impossible d'afficher les exercices",
                              color: Colors.grey,
                            ),
                          ),
                    // resultCountOnResearch(snapshot.data) != 0
                    resultCount(snapshot.data) != 0
                        ? Container(
                            // child: Column(
                            //   verticalDirection: sortedByAlpha
                            //       ? VerticalDirection.down
                            //       : VerticalDirection.up,
                            //   children: <Widget>[
                            //     for (final item in snapshot.data)
                            //       searchbarController.text == "" ||
                            //               Diacritics.remove(
                            //                 snapshot
                            //                     .data[
                            //                         snapshot.data.indexOf(item)]
                            //                     .name
                            //                     .toString()
                            //                     .toLowerCase(),
                            //               ).contains(
                            //                 Diacritics.remove(
                            //                   searchbarController.text
                            //                       .toLowerCase(),
                            //                 ),
                            //               )
                            //           ? Container(
                            //               padding: EdgeInsets.all(5),
                            //               height: 90,
                            //               child: StrongrRoundedContainer(
                            //                 width: ScreenSize.width(context),
                            //                 content: Stack(
                            //                   children: <Widget>[
                            //                     Container(
                            //                       alignment:
                            //                           Alignment.centerLeft,
                            //                       child: Column(
                            //                         crossAxisAlignment:
                            //                             CrossAxisAlignment
                            //                                 .start,
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceEvenly,
                            //                         children: <Widget>[
                            //                           StrongrText(
                            //                             snapshot
                            //                                 .data[snapshot.data
                            //                                     .indexOf(item)]
                            //                                 .name,
                            //                             textAlign:
                            //                                 TextAlign.start,
                            //                             bold: true,
                            //                           ),
                            //                           StrongrText(
                            //                             displayMuscleListToString(
                            //                                 snapshot
                            //                                     .data[snapshot
                            //                                         .data
                            //                                         .indexOf(
                            //                                             item)]
                            //                                     .muscleList),
                            //                             textAlign:
                            //                                 TextAlign.start,
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                     Container(
                            //                       alignment:
                            //                           Alignment.centerRight,
                            //                       child: Container(
                            //                         width: 35,
                            //                         height: 35,
                            //                         child: FloatingActionButton(
                            //                           elevation: 0,
                            //                           heroTag: 'fab_' +
                            //                               (snapshot.data.indexOf(
                            //                                           item) +
                            //                                       1)
                            //                                   .toString(),
                            //                           tooltip: "Ajouter",
                            //                           backgroundColor:
                            //                               StrongrColors.blue,
                            //                           child: Icon(
                            //                             Icons.add,
                            //                             color: Colors.white,
                            //                           ),
                            //                           onPressed: () =>
                            //                               showDialog(
                            //                             context: context,
                            //                             builder: (context) =>
                            //                                 NewExerciseFromListDialog(),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 onPressed: () {
                            //                   FocusScope.of(context).unfocus();
                            //                   Navigator.pushNamed(
                            //                     context,
                            //                     EXERCISE_ROUTE,
                            //                     arguments: ExercisesPage(
                            //                       id: snapshot
                            //                           .data[snapshot.data
                            //                               .indexOf(item)]
                            //                           .id,
                            //                       name: snapshot
                            //                           .data[snapshot.data
                            //                               .indexOf(item)]
                            //                           .name,
                            //                     ),
                            //                   );
                            //                 },
                            //               ),
                            //             )
                            //           : SizedBox(),
                            //   ],
                            // ),
                            child: buildAppExercisesList(snapshot.data),
                          )
                        : Container(
                            height: ScreenSize.height(context) / 1.75,
                            child: Center(
                              child: StrongrText(
                                "Aucun résultat trouvé",
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error, textAlign: TextAlign.center);
              } else
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
    );
  }

  void refresh() {
    setState(() {});
  }
}
