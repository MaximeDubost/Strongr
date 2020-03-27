import 'package:flutter/material.dart';
import 'package:strongr/utils/strongr_colors.dart';

class StrongrRoundedTextFormField extends StatefulWidget {
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

  StrongrRoundedTextFormField({
    this.hint,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.validator,
    this.autofocus = false,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.maxLength = 30,
  });

  @override
  _StrongrRoundedTextFormFieldState createState() =>
      _StrongrRoundedTextFormFieldState();
}

class _StrongrRoundedTextFormFieldState
    extends State<StrongrRoundedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
