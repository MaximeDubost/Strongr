import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import '../strongr_text.dart';

class FiltersDialog extends StatefulWidget {
  @override
  _FiltersDialogState createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
        height: 420,
        width: ScreenSize.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StrongrText(
              "Trier par",
              bold: true,
              size: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildRadio(
                  "A-Z",
                  value: true,
                  onChanged: (bool newValue) {},
                  onTap: () {},
                  groupeValue: true,
                ),
                buildRadio(
                  "Z-A",
                  value: false,
                  onChanged: (bool newValue) {},
                  onTap: () {},
                  groupeValue: true,
                ),
              ],
            ),
            Divider(thickness: 1),
            StrongrText(
              "Filtres",
              bold: true,
              size: 20,
            ),
            FlatButton(
              onPressed: () {},
              child: StrongrText(
                "Tout sélectionner",
                size: 18,
                color: Colors.grey,
              ),
            ),
            Table(
              defaultColumnWidth: FractionColumnWidth(0.55),
              children: [
                TableRow(
                  children: [
                    buildCheckbox(
                      "Abdominaux",
                      value: true,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                    buildCheckbox(
                      "Avant bras",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Biceps",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                    buildCheckbox(
                      "Dos",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Épaules",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                    buildCheckbox(
                      "Ischios",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Mollets",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                    buildCheckbox(
                      "Pectoraux",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    buildCheckbox(
                      "Quadriceps",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                    buildCheckbox(
                      "Triceps",
                      value: false,
                      onChanged: (bool newValue) {},
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadio(
    String content, {
    @required bool value,
    @required Function onChanged,
    @required Function onTap,
    @required bool groupeValue,
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
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: StrongrText(
              content,
              size: 18,
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
          width: 20,
          height: 40,
          child: Checkbox(
            activeColor: StrongrColors.blue,
            value: value,
            onChanged: onChanged,
          ),
        ),
        Container(
          height: 20,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: StrongrText(
                content,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
