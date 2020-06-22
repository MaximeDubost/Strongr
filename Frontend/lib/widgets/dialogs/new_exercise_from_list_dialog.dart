import 'package:flutter/material.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercise_create_view.dart';
import '../strongr_text.dart';

class NewExerciseFromListDialog extends StatefulWidget {
  final int id;
  final String name;

  NewExerciseFromListDialog({@required this.id, @required this.name});

  @override
  _NewExerciseFromListDialogState createState() =>
      _NewExerciseFromListDialogState();
}

class _NewExerciseFromListDialogState extends State<NewExerciseFromListDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: StrongrText(
                  "Ajouter cet exercice à une séance existante",
                ),
              ),
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 1,
                  width: ScreenSize.width(context) / 4,
                  color: StrongrColors.greyA,
                ),
                StrongrText(
                  "OU",
                  bold: true,
                  size: 16,
                ),
                Container(
                  height: 1,
                  width: ScreenSize.width(context) / 4,
                  color: StrongrColors.greyA,
                ),
              ],
            ),
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: StrongrText(
                  "Personnaliser cet exercice seul",
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  EXERCISE_CREATE_ROUTE,
                  arguments: ExerciseCreateView(
                    id: widget.id,
                    name: widget.name,
                  ),
                ).then(
                  (result) {
                    Navigator.pop(context, result);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
