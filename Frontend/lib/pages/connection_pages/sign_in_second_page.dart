import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/pages/others_pages/welcome_page.dart';

class SignInSecondPage extends StatefulWidget {
  @override
  State createState() => new SignInSecondPageState();
}

class SignInSecondPageState extends State<SignInSecondPage> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false,
      _isButtonEnabled = false,
      _isVisible = false,
      _buttonPressSuccess = false;
  TextEditingController _nameController, _usernameController;
  String name, username, conditionsTitle;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _usernameController = TextEditingController(text: "");
    _isButtonEnabled = _nameController.text.trim() != "" &&
            _usernameController.text.trim() != ""
        ? true
        : false;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _nameController.text.trim() != "" &&
              _usernameController.text.trim() != ""
          ? true
          : false;
    });
    return _isButtonEnabled;
  }

  String validateName(String value) {
    String pattern = "^[a-zA-Z]+(([ -][a-zA-Z ])?[a-zA-Z]*)*\$";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0 || !regExp.hasMatch(value))
      return "Le nom est invalide";
    else
      return null;
  }

  String validateUsername(String value) {
    if (!_buttonPressSuccess) {
      String pattern = "^(?=.{5,20}\$)(?![_.])(?!.*[_.]{2})[a-z0-9._]+(?<![_.])\$";
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0 || !regExp.hasMatch(value))
        return "Le nom d'utilisateur est invalide";
      else
        return null;
    } else {
      _buttonPressSuccess = false;
      return null;
    }
  }

  void _onChanged() {}

  void sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _buttonPressSuccess = true;

      // print("name: $name");
      // print("username: $username");

      setState(() {
        _isButtonEnabled = false;
      });

      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => WelcomePage()));
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
                    "Création du compte",
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Calibri',
                        color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      autofocus: true,
                      maxLength: 20,
                      validator: validateName,
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
                      onSaved: (String value) {
                        name = value;
                      },
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.grey,
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextFormField(
                      maxLength: 20,
                      validator: validateUsername,
                      onTap: () {
                        setState(() {
                          _isVisible = true;
                        });
                      },
                      onSaved: (String value) {
                        username = value;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(40, 140, 100, 1.0))),
                      ),
                      onChanged: (value) {
                        isEmpty();
                        value = value.toLowerCase();
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
                            _usernameController.text.length == 0
                                ? ""
                                : "✔️ Ce nom d'utilisateur est disponible",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Calibri',
                                color: Colors.grey),
                          ),
                        ),
                      ],
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
