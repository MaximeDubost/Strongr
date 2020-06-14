import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/utils/time_formater.dart';
import 'package:strongr/widgets/strongr_text.dart';

class RestTimeDialog extends StatefulWidget {
  final Duration restTime;

  RestTimeDialog({this.restTime});

  @override
  _RestTimeDialogState createState() => _RestTimeDialogState();
}

class _RestTimeDialogState extends State<RestTimeDialog> {
  int minutes;
  int seconds;

  int restTimeInMinutes;
  int restTimeInSeconds;

  @override
  void initState() {
    minutes = TimeFormater.getMinutes(widget.restTime);
    seconds = TimeFormater.getSeconds(widget.restTime);
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
              StrongrText("Temps de repos"),
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
                      NumberPicker.integer(
                        zeroPad: true,
                        // infiniteLoop: true,
                        initialValue: minutes,
                        minValue: 0,
                        maxValue: 10,
                        onChanged: (newValue) => setState(
                          () => minutes = newValue,
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
                      NumberPicker.integer(
                        zeroPad: true,
                        initialValue: seconds,
                        minValue: 0,
                        maxValue: 55,
                        step: 5,
                        onChanged: (newValue) => setState(
                          () => seconds = newValue,
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
                backgroundColor: minutes == 0 && seconds == 0 ? Colors.grey : StrongrColors.blue,
                label: StrongrText(
                  "Valider",
                  color: Colors.white,
                ),
                onPressed: minutes == 0 && seconds == 0 ? null : () => Navigator.pop(context, Duration(minutes: minutes, seconds: seconds)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
