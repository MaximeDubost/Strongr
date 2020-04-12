import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class StrongrRoundedContainer extends StatefulWidget {
  final Widget content;
  final Function onPressed;

  StrongrRoundedContainer({@required this.content, @required this.onPressed});

  @override
  _StrongrRoundedContainerState createState() => _StrongrRoundedContainerState();
}

class _StrongrRoundedContainerState extends State<StrongrRoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width(context) / 1.2,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: StrongrColors.greyD),
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
