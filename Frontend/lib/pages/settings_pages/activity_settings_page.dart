import 'package:flutter/material.dart';

import '../../main.dart';

class ActivitySettingsPage extends StatelessWidget {
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
        title: Text("Activité"),
        backgroundColor: PrimaryColor,
      ),
      body: ListView(
          children: <Widget>[
          ],
        ),
    );
  }
}