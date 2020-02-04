import 'package:flutter/material.dart';

import '../../main.dart';

class ConfidentialitySettingsPage extends StatefulWidget {
  @override
  State createState() => new ConfidentialitySettingsPageState();
}

class ConfidentialitySettingsPageState
    extends State<ConfidentialitySettingsPage> {
  var _value = false;

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
        title: Text("Confidentialité"),
        backgroundColor: PrimaryColor,
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text(
              'Compte privé',
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
          ListTile(
            title: Text(
              'Comptes bloqués',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
