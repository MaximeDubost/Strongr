import 'package:flutter/material.dart';

import '../../main.dart';

class NotificationsSettingsPage extends StatefulWidget {
  @override
  State createState() => NotificationsSettingsPageState();
}

class NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  var _value = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Notifications"),
        backgroundColor: PrimaryColor,
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text(
              'Toutes les notifications',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            value: _value,
            activeColor: PrimaryColor,
            onChanged: (bool value) {
              setState(() {
                _value = !_value;
              });
            },
          ),
        ],
      ),
    );
  }
}
