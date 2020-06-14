import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strongr/widgets/strongr_text.dart';

class RepetitionCountDialog extends StatefulWidget {
  final int repetitionCount;

  RepetitionCountDialog({this.repetitionCount});

  @override
  _RepetitionCountDialogState createState() => _RepetitionCountDialogState();
}

class _RepetitionCountDialogState extends State<RepetitionCountDialog> {
  int initialValue;

  @override
  void initState() {
    initialValue = widget.repetitionCount ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
        height: 260,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StrongrText("Nombre de répétitions"),
              Column(
                children: <Widget>[
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 1,
                  ),
                  NumberPicker.integer(
                    infiniteLoop: true,
                    initialValue: initialValue,
                    minValue: 1,
                    maxValue: 100,
                    onChanged: (newValue) => setState(
                      () => initialValue = newValue,
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 1,
                  ),
                ],
              ),
              FloatingActionButton.extended(
                // icon: Icon(Icons.check),
                label: StrongrText(
                  "Valider",
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, initialValue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
