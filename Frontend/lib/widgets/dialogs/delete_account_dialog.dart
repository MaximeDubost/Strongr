import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strongr/services/UserService.dart';
import 'package:strongr/utils/routing_constants.dart';
import '../strongr_text.dart';

class DeleteAccountDialog extends StatefulWidget {
  @override
  _DeleteAccountDialogState createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  int _counter;
  Timer _timer;

  @override
  void initState() {
    _counter = 3;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0)
        setState(() => _counter--);
      else
        timer.cancel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _timer.cancel();
        return true;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Container(
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StrongrText(
                  "Êtes-vous sûr(e) de vouloir supprimer votre compte ?"),
              Column(
                children: <Widget>[
                  Container(
                    // width: _counter != 0 ? 100 : null,
                    child: Stack(
                      children: <Widget>[
                        FloatingActionButton.extended(
                          backgroundColor:
                              _counter != 0 ? Colors.grey : Colors.red[800],
                          label: Opacity(
                            opacity: _counter == 0 ? 1 : 0,
                            child: StrongrText(
                              "Supprimer le compte",
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _counter != 0
                              ? null
                              : () async {
                                  int statusCode =
                                      await UserService.deleteUser();
                                  if (statusCode == 200) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove("token");
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        LOG_IN_ROUTE,
                                        ModalRoute.withName(HOMEPAGE_ROUTE));
                                  }
                                },
                        ),
                        _counter != 0
                            ? SizedBox(
                                height: 48,
                                child: Center(
                                  child: StrongrText(
                                    _counter.toString(),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
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
                      onPressed: () => Navigator.pop(context)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
