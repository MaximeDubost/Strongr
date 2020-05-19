import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';

class StrongrRoundedContainer extends StatefulWidget {
  final double width;
  final Widget content;
  final Function onPressed;
  final Color borderColor;
  final double borderWidth;

  StrongrRoundedContainer({this.width, @required this.content, @required this.onPressed, this.borderColor, this.borderWidth = 1});

  @override
  _StrongrRoundedContainerState createState() => _StrongrRoundedContainerState();
}

class _StrongrRoundedContainerState extends State<StrongrRoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width == null ? ScreenSize.width(context) / 1.2 : widget.width,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: widget.borderColor == null ? StrongrColors.greyD : widget.borderColor, width: widget.borderWidth),
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        onPressed: widget.onPressed,
        child: Center(
          child: widget.content
        ),
      ),
    );
  }
}
