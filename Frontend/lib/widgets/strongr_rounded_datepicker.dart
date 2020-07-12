import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';

class StrongrRoundedDatePicker extends StatefulWidget {
  final double width;
  final String text;
  final Color textColor;
  final Function onPressed;


  StrongrRoundedDatePicker({
    this.width,
    this.text,
    this.textColor,
    @required this.onPressed
  });

  @override
  _StrongrRoundedDatePickerState createState() =>
      _StrongrRoundedDatePickerState();
}

class _StrongrRoundedDatePickerState extends State<StrongrRoundedDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widget.width == null ? ScreenSize.width(context) : widget.width,
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FlatButton(
        onPressed: widget.onPressed,
        // onPressed: () {},
        child: Container(
          width:
              widget.width == null ? ScreenSize.width(context) : widget.width,
          child: Text(
            widget.text == null || widget.text == "" ? "jj/mm/aaaa" : DateFormater.format(widget.text),
            textAlign: TextAlign.start,
            style: TextStyle(
              color: widget.text == null || widget.text == "" ? Colors.grey : StrongrColors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
