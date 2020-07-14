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
  bool counterEnded, buttonPressed;

  @override
  void initState() {
    _counter = 3;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0)
        setState(() => _counter--);
      else
        timer.cancel();
    });
    counterEnded = _counter == 0;
    buttonPressed = false;
    super.initState();
  }

  sendToServer() async {
    setState(() => buttonPressed = true);
    int statusCode = await UserService.deleteUser();
    if (statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
      Navigator.pushNamedAndRemoveUntil(
          context, LOG_IN_ROUTE, ModalRoute.withName(HOMEPAGE_ROUTE));
    } else
      setState(() => Navigator.pop(context, true));
  }

  @override
  Widget build(BuildContext context) {
    counterEnded = _counter == 0;
    return WillPopScope(
      onWillPop: () async {
        _timer.cancel();
        return true;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Container(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StrongrText(
                "Êtes-vous sûr(e) de vouloir supprimer votre compte ?",
              ),
              Column(
                children: <Widget>[
                  Container(
                    // width: _counter != 0 ? 100 : null,
                    child: Stack(
                      children: <Widget>[
                        FloatingActionButton.extended(
                          backgroundColor: !counterEnded || buttonPressed
                              ? Colors.grey
                              : Colors.red[800],
                          label: Opacity(
                            opacity: counterEnded ? 1 : 0,
                            child: StrongrText(
                              "Supprimer le compte",
                              color: Colors.white,
                            ),
                          ),
                          onPressed: !counterEnded || buttonPressed
                              ? null
                              : () => sendToServer(),
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
                    onPressed: () {
                      _timer.cancel();
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
