import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import '../strongr_text.dart';

class NewExerciseFromListDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: StrongrText(
                "Ajouter cet exercice à une séance existante",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 2,
                  width: ScreenSize.width(context) / 4,
                  color: StrongrColors.greyA,
                ),
                StrongrText(
                  "OU",
                  size: 16,
                ),
                Container(
                  height: 2,
                  width: ScreenSize.width(context) / 4,
                  color: StrongrColors.greyA,
                ),
              ],
            ),
            FlatButton(
              onPressed: () {},
              child: StrongrText(
                "Personnaliser cet exercice seul",
              ),
            )
          ],
        ),
      ),
    );
  }
}
