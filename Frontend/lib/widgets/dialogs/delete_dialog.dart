import 'package:flutter/material.dart';
import '../strongr_text.dart';

class DeleteDialog extends StatefulWidget {
  final double height;
  final String title;
  final Widget content;
  final Function onPressed;

  DeleteDialog({
    @required this.height,
    @required this.title,
    @required this.content,
    @required this.onPressed,
  });

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StrongrText(
              widget.title,
              bold: true,
              size: 22,
            ),
            SizedBox(height: 5),
            widget.content,
            Column(
              children: <Widget>[
                FloatingActionButton.extended(
                  backgroundColor: Colors.red[800],
                  icon: Icon(Icons.delete_outline),
                  label: StrongrText(
                    "Supprimer",
                    color: Colors.white,
                  ),
                  onPressed: widget.onPressed,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  // color: Colors.blue,
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: StrongrText(
                      "Annuler",
                      size: 18,
                      color: Colors.grey,
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
              ],
            ),

            // RawMaterialButton(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.all(10),
            //     child: StrongrText(
            //       "Ajouter cet exercice à une séance existante",
            //     ),
            //   ),
            //   onPressed: () {},
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     Container(
            //       height: 1,
            //       width: ScreenSize.width(context) / 4,
            //       color: StrongrColors.greyA,
            //     ),
            //     StrongrText(
            //       "OU",
            //       bold: true,
            //       size: 16,
            //     ),
            //     Container(
            //       height: 1,
            //       width: ScreenSize.width(context) / 4,
            //       color: StrongrColors.greyA,
            //     ),
            //   ],
            // ),
            // RawMaterialButton(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.all(10),
            //     child: StrongrText(
            //       "Personnaliser cet exercice seul aaa",
            //     ),
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
