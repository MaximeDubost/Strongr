import 'package:flutter/material.dart';

import '../../main.dart';

class AboutSettingsPage extends StatelessWidget {
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
        title: Text("À propos"),
        backgroundColor: PrimaryColor,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Politique d\'utilisation des données',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Conditions générales d\'utilisation',
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
