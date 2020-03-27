import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';

class StrongrRaisedButton extends StatefulWidget {
  final String content;
  final Color color;
  final Color textColor;
  final Color disabledColor;
  final Function onPressed;

  StrongrRaisedButton(
    this.content, {
    this.color,
    this.textColor,
    this.disabledColor,
    @required this.onPressed,
  });

  @override
  _StrongrRaisedButtonState createState() => _StrongrRaisedButtonState();
}

class _StrongrRaisedButtonState extends State<StrongrRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: ScreenSize.width(context) / 2,
      child: RaisedButton(
        color: widget.color == null ? StrongrColors.black : widget.color,
        disabledColor: widget.disabledColor == null ? Colors.grey : widget.disabledColor,
        onPressed: widget.onPressed,
        child: Text(
          widget.content,
          style: TextStyle(
              fontSize: 20, fontFamily: 'Calibri', color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
