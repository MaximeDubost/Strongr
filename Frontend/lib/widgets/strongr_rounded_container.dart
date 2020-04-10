import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class StrongrRoundedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width(context) / 1.2,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: StrongrColors.greyD),
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Center(
        child: StrongrText("item"),
      ),
    );
  }
}
