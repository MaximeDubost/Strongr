import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/delete_account_dialog.dart';
import 'package:strongr/widgets/strongr_snackbar_content.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final globalKey = GlobalKey<ScaffoldState>();
  final List<String> settingsList = [
    "Mentions légales",
    "Unité de masse",
    "Déconnexion",
    "Supprimer le compte"
  ];
  bool switchValue;

  @override
  void initState() {
    super.initState();
    switchValue = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
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
                case "Mentions légales":
                  Navigator.pushNamed(context, LEGAL_NOTICE_ROUTE);
                  break;
                case "Unité de masse":
                  setState(() => switchValue = !switchValue);
                  break;
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
              child: settingsList[index] != "Unité de masse"
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: StrongrText(
                        settingsList[index],
                        textAlign: TextAlign.start,
                        color: settingsList[index] == "Supprimer le compte"
                            ? Colors.red[800]
                            : StrongrColors.black,
                      ),
                    )
                  : buildMassUnit(index),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return Divider(height: 0);
        },
        itemCount: settingsList.length,
      ),
    );
  }

  Widget buildMassUnit(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        StrongrText(
          settingsList[index],
          textAlign: TextAlign.start,
        ),
        Row(
          children: <Widget>[
            StrongrText(
              "kg",
              color: switchValue ? Colors.grey : StrongrColors.black80,
            ),
            Switch(
              value: switchValue,
              activeColor: Colors.white,
              activeTrackColor: Colors.grey,
              onChanged: (newValue) => setState(() => switchValue = newValue),
            ),
            StrongrText(
              "lb",
              color: !switchValue ? Colors.grey : StrongrColors.black80,
            ),
          ],
        ),
      ],
    );
    // return Align(
    //   alignment: Alignment.centerLeft,
    //   child: StrongrText(
    //     settingsList[index],
    //     textAlign: TextAlign.start,
    //   ),
    // );
  }

  logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Container(
            height: 180,
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
    ).then((deletionFailed) {
      if (deletionFailed != null && deletionFailed) {
        globalKey.currentState.hideCurrentSnackBar();
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: StrongrSnackBarContent(
              icon: Icons.close,
              message: "Échec lors de la suppression du compte",
            ),
            backgroundColor: Colors.red.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
        );
      }
    });
  }
}
