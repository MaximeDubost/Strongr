import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/delete_account_dialog.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final List<String> settingsList = [
    "Conditions générales",
    "Unité de mesure de masse",
    "Déconnexion",
    "Supprimer le compte"
  ];

  logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Container(
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StrongrText("Êtes-vous sûr(e) de vouloir vous déconnecter ?"),
                Column(
                  children: <Widget>[
                    FloatingActionButton.extended(
                      backgroundColor: Colors.red[800],
                      label: StrongrText(
                        "Se déconnecter",
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove("token");
                        Navigator.pushNamedAndRemoveUntil(context, LOG_IN_ROUTE,
                            ModalRoute.withName(HOMEPAGE_ROUTE));
                      },
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: StrongrText(
                        "Annuler",
                        size: 18,
                        color: Colors.grey,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  deleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteAccountDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Réglages"),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return FlatButton(
            onPressed: () async {
              switch (settingsList[index]) {
                case "Déconnexion":
                  logout(context);
                  break;
                case "Supprimer le compte":
                  deleteAccount(context);
                  break;
              }
            },
            child: SizedBox(
              height: 60,
              child: Align(
                alignment: Alignment.centerLeft,
                child: StrongrText(
                  settingsList[index],
                  textAlign: TextAlign.start,
                  color: settingsList[index] == "Supprimer le compte"
                      ? Colors.red[800]
                      : StrongrColors.black,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return Divider();
        },
        itemCount: settingsList.length,
      ),
    );
  }
}
