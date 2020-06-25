import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/utils/time_formater.dart';
import 'package:strongr/widgets/strongr_text.dart';

class NewSetDialog extends StatefulWidget {
  final int repetitionCount;
  final Duration restTime;

  NewSetDialog({
    this.repetitionCount,
    this.restTime,
  });

  @override
  _NewSetDialogState createState() => _NewSetDialogState();
}

class _NewSetDialogState extends State<NewSetDialog> {
  int repetitionCount;
  int minutes;
  int seconds;

  @override
  void initState() {
    repetitionCount = widget.repetitionCount ?? 1;
    minutes = TimeFormater.getMinutes(widget.restTime);
    seconds = TimeFormater.getSeconds(widget.restTime);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StrongrText(
                "Nouvelle série",
                bold: true,
              ),
              StrongrText("Répétitions et repos"),
              Column(
                children: <Widget>[
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 50,
                        child: NumberPicker.integer(
                          infiniteLoop: true,
                          initialValue: repetitionCount,
                          minValue: 1,
                          maxValue: 100,
                          onChanged: (newValue) => setState(
                            () => repetitionCount = newValue,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 50,
                            // color: Colors.red,
                            child: NumberPicker.integer(
                              zeroPad: true,
                              // infiniteLoop: true,
                              initialValue: minutes,
                              minValue: 0,
                              maxValue: 10,
                              onChanged: (newValue) => setState(
                                () => minutes = newValue,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: StrongrText(
                              ":",
                              size: 24,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 50,
                            child: NumberPicker.integer(
                              zeroPad: true,
                              initialValue: seconds,
                              minValue: 0,
                              maxValue: 55,
                              step: 5,
                              onChanged: (newValue) => setState(
                                () => seconds = newValue,
                              ),
                            ),
                          ),
                        ],
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
                backgroundColor: minutes == 0 && seconds == 0
                    ? Colors.grey
                    : StrongrColors.blue,
                icon: Icon(Icons.add),
                label: StrongrText(
                  "Ajouter",
                  color: Colors.white,
                ),
                onPressed: minutes == 0 && seconds == 0
                    ? null
                    : () => Navigator.pop(
                          context,
                          {
                            "repetitionCount": repetitionCount,
                            "restTime": Duration(
                              minutes: minutes,
                              seconds: seconds,
                            ),
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
