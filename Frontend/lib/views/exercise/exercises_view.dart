import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/services/exercise_service.dart';
import 'package:strongr/utils/diacritics.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisesView extends StatefulWidget {
  @override
  _ExercisesViewState createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  List<String> popupMenuItems;
  TextEditingController searchbarController;
  Future<List<Exercise>> futureExercises;
  bool sortedByAlpha;

  @override
  void initState() {
    popupMenuItems = ["Filtres", "Créer"];
    searchbarController = TextEditingController(text: "");
    futureExercises = ExerciseService.getExercises();
    sortedByAlpha = true;
    super.initState();
  }

  /// Retourne le nombre de résultats d'une liste d'[appExercises] après recherche et filtres.
  int resultCount(List<Exercise> exercises) {
    int result = 0;
    for (final exercise in exercises)
      if 
      (
        (
          searchbarController.text == "" ||
          Diacritics.remove
          (
            exercises[exercises.indexOf(exercise)]
                .name
                .toString()
                .toLowerCase(),
          ).contains(
            Diacritics.remove(
              searchbarController.text.toLowerCase(),
            ),
          )
        ) 
        // &&
        // (
        //   AppExercisesFilters.areAllDisabled() ||
        //       compareMusclesWithFilters(
        //         exercise.muscleList,
        //         AppExercisesFilters.allEnabledFiltersToList(),
        //       )
        // )
      ) 
      result++;
    return result;
  }

  /// Affiche une liste d'[exercises].
  Widget buildAppExercisesList(List<Exercise> exercises) {
    return Column(
      verticalDirection:
          sortedByAlpha ? VerticalDirection.down : VerticalDirection.up,
      children: <Widget>[
        for (final exercise in exercises)
          if ((searchbarController.text == "" ||
                  Diacritics.remove(
                    exercises[exercises.indexOf(exercise)]
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
              //       exercise.muscleList,
              //       AppExercisesFilters.allEnabledFiltersToList(),
              //     ))
                  )
            Container(
              padding: EdgeInsets.all(5),
              height: 180,
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
                            exercises[exercises.indexOf(exercise)]
                                .name,
                            textAlign: TextAlign.start,
                            bold: true,
                          ),
                          StrongrText(
                            // displayMuscleListToString(
                            //     exercises[exercises.indexOf(exercise)]
                            //         .muscleList),
                            "DEBUG",
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
                              (exercises.indexOf(exercise) + 1)
                                  .toString(),
                          tooltip: "Ajouter",
                          backgroundColor: StrongrColors.blue,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          // onPressed: () => showDialog(
                          //   context: context,
                          //   builder: (context) => NewExerciseFromListDialog(),
                          // ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // FocusScope.of(context).unfocus();
                  // Navigator.pushNamed(
                  //   context,
                  //   APP_EXERCISE_ROUTE,
                  //   arguments: AppExercisesPage(
                  //     id: appExercises[appExercises.indexOf(appExercise)].id,
                  //     name:
                  //         appExercises[appExercises.indexOf(appExercise)].name,
                  //   ),
                  // );
                },
              ),
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(),
          title: Text("Vos exerices"),
          actions: <Widget>[
            PopupMenuButton<String>(
              tooltip: "Menu",
              onSelected: (value) async {
                switch (value) {
                  case "Filtres":
                    break;
                  case "Créer":
                    await Navigator.pushNamed(
                      context,
                      EXERCISE_ADD_ROUTE,
                    ).then((val) {
                      if (val == true) {
                        setState(() {});
                      }
                    });
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return popupMenuItems.map(
                  (String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  },
                ).toList();
              },
            ),
          ],
        ),
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
              // Visibility(
              //   visible: !AppExercisesFilters.areAllDisabled() &&
              //       AppExercisesFilters.atLeastOneDisabled(),
              //   child: Container(
              //     padding:
              //         EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
              //     alignment: Alignment.centerLeft,
              //     child: InkWell(
              //       onTap: () async {
              //         FocusScope.of(context).unfocus();
              //         await showDialog(
              //           context: context,
              //           builder: (context) => FiltersDialog(),
              //         ).then((val) {
              //           if (val == true) refresh();
              //         });
              //       },
              //       child: StrongrText(
              //         !AppExercisesFilters.filterMode
              //             ? AppExercisesFilters.allEnabledFiltersToList()
              //                         .length ==
              //                     1
              //                 ? "Filtre : " +
              //                     AppExercisesFilters
              //                         .allEnabledFiltersToString()
              //                 : "Filtres : " +
              //                     AppExercisesFilters
              //                         .allEnabledFiltersToString()
              //             : "Filtres : Tout sauf " +
              //                 AppExercisesFilters.allDisabledFiltersToString(),
              //         textAlign: TextAlign.start,
              //         color: Colors.grey,
              //         size: 16,
              //       ),
              //     ),
              //   ),
              // ),
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
                                  "Aucun élément à afficher",
                                  color: Colors.grey,
                                ),
                              ),
                        resultCount(snapshot.data) != 0
                            ? Container(
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
        ),
      ),
    );
  }
}
