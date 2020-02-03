import 'package:flutter/material.dart';

import '../../main.dart';

class EditProfilePage extends StatelessWidget {
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
        title: Text("Modifier le profil"),
        backgroundColor: PrimaryColor,
      ),
      body: Center(
        child: Text(
          "Bientôt disponible.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
        ),
      ),
    );
  }
}
