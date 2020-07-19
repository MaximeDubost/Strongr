import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strongr/models/Bodyweight.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class BodyweightDialog extends StatefulWidget {
  final Bodyweight bodyweight;

  BodyweightDialog({this.bodyweight});

  @override
  _BodyweightDialogState createState() => _BodyweightDialogState();
}

class _BodyweightDialogState extends State<BodyweightDialog> {
  int digitsBeforeDecimal;
  int digitsAfterDecimal;
  bool _switchValue;

  @override
  void initState() {
    digitsBeforeDecimal = widget.bodyweight.value.toInt();
    digitsAfterDecimal =
        int.tryParse(widget.bodyweight.value.toString().split('.')[1]);
    _switchValue = widget.bodyweight.isLb;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StrongrText("Poids"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      StrongrText(
                        "kg",
                        size: 18,
                        color: !_switchValue ? StrongrColors.blue : Colors.grey,
                      ),
                      Switch(
                        activeColor: Colors.white,
                        activeTrackColor: Colors.grey,
                        onChanged: (newValue) =>
                            setState(() => _switchValue = newValue),
                        value: _switchValue,
                      ),
                      StrongrText(
                        "lb",
                        size: 18,
                        color: _switchValue ? StrongrColors.blue : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 24),
                      SizedBox(
                        width: 50,
                        child: NumberPicker.integer(
                          // zeroPad: true,
                          // infiniteLoop: true,
                          initialValue: digitsBeforeDecimal,
                          minValue: 12,
                          maxValue: 597,
                          onChanged: (newValue) => setState(
                            () => digitsBeforeDecimal = newValue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: StrongrText(
                          ",",
                          size: 24,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: NumberPicker.integer(
                          zeroPad: true,
                          initialValue: digitsAfterDecimal,
                          minValue: 0,
                          maxValue: 9,
                          // step: 5,
                          onChanged: (newValue) => setState(
                            () => digitsAfterDecimal = newValue,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                        child: StrongrText(
                          !_switchValue ? "kg" : "lb",
                          color: StrongrColors.black80
                        ),
                      ),
                    ],
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
                backgroundColor:
                    digitsBeforeDecimal == 0 && digitsAfterDecimal == 0
                        ? Colors.grey
                        : StrongrColors.blue,
                label: StrongrText(
                  "Valider",
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(
                  context,
                  Bodyweight(
                    value: double.parse(digitsBeforeDecimal.toString() + "." + digitsAfterDecimal.toString()),
                    isLb: _switchValue
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
