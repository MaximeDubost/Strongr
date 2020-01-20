import 'package:flutter/material.dart';

import '../../main.dart';

class HelpSettingsPage extends StatelessWidget {
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
        title: Text("Aide"),
        backgroundColor: PrimaryColor,
      ),
      body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Signaler un problème'),
              onTap: () {},
            ),
            ListTile(
              title: Text('FAQ'),
              onTap: () {},
            ),
          ],
        ),
    );
  }
}