import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_text.dart';

class RepetitionCountDialog extends StatefulWidget {
  @override
  _RepetitionCountDialogState createState() => _RepetitionCountDialogState();
}

class _RepetitionCountDialogState extends State<RepetitionCountDialog> {
  int repetitionCount;

  @override
  void initState() {
    repetitionCount = 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              StrongrText("Nombre de répétitions"),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                height: 1,
              ),
              NumberPicker.integer(
                infiniteLoop: true,
                initialValue: repetitionCount,
                minValue: 1,
                maxValue: 100,
                onChanged: (newValue) => setState(
                  () => repetitionCount = newValue,
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                height: 1,
              ),
              StrongrRaisedButton(
                "Valider",
                color: Theme.of(context).accentColor,
                onPressed: () {},
              )
              // Text("Current number: $repetitionCount"),
            ],
          ),
        ),
      ),
    );
  }
}
