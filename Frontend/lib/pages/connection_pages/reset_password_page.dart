import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State createState() => new ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false, _isButtonEnabled = false;
  TextEditingController _emailController;
  String email = "", resetPassword = "";
  Text emailText, resetPasswordText;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" ? true : false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _emailController.text.trim() != "" ? true : false;
    });
    return _isButtonEnabled;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0 || !regExp.hasMatch(value))
      return "L'adresse e-mail est invalide";
    else
      return null;
  }

  void sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      // print("email: $email");

      setState(() {
        _isButtonEnabled = false;
        resetPassword = "Nouveau mot de passe envoyé à :";
        email = _emailController.text;
      });
    } else
      setState(() {
        _validate = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    resetPasswordText = Text(
      resetPassword,
      style: TextStyle(fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
    );
    emailText = Text(
      email,
      style: TextStyle(fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
    );

    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, height / 30, 0, 0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Form(
              key: _key,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  Text(
                    "Réinitialiser le mot de passe",
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Calibri',
                        color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      autofocus: true,
                      maxLength: 50,
                      validator: validateEmail,
                      onSaved: (String value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Adresse e-mail',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(40, 140, 100, 1.0))),
                      ),
                      onChanged: (value) {
                        isEmpty();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                    child: RaisedButton(
                      color: Color.fromRGBO(40, 140, 100, 1.0),
                      disabledColor: Colors.grey,
                      onPressed: _isButtonEnabled
                          ? () {
                              sendToServer();
                            }
                          : null,
                      child: Text(
                        "Obtenir un nouveau mot de passe",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Calibri',
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                    child: Center(child: resetPasswordText),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                    child: Center(child: emailText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
