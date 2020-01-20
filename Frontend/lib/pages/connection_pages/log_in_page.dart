import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homepage.dart';
import 'reset_password_page.dart';

class LogInPage extends StatefulWidget {
  @override
  State createState() => new LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false, _isButtonEnabled = false, _buttonPressSuccess = false;
  TextEditingController _emailController, _passwordController;
  String email, password;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" &&
            _passwordController.text.trim() != ""
        ? true
        : false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _emailController.text.trim() != "" &&
              _passwordController.text.trim() != ""
          ? true
          : false;
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

  String validatePassword(String value) {
    if (!_buttonPressSuccess) {
      String pattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0 || !regExp.hasMatch(value))
        return "Le mot de passe est incorrect";
      else
        return null;
    } else {
      _buttonPressSuccess = false;
      return null;
    }
  }

  void sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _buttonPressSuccess = true;

      // print("email: $email");
      // print("password: $password");

      setState(() {
        password = _passwordController.text = "";
        _isButtonEnabled = false;
      });

      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => Homepage()));
    } else
      setState(() {
        _validate = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                    "Connexion",
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
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      obscureText: true,
                      maxLength: 30,
                      validator: validatePassword,
                      onSaved: (String value) {
                        password = value;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
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
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                ResetPasswordPage()));
                      },
                      child: Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Calibri',
                            color: Colors.grey),
                      ),
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
                        "Se connecter",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Calibri',
                            color: Colors.white),
                      ),
                    ),
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
