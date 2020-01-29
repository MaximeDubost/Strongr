import 'package:flutter/material.dart';

class OrderByDialog extends StatefulWidget {
  const OrderByDialog({this.onValueChange, this.initialValue});

  final int initialValue;
  final void Function(int) onValueChange;

  @override
  State createState() => new OrderByDialogState();
}

class OrderByDialogState extends State<OrderByDialog> {
  int _groupValue = 1;

  @override
  void initState() {
    super.initState();
    //_groupValue = widget.initialValue;
  }

  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Trier par"),
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: _groupValue,
              onChanged: (newValue) {
                setState(
                  () {
                    _groupValue = newValue;
                  },
                );
              },
            ),
            FlatButton(
              onPressed: () {
                setState(
                  () {
                    _groupValue = 1;
                  },
                );
              },
              child: Text(
                "Date de création",
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 2,
              groupValue: _groupValue,
              onChanged: (newValue) {
                setState(
                  () {
                    _groupValue = newValue;
                  },
                );
              },
            ),
            FlatButton(
              onPressed: () {
                setState(
                  () {
                    _groupValue = 2;
                  },
                );
              },
              child: Text(
                "Ordre alphabétique",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
