import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/utils/app_exercises_filters.dart';
import '../strongr_text.dart';

class FiltersDialog extends StatefulWidget {
  @override
  _FiltersDialogState createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  bool switchValue,
      muscleCheckboxValue1,
      muscleCheckboxValue2,
      muscleCheckboxValue3,
      muscleCheckboxValue4,
      muscleCheckboxValue5,
      muscleCheckboxValue6,
      muscleCheckboxValue7,
      muscleCheckboxValue8,
      muscleCheckboxValue9,
      muscleCheckboxValue10;

  @override
  void initState() {
    switchValue = AppExercisesFilters.filterMode;
    muscleCheckboxValue1 = !switchValue
        ? AppExercisesFilters.abs
        : AppExercisesFilters.abs ? false : null;
    muscleCheckboxValue2 = !switchValue
        ? AppExercisesFilters.forearms
        : AppExercisesFilters.forearms ? false : null;
    muscleCheckboxValue3 = !switchValue
        ? AppExercisesFilters.biceps
        : AppExercisesFilters.biceps ? false : null;
    muscleCheckboxValue4 = !switchValue
        ? AppExercisesFilters.back
        : AppExercisesFilters.back ? false : null;
    muscleCheckboxValue5 = !switchValue
        ? AppExercisesFilters.shoulders
        : AppExercisesFilters.shoulders ? false : null;
    muscleCheckboxValue6 = !switchValue
        ? AppExercisesFilters.hamstrings
        : AppExercisesFilters.hamstrings ? false : null;
    muscleCheckboxValue7 = !switchValue
        ? AppExercisesFilters.calves
        : AppExercisesFilters.calves ? false : null;
    muscleCheckboxValue8 = !switchValue
        ? AppExercisesFilters.pectorals
        : AppExercisesFilters.pectorals ? false : null;
    muscleCheckboxValue9 = !switchValue
        ? AppExercisesFilters.quadriceps
        : AppExercisesFilters.quadriceps ? false : null;
    muscleCheckboxValue10 = !switchValue
        ? AppExercisesFilters.triceps
        : AppExercisesFilters.triceps ? false : null;
    super.initState();
  }

  /// Vérifie si une Checkbox est cochée et change sa valeur en fonction de la valeur du Switch.
  void filterModeChange() {
    if (switchCheckboxValue(muscleCheckboxValue1) != false)
      setState(() =>
          muscleCheckboxValue1 = switchCheckboxValue(muscleCheckboxValue1));
    if (switchCheckboxValue(muscleCheckboxValue2) != false)
      setState(() =>
          muscleCheckboxValue2 = switchCheckboxValue(muscleCheckboxValue2));
    if (switchCheckboxValue(muscleCheckboxValue3) != false)
      setState(() =>
          muscleCheckboxValue3 = switchCheckboxValue(muscleCheckboxValue3));
    if (switchCheckboxValue(muscleCheckboxValue4) != false)
      setState(() =>
          muscleCheckboxValue4 = switchCheckboxValue(muscleCheckboxValue4));
    if (switchCheckboxValue(muscleCheckboxValue5) != false)
      setState(() =>
          muscleCheckboxValue5 = switchCheckboxValue(muscleCheckboxValue5));
    if (switchCheckboxValue(muscleCheckboxValue6) != false)
      setState(() =>
          muscleCheckboxValue6 = switchCheckboxValue(muscleCheckboxValue6));
    if (switchCheckboxValue(muscleCheckboxValue7) != false)
      setState(() =>
          muscleCheckboxValue7 = switchCheckboxValue(muscleCheckboxValue7));
    if (switchCheckboxValue(muscleCheckboxValue8) != false)
      setState(() =>
          muscleCheckboxValue8 = switchCheckboxValue(muscleCheckboxValue8));
    if (switchCheckboxValue(muscleCheckboxValue9) != false)
      setState(() =>
          muscleCheckboxValue9 = switchCheckboxValue(muscleCheckboxValue9));
    if (switchCheckboxValue(muscleCheckboxValue10) != false)
      setState(() =>
          muscleCheckboxValue10 = switchCheckboxValue(muscleCheckboxValue10));
  }

  /// Vérifie si toutes les Checkboxes sont cochées.
  bool areAllChecked() {
    if (switchCheckboxValue(muscleCheckboxValue1) == false ||
        switchCheckboxValue(muscleCheckboxValue2) == false ||
        switchCheckboxValue(muscleCheckboxValue3) == false ||
        switchCheckboxValue(muscleCheckboxValue4) == false ||
        switchCheckboxValue(muscleCheckboxValue5) == false ||
        switchCheckboxValue(muscleCheckboxValue6) == false ||
        switchCheckboxValue(muscleCheckboxValue7) == false ||
        switchCheckboxValue(muscleCheckboxValue8) == false ||
        switchCheckboxValue(muscleCheckboxValue9) == false ||
        switchCheckboxValue(muscleCheckboxValue10) == false) return false;
    return true;
  }

  /// Vérifie si toutes les Checkboxes sont décochées.
  bool areAllUnchecked() {
    if (switchCheckboxValue(muscleCheckboxValue1) != false ||
        switchCheckboxValue(muscleCheckboxValue2) != false ||
        switchCheckboxValue(muscleCheckboxValue3) != false ||
        switchCheckboxValue(muscleCheckboxValue4) != false ||
        switchCheckboxValue(muscleCheckboxValue5) != false ||
        switchCheckboxValue(muscleCheckboxValue6) != false ||
        switchCheckboxValue(muscleCheckboxValue7) != false ||
        switchCheckboxValue(muscleCheckboxValue8) != false ||
        switchCheckboxValue(muscleCheckboxValue9) != false ||
        switchCheckboxValue(muscleCheckboxValue10) != false) return false;
    return true;
  }

  /// Coche toutes les Checkboxes en fonction de la valeur du Switch.
  void checkAll() {
    if (!switchValue)
      setState(() {
        muscleCheckboxValue1 = muscleCheckboxValue2 = muscleCheckboxValue3 =
            muscleCheckboxValue4 = muscleCheckboxValue5 = muscleCheckboxValue6 =
                muscleCheckboxValue7 = muscleCheckboxValue8 =
                    muscleCheckboxValue9 = muscleCheckboxValue10 = true;
      });
    else
      setState(() {
        muscleCheckboxValue1 = muscleCheckboxValue2 = muscleCheckboxValue3 =
            muscleCheckboxValue4 = muscleCheckboxValue5 = muscleCheckboxValue6 =
                muscleCheckboxValue7 = muscleCheckboxValue8 =
                    muscleCheckboxValue9 = muscleCheckboxValue10 = null;
      });
  }

  /// Décoche toutes les cases.
  void uncheckAll() {
    setState(() {
      muscleCheckboxValue1 = muscleCheckboxValue2 = muscleCheckboxValue3 =
          muscleCheckboxValue4 = muscleCheckboxValue5 = muscleCheckboxValue6 =
              muscleCheckboxValue7 = muscleCheckboxValue8 =
                  muscleCheckboxValue9 = muscleCheckboxValue10 = false;
    });
  }

  /// Détermine la valeur d'un Checkbox [checkboxValueToChange] en fonction de la valeur du Switch
  bool switchCheckboxValue(bool checkboxValueToChange) {
    if (checkboxValueToChange == true || checkboxValueToChange == null) {
      if (switchValue == false)
        return true;
      else
        return null;
    }
    return false;
  }

  /// Détermine la valeur à attribuer à un Checkbox [checkboxValueToChange] en fonction de la valeur du Switch
  bool changeCheckboxValue(bool checkboxValueToChange) {
    if (checkboxValueToChange == true || checkboxValueToChange == null)
      return false;
    else {
      if (switchValue == false)
        return true;
      else
        return null;
    }
  }

  /// Applique les filtres.
  void applyAllFilters() {
    AppExercisesFilters.filterMode = switchValue;
    if (!switchValue) {
      AppExercisesFilters.abs = muscleCheckboxValue1;
      AppExercisesFilters.forearms = muscleCheckboxValue2;
      AppExercisesFilters.biceps = muscleCheckboxValue3;
      AppExercisesFilters.back = muscleCheckboxValue4;
      AppExercisesFilters.shoulders = muscleCheckboxValue5;
      AppExercisesFilters.hamstrings = muscleCheckboxValue6;
      AppExercisesFilters.calves = muscleCheckboxValue7;
      AppExercisesFilters.pectorals = muscleCheckboxValue8;
      AppExercisesFilters.quadriceps = muscleCheckboxValue9;
      AppExercisesFilters.triceps = muscleCheckboxValue10;
    } else {
      AppExercisesFilters.abs = muscleCheckboxValue1 == false ? true : false;
      AppExercisesFilters.forearms =
          muscleCheckboxValue2 == false ? true : false;
      AppExercisesFilters.biceps = muscleCheckboxValue3 == false ? true : false;
      AppExercisesFilters.back = muscleCheckboxValue4 == false ? true : false;
      AppExercisesFilters.shoulders =
          muscleCheckboxValue5 == false ? true : false;
      AppExercisesFilters.hamstrings =
          muscleCheckboxValue6 == false ? true : false;
      AppExercisesFilters.calves = muscleCheckboxValue7 == false ? true : false;
      AppExercisesFilters.pectorals =
          muscleCheckboxValue8 == false ? true : false;
      AppExercisesFilters.quadriceps =
          muscleCheckboxValue9 == false ? true : false;
      AppExercisesFilters.triceps =
          muscleCheckboxValue10 == false ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
        height: 400,
        width: ScreenSize.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if (!areAllChecked()) checkAll();
                  },
                  enableFeedback: !areAllChecked(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.select_all,
                    color: !areAllChecked() ? StrongrColors.black : Colors.grey,
                  ),
                ),
                StrongrText(
                  "Filtres",
                  bold: true,
                  size: 20,
                ),
                InkWell(
                  onTap: () {
                    if (!areAllUnchecked()) uncheckAll();
                  },
                  enableFeedback: !areAllUnchecked(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.delete_outline,
                    color:
                        !areAllUnchecked() ? StrongrColors.black : Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    if (switchValue) {
                      setState(() => switchValue = !switchValue);
                      filterModeChange();
                    }
                  },
                  child: StrongrText(
                    "Inclure",
                    size: 18,
                    color: !switchValue ? StrongrColors.blue : Colors.grey,
                  ),
                ),
                Switch(
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: StrongrColors.blue,
                  activeTrackColor: Colors.grey,
                  activeColor: Colors.red[800],
                  value: switchValue,
                  onChanged: (newValue) {
                    setState(() => switchValue = newValue);
                    filterModeChange();
                  },
                ),
                FlatButton(
                  onPressed: () {
                    if (!switchValue) {
                      setState(() => switchValue = !switchValue);
                      filterModeChange();
                    }
                  },
                  child: StrongrText(
                    "Exclure",
                    size: 18,
                    color: switchValue ? Colors.red[800] : Colors.grey,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            Table(
              defaultColumnWidth: FractionColumnWidth(0.55),
              children: [
                TableRow(
                  children: [
                    buildCheckbox(
                      "Abdominaux",
                      value: muscleCheckboxValue1,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue1 =
                              changeCheckboxValue(muscleCheckboxValue1)),
                      onTap: () => setState(() => muscleCheckboxValue1 =
                          changeCheckboxValue(muscleCheckboxValue1)),
                    ),
                    buildCheckbox(
                      "Avant-bras",
                      value: muscleCheckboxValue2,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue2 =
                              changeCheckboxValue(muscleCheckboxValue2)),
                      onTap: () => setState(() => muscleCheckboxValue2 =
                          changeCheckboxValue(muscleCheckboxValue2)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Biceps",
                      value: muscleCheckboxValue3,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue3 =
                              changeCheckboxValue(muscleCheckboxValue3)),
                      onTap: () => setState(() => muscleCheckboxValue3 =
                          changeCheckboxValue(muscleCheckboxValue3)),
                    ),
                    buildCheckbox(
                      "Dos",
                      value: muscleCheckboxValue4,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue4 =
                              changeCheckboxValue(muscleCheckboxValue4)),
                      onTap: () => setState(() => muscleCheckboxValue4 =
                          changeCheckboxValue(muscleCheckboxValue4)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Épaules",
                      value: muscleCheckboxValue5,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue5 =
                              changeCheckboxValue(muscleCheckboxValue5)),
                      onTap: () => setState(() => muscleCheckboxValue5 =
                          changeCheckboxValue(muscleCheckboxValue5)),
                    ),
                    buildCheckbox(
                      "Ischios",
                      value: muscleCheckboxValue6,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue6 =
                              changeCheckboxValue(muscleCheckboxValue6)),
                      onTap: () => setState(() => muscleCheckboxValue6 =
                          changeCheckboxValue(muscleCheckboxValue6)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Mollets",
                      value: muscleCheckboxValue7,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue7 =
                              changeCheckboxValue(muscleCheckboxValue7)),
                      onTap: () => setState(() => muscleCheckboxValue7 =
                          changeCheckboxValue(muscleCheckboxValue7)),
                    ),
                    buildCheckbox(
                      "Pectoraux",
                      value: muscleCheckboxValue8,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue8 =
                              changeCheckboxValue(muscleCheckboxValue8)),
                      onTap: () => setState(() => muscleCheckboxValue8 =
                          changeCheckboxValue(muscleCheckboxValue8)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Quadriceps",
                      value: muscleCheckboxValue9,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue9 =
                              changeCheckboxValue(muscleCheckboxValue9)),
                      onTap: () => setState(() => muscleCheckboxValue9 =
                          changeCheckboxValue(muscleCheckboxValue9)),
                    ),
                    buildCheckbox(
                      "Triceps",
                      value: muscleCheckboxValue10,
                      onChanged: (bool newValue) => setState(() =>
                          muscleCheckboxValue10 =
                              changeCheckboxValue(muscleCheckboxValue10)),
                      onTap: () => setState(() => muscleCheckboxValue10 =
                          changeCheckboxValue(muscleCheckboxValue10)),
                    ),
                  ],
                ),
              ],
            ),
            Divider(thickness: 1),
            StrongrRaisedButton("Filtrer",
                color: StrongrColors.blue,
                onPressed: areAllChecked()
                    ? null
                    : () {
                        applyAllFilters();
                        Navigator.pop(context, true);
                      }),
          ],
        ),
      ),
    );
  }

  /// Retourne une Row avec un texte [content] et un Radio
  /// avec les attributs [value], [onChanged], [onTap] & [groupeValue].
  Row buildRadio(
    String content, {
    @required int value,
    @required Function onChanged,
    @required Function onTap,
    @required int groupeValue,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 30,
          width: 20,
          child: Radio(
            activeColor: StrongrColors.blue,
            value: value,
            onChanged: onChanged,
            groupValue: groupeValue,
          ),
        ),
        Container(
          height: 30,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Center(
                child: StrongrText(
                  content,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Retourne une Row avec un texte [content] et un Checkbox
  /// avec les attributs [value], [onChanged] & [onTap].
  Row buildCheckbox(
    String content, {
    @required bool value,
    @required Function onChanged,
    @required Function onTap,
  }) {
    return Row(
      children: <Widget>[
        Container(
          width: 30,
          height: 40,
          child: Checkbox(
            tristate: true,
            activeColor: value != null ? StrongrColors.blue : Colors.red[800],
            value: value,
            onChanged: onChanged,
          ),
        ),
        Flexible(
          child: Container(
            height: 30,
            child: InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: StrongrText(
                  content,
                  size: 16,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Column buildSortByPart() {
  //   return Column(
  //     children: <Widget>[
  //       StrongrText(
  //         "Trier par",
  //         bold: true,
  //         size: 20,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           buildRadio(
  //             "A-Z",
  //             value: 1,
  //             groupeValue: groupValue,
  //             onChanged: (int newValue) => setState(
  //               () => groupValue = newValue,
  //             ),
  //             onTap: () {
  //               if (groupValue != 1) setState(() => groupValue = 1);
  //             },
  //           ),
  //           buildRadio(
  //             "Z-A",
  //             value: 2,
  //             groupeValue: groupValue,
  //             onChanged: (int newValue) => setState(
  //               () => groupValue = newValue,
  //             ),
  //             onTap: () {
  //               if (groupValue != 2) setState(() => groupValue = 2);
  //             },
  //           ),
  //         ],
  //       ),
  //       Divider(thickness: 1),
  //     ],
  //   );
  // }

}
