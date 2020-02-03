import 'package:flutter/material.dart';

import '../../main.dart';

class OrderByDialog extends StatefulWidget {
  const OrderByDialog(this.orderByList, {this.onValueChange, this.initialValue});

  final List<String> orderByList;
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
      title: Text(
        "Trier par",
        style: TextStyle(
            color: PrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      
      children: <Widget>[
        for(String item in widget.orderByList)
        Row(
          children: <Widget>[
            Radio(
              value: widget.orderByList.indexOf(item) + 1,
              groupValue: _groupValue,
              onChanged: (newValue) {
                setState(
                  () {
                    _groupValue = newValue;
                  },
                );
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              splashColor: VeryLightGrey,
              onPressed: () {
                setState(
                  () {
                    _groupValue = widget.orderByList.indexOf(item) + 1;
                  },
                );
                Navigator.of(context).pop();
              },
              child: Text(
                item,
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
