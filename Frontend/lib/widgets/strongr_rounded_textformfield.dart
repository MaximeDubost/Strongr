import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';

class StrongrRoundedTextFormField extends StatefulWidget {
  final double fontSize;
  final String initialValue;
  final bool enabled;
  final double width;
  final String hint;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final Function validator;
  final bool autofocus;
  final Function onSaved;
  final Function onChanged;
  final bool obscureText;
  final int maxLength;
  final IconData suffixIcon;
  final IconData suffixIconAlt;
  final Color suffixIconColor;
  final Function onPressedSuffixIcon;
  final List<TextInputFormatter> inputFormatters;

  StrongrRoundedTextFormField({
    this.fontSize,
    this.initialValue,
    this.enabled = true,
    this.width,
    this.hint,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.validator,
    this.autofocus = false,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.maxLength,
    this.suffixIcon,
    this.suffixIconAlt,
    this.suffixIconColor,
    this.onPressedSuffixIcon,
    this.inputFormatters,
  });

  @override
  _StrongrRoundedTextFormFieldState createState() =>
      _StrongrRoundedTextFormFieldState();
}

class _StrongrRoundedTextFormFieldState
    extends State<StrongrRoundedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width == null ? ScreenSize.width(context) : widget.width,
      child: TextFormField(
        style: TextStyle(fontSize: widget.fontSize),
        initialValue: widget.initialValue,
        enabled: widget.enabled,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        validator: widget.validator,
        autofocus: widget.autofocus,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        textCapitalization: widget.textCapitalization,
        cursorColor: StrongrColors.black,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon != null ? IconButton(
            icon: Icon(widget.obscureText ? widget.suffixIcon : (widget.suffixIconAlt == null ? widget.suffixIcon : widget.suffixIconAlt), color: widget.suffixIconColor == null ? StrongrColors.black : widget.suffixIconColor,),
            onPressed: widget.onPressedSuffixIcon,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ) : null,
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
