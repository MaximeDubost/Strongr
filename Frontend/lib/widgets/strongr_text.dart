import 'package:flutter/material.dart';
import 'package:strongr/utils/strongr_colors.dart';

class StrongrText extends StatelessWidget {
  final String content;
  final Color color;
  final double size;
  final bool bold;
  final TextOverflow overflow;
  final int maxLines;
  final TextAlign textAlign;

  StrongrText(this.content,
      {this.color,
      this.size = 20,
      this.bold = false,
      this.overflow = TextOverflow.ellipsis,
      this.maxLines = 3,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color: color == null ? StrongrColors.black : color,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : null,
      ),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
