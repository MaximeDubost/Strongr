import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SetCountDialog extends StatefulWidget {
  final int setCount;

  SetCountDialog({this.setCount});

  @override
  _SetCountDialogState createState() => _SetCountDialogState();
}

class _SetCountDialogState extends State<SetCountDialog> {
  int initialValue;

  @override
  void initState() {
    initialValue = widget.setCount ?? 1;
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
              StrongrText("Nombre de séries"),
              Column(
                children: <Widget>[
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 1,
                  ),
                  NumberPicker.integer(
                    initialValue: initialValue,
                    minValue: 1,
                    maxValue: 10,
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
