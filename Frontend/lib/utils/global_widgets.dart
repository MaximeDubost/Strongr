import 'package:flutter/material.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class GlobalWidgets {
  static Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(StrongrColors.blue),
      ),
    );
  }

  static Widget buildMessage(String message) {
    return Center(
      child: StrongrText(
        message,
      ),
    );
  }
}
