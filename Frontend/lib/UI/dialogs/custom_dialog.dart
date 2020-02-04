import 'package:flutter/material.dart';

import '../../main.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String content;
  final String validateButton;
  final String cancelButton;
  final void Function() validateAction;
  final void Function() cancelAction;
 
  CustomDialog(this.title, this.content, this.validateButton, this.cancelButton, {this.validateAction, this.cancelAction});

  @override
  State createState() => new CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: TextStyle(
            color: PrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Text(
        widget.content,
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 18),
      ),
      actions: <Widget>[
        FlatButton(
          splashColor: VeryLightGrey,
          onPressed: widget.validateAction,
          child: Text(
            widget.validateButton,
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        FlatButton(
          splashColor: VeryLightGrey,
          onPressed: widget.cancelAction,
          child: Text(
            widget.cancelButton,
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
