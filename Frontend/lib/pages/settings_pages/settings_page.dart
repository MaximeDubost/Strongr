import 'package:flutter/material.dart';
import 'package:strongr/UI/dialogs/custom_dialog.dart';

import '../../main.dart';
import '../../utils/no_animation_material_page_route.dart';
import 'about_settings_page.dart';
import 'activity_settings_page.dart';
import 'coach_settings_page.dart';
import 'confidentiality_settings_page.dart';
import 'general_settings_page.dart';
import 'help_settings_page.dart';
import 'notifications_settings_page.dart';

class SettingsPage extends StatelessWidget {
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
        title: Text("Paramètres"),
        backgroundColor: PrimaryColor,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Général',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            onTap: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => GeneralSettingsPage())),
          ),
          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Activité',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            onTap: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => ActivitySettingsPage())),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            onTap: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) =>
                        NotificationsSettingsPage())),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Confidentialité',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            onTap: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) =>
                        ConfidentialitySettingsPage())),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Devenir coach',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            onTap: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => CoachSettingsPage())),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Aide',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            onTap: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => HelpSettingsPage())),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            onTap: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => AboutSettingsPage())),
          ),
          ListTile(
            leading: Icon(
              Icons.close,
              color: Colors.red,
            ),
            title: Text(
              'Déconnexion',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                      "Se déconnecter ?",
                      "Vous allez être redirigé vers la page de connexion.",
                      "Se déconnecter",
                      "Annuler",
                      validateAction: () {},
                      cancelAction: () => Navigator.of(context).pop());
                },
              );
            },
            // onTap: () => showDialog<bool>(
            //   context: context,
            //   builder: (c) => AlertDialog(
            //     title: Text(
            //       "Se déconnecter ?",
            //       style: TextStyle(
            //           color: PrimaryColor,
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     content:
            //         Text('Vous allez être redirigé vers la page de connexion', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 18)),
            //     actions: [
            //       FlatButton(
            //         child: Text('Se déconnecter', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
            //         onPressed: () => {},
            //         splashColor: VeryLightGrey,
            //       ),
            //       FlatButton(
            //         child: Text('Annuler', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
            //         onPressed: () => Navigator.pop(c, false),
            //         splashColor: VeryLightGrey,
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
