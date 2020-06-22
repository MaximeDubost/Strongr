import 'package:flutter/material.dart';
import 'package:strongr/widgets/strongr_text.dart';

class StrongrSnackBarContent extends StatelessWidget {
  final IconData icon;
  final String message;

  StrongrSnackBarContent({
    this.icon,
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          child: Icon(
            icon ?? Icons.check,
            color: Colors.white,
          ),
        ),
        Flexible(
          child: Container(
            child: StrongrText(
              message,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 32,
          height: 32,
        ),
      ],
    );
  }
}
