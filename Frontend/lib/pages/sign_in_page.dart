import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class SignInPage extends StatefulWidget {
  @override
  State createState() => new SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false,
      _isButtonEnabled = false,
      _isVisible = false,
      _buttonPressSuccess = false;
  TextEditingController _emailController,
      _passwordController,
      _confirmPasswordController;
  String email, password, confirmPassword, conditionsTitle;
  String firstCondition = "❌ 8 caractères";
  String secondCondition = "❌ Une lettre minuscule";
  String thirdCondition = "❌ Une lettre majuscule";
  String fourthCondition = "❌ Un chiffre";
  String fifthCondition = "❌ Un caractère spécial parmis @\$!%*?&";
  Text conditionsTitleText,
      firstConditionText,
      secondConditionText,
      thirdConditionText,
      fourthConditionText,
      fifthConditionText;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" &&
            _passwordController.text.trim() != "" &&
            _confirmPasswordController.text.trim() != ""
        ? true
        : false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _emailController.text.trim() != "" &&
              _passwordController.text.trim() != "" &&
              _confirmPasswordController.text.trim() != ""
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
        return "Le format du mot de passe est invalide";
      else
        return null;
    } else {
      _buttonPressSuccess = false;
      return null;
    }
  }

  String validateConfirmPassword(String value) {
    if (!_buttonPressSuccess) {
      if (value != _passwordController.text)
        return "Les mots de passe ne sont pas identiques";
      else
        return null;
    } else {
      _buttonPressSuccess = false;
      return null;
    }
  }

  void _onChanged() {
    if (_passwordController.text.length >= 8)
      setState(() {
        firstCondition = "✔️ 8 caractères";
      });
    else
      setState(() {
        firstCondition = "❌ 8 caractères";
      });
    if (_passwordController.text.contains(RegExp(r'[a-z]')))
      setState(() {
        secondCondition = "✔️ Une lettre minuscule";
      });
    else
      setState(() {
        secondCondition = "❌ Une lettre minuscule";
      });
    if (_passwordController.text.contains(RegExp(r'[A-Z]')))
      setState(() {
        thirdCondition = "✔️ Une lettre majuscule";
      });
    else
      setState(() {
        thirdCondition = "❌ Une lettre majuscule";
      });
    if (_passwordController.text.contains(RegExp(r'[1-9]')))
      setState(() {
        fourthCondition = "✔️ Un chiffre";
      });
    else
      setState(() {
        fourthCondition = "❌ Un chiffre";
      });
    if (_passwordController.text.contains(RegExp(r'(?=.*[@$!%*?&])')))
      setState(() {
        fifthCondition = "✔️ Un caractère spécial parmis @\$!%*?&";
      });
    else
      setState(() {
        fifthCondition = "❌ Un caractère spécial parmis @\$!%*?&";
      });
  }

  void sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _buttonPressSuccess = true;

      // print("email: $email");
      // print("password: $password");
      // print("confirmPassword: $confirmPassword");

      setState(() {
        password = confirmPassword =
            _passwordController.text = _confirmPasswordController.text = "";
        _isButtonEnabled = false;
      });

      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => Homepage()));
    } else
      setState(() {
        _validate = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    firstConditionText = Text(
      firstCondition,
      style: TextStyle(fontSize: 14, fontFamily: 'Calibri', color: Colors.grey),
    );

    secondConditionText = Text(
      secondCondition,
      style: TextStyle(fontSize: 14, fontFamily: 'Calibri', color: Colors.grey),
    );

    thirdConditionText = Text(
      thirdCondition,
      style: TextStyle(fontSize: 14, fontFamily: 'Calibri', color: Colors.grey),
    );

    fourthConditionText = Text(
      fourthCondition,
      style: TextStyle(fontSize: 14, fontFamily: 'Calibri', color: Colors.grey),
    );

    fifthConditionText = Text(
      fifthCondition,
      style: TextStyle(fontSize: 14, fontFamily: 'Calibri', color: Colors.grey),
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
                    "Inscription",
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
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
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
                      onTap: () {
                        setState(() {
                          _isVisible = true;
                        });
                      },
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
                        _onChanged();
                      },
                    ),
                  ),
                  Visibility(
                    visible: _isVisible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            "Le mot de passe doit contenir au minimum :",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Calibri',
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: firstConditionText),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: secondConditionText),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: thirdConditionText),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: fourthConditionText),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: fifthConditionText),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      obscureText: true,
                      maxLength: 30,
                      validator: validateConfirmPassword,
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
                      onSaved: (String value) {
                        confirmPassword = value;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
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
                              setState(() {
                                _isVisible = false;
                              });
                              sendToServer();
                            }
                          : null,
                      child: Text(
                        "S'inscrire",
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
