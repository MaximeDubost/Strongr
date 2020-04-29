import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisesView extends StatefulWidget {
  @override
  _ExercisesViewState createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  TextEditingController searchbarController;
  // Future<List<AppExercise>> futureAppExercisesList;
  bool sortedByAlpha;

  @override
  void initState() {
    searchbarController = TextEditingController(text: "");
    // futureAppExercisesList = AppExerciseService.getAppExercises();
    sortedByAlpha = true;
    super.initState();
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
              itemBuilder: (context) {
                return [];
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
            ],
          ),
        ),
      ),
    );
  }
}
