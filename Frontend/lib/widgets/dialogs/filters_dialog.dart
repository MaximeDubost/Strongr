import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
import '../strongr_text.dart';

class FiltersDialog extends StatefulWidget {
  final int groupValue;
  final bool switchValue;
  final bool muscleCheckboxValue1;
  final bool muscleCheckboxValue2;
  final bool muscleCheckboxValue3;
  final bool muscleCheckboxValue4;
  final bool muscleCheckboxValue5;
  final bool muscleCheckboxValue6;
  final bool muscleCheckboxValue7;
  final bool muscleCheckboxValue8;
  final bool muscleCheckboxValue9;
  final bool muscleCheckboxValue10;

  FiltersDialog({
    this.groupValue,
    this.switchValue,
    this.muscleCheckboxValue1,
    this.muscleCheckboxValue2,
    this.muscleCheckboxValue3,
    this.muscleCheckboxValue4,
    this.muscleCheckboxValue5,
    this.muscleCheckboxValue6,
    this.muscleCheckboxValue7,
    this.muscleCheckboxValue8,
    this.muscleCheckboxValue9,
    this.muscleCheckboxValue10,
  });

  @override
  _FiltersDialogState createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  int groupValue;
  bool switchValue;
  bool muscleCheckboxValue1;
  bool muscleCheckboxValue2;
  bool muscleCheckboxValue3;
  bool muscleCheckboxValue4;
  bool muscleCheckboxValue5;
  bool muscleCheckboxValue6;
  bool muscleCheckboxValue7;
  bool muscleCheckboxValue8;
  bool muscleCheckboxValue9;
  bool muscleCheckboxValue10;

  @override
  void initState() {
    groupValue = 1;
    switchValue = false;
    muscleCheckboxValue1 = false;
    muscleCheckboxValue2 = false;
    muscleCheckboxValue3 = false;
    muscleCheckboxValue4 = false;
    muscleCheckboxValue5 = false;
    muscleCheckboxValue6 = false;
    muscleCheckboxValue7 = false;
    muscleCheckboxValue8 = false;
    muscleCheckboxValue9 = false;
    muscleCheckboxValue10 = false;
    super.initState();
  }

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

  void checkAll() {
    if (!switchValue)
      setState(() {
        muscleCheckboxValue1 = true;
        muscleCheckboxValue2 = true;
        muscleCheckboxValue3 = true;
        muscleCheckboxValue4 = true;
        muscleCheckboxValue5 = true;
        muscleCheckboxValue6 = true;
        muscleCheckboxValue7 = true;
        muscleCheckboxValue8 = true;
        muscleCheckboxValue9 = true;
        muscleCheckboxValue10 = true;
      });
    else
      setState(() {
        muscleCheckboxValue1 = null;
        muscleCheckboxValue2 = null;
        muscleCheckboxValue3 = null;
        muscleCheckboxValue4 = null;
        muscleCheckboxValue5 = null;
        muscleCheckboxValue6 = null;
        muscleCheckboxValue7 = null;
        muscleCheckboxValue8 = null;
        muscleCheckboxValue9 = null;
        muscleCheckboxValue10 = null;
      });
  }

  void uncheckAll() {
    setState(() {
      muscleCheckboxValue1 = false;
      muscleCheckboxValue2 = false;
      muscleCheckboxValue3 = false;
      muscleCheckboxValue4 = false;
      muscleCheckboxValue5 = false;
      muscleCheckboxValue6 = false;
      muscleCheckboxValue7 = false;
      muscleCheckboxValue8 = false;
      muscleCheckboxValue9 = false;
      muscleCheckboxValue10 = false;
    });
  }

  bool switchCheckboxValue(bool checkboxValueToChange) {
    if (checkboxValueToChange == true || checkboxValueToChange == null) {
      if (switchValue == false)
        return true;
      else
        return null;
    }
    return false;
  }

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
            // StrongrText(
            //   "Trier par",
            //   bold: true,
            //   size: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     buildRadio(
            //       "A-Z",
            //       value: 1,
            //       groupeValue: groupValue,
            //       onChanged: (int newValue) => setState(
            //         () => groupValue = newValue,
            //       ),
            //       onTap: () {
            //         if (groupValue != 1) setState(() => groupValue = 1);
            //       },
            //     ),
            //     buildRadio(
            //       "Z-A",
            //       value: 2,
            //       groupeValue: groupValue,
            //       onChanged: (int newValue) => setState(
            //         () => groupValue = newValue,
            //       ),
            //       onTap: () {
            //         if (groupValue != 2) setState(() => groupValue = 2);
            //       },
            //     ),
            //   ],
            // ),
            // Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if (!areAllChecked())
                      checkAll();
                  },
                  enableFeedback: !areAllChecked(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.select_all,
                    color: !areAllChecked()
                        // ? !switchValue ? StrongrColors.blue : Colors.red[800]
                        ? StrongrColors.black
                        : Colors.grey,
                  ),
                ),
                StrongrText(
                  "Filtres",
                  bold: true,
                  size: 20,
                ),
                InkWell(
                  onTap: () {
                    if (!areAllUnchecked())
                      uncheckAll();
                  },
                  enableFeedback: !areAllUnchecked(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.delete_outline,
                    color: !areAllUnchecked()
                        // ? !switchValue ? StrongrColors.blue : Colors.red[800]
                        ? StrongrColors.black
                        : Colors.grey,
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
                    // if (switchCheckboxValue(muscleCheckboxValue1) != false)
                    //   setState(() => muscleCheckboxValue1 =
                    //       switchCheckboxValue(muscleCheckboxValue1));
                    filterModeChange();
                  },
                ),
                FlatButton(
                  onPressed: () {
                    if (!switchValue) {
                      setState(() => switchValue = !switchValue);
                      // if (switchCheckboxValue(muscleCheckboxValue1) != false)
                      //   setState(() => muscleCheckboxValue1 =
                      //       switchCheckboxValue(muscleCheckboxValue1));
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
            StrongrRaisedButton(
              "Filtrer",
              color: StrongrColors.blue,
              onPressed: areAllChecked() ? null : () => Navigator.pop(context)
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadio(
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

  Widget buildCheckbox(
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
        Container(
          height: 30,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Center(
                child: StrongrText(
                  content,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
