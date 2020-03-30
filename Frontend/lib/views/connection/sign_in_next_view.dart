import 'package:flutter/material.dart';
import 'package:strongr/services/user_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/global.dart' as global;
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class SignInNextView extends StatefulWidget {
  @override
  _SignInNextViewState createState() => _SignInNextViewState();
}

class _SignInNextViewState extends State<SignInNextView> {
  GlobalKey<FormState> _key;
  bool _validate,
      _isButtonEnabled,
      _buttonPressSuccess,
      _isLoading,
      passwordVisibility,
      confirmPasswordVisibility;
  TextEditingController _emailController,
      _passwordController,
      _confirmPasswordController;
  String firstName, lastName, birthdate, phoneNumber, username, warning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled = _buttonPressSuccess =
        _isLoading = passwordVisibility = confirmPasswordVisibility = false;
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" &&
            _passwordController.text.trim() != "" &&
            _confirmPasswordController.text.trim() != ""
        ? true
        : false;
    super.initState();
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
    String pattern;
    String result;
    if (value.contains('@')) {
      pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      result = "L'adresse e-mail est invalide";
    } else {
      pattern = r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$';
      result = "Le nom d'utilisateur est invalide";
    }

    RegExp regExp = new RegExp(pattern);
    if (value.length == 0 || !regExp.hasMatch(value)) {
      return result;
    } else
      return null;
  }

  String validatePassword(String value) {
    if (!_buttonPressSuccess) {
      String pattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0 || !regExp.hasMatch(value))
        return "Le mot de passe est invalide";
      else
        return null;
    } else {
      _buttonPressSuccess = false;
      return null;
    }
  }

  String validateConfirmPassword(String value) {
    if (!_buttonPressSuccess) {
      String pattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0 ||
          !regExp.hasMatch(value) ||
          value != _passwordController.text)
        return "Les mots de passe ne sont pas identiques";
      else
        return null;
    } else {
      _buttonPressSuccess = false;
      return null;
    }
  }

  void sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _buttonPressSuccess = true;

      // print("email: $email");
      // print("password: $password");

      setState(() {
        // password = _passwordController.text = "";
        // _isButtonEnabled = false;
        _isLoading = true;
      });

      // dynamic result = await UserService.postLogIn(
      //     email: email.toLowerCase(), password: password);
      // if (result == 200) {
      //   print(global.token);
      //   setState(() {
      //     _validate = false;
      //     warning = null;
      //     _isLoading = false;
      //     password = _passwordController.text = "";
      //     _isButtonEnabled = false;
      //     passwordVisibility = false;
      //     confirmPasswordVisibility = false;
      //   });
      //   Navigator.pushNamed(context, HOMEPAGE_ROUTE);
      // } else if (result == 401 || result == 404) {
      //   setState(() {
      //     warning = "Identifiant ou mot de passe incorrect.";
      //   });
      // } else // 503
      // {
      //   setState(() {
      //     warning = "Service indisponible. Veuillez réessayer ultérieurement.";
      //   });
      // }
      // setState(() {
      //   _isLoading = false;
      // });
    } else
      setState(() {
        _validate = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(30),
                      child: Container(
                        child: Form(
                          key: _key,
                          autovalidate: _validate,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      child: StrongrText(
                                        "Finalisation de l'inscription",
                                        size: 30,
                                      ),
                                    ),
                                    BackButton(
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: StrongrText(
                                          "Prénom",
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      StrongrRoundedTextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        width: ScreenSize.width(context) / 2.5,
                                        controller: null,
                                        validator: null,
                                        autofocus: true,
                                        onSaved: (String value) =>
                                            setState(() => firstName = value),
                                        onChanged: (String value) {
                                          setState(() => warning = null);
                                          isEmpty();
                                        },
                                        maxLength: 30,
                                        hint: "Prénom",
                                        textInputType: TextInputType.text,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: StrongrText(
                                          "Nom",
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      StrongrRoundedTextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        width: ScreenSize.width(context) / 2.5,
                                        controller: null,
                                        validator: null,
                                        onSaved: (String value) =>
                                            setState(() => lastName = value),
                                        onChanged: (String value) {
                                          setState(() => warning = null);
                                          isEmpty();
                                        },
                                        maxLength: 30,
                                        hint: "Nom",
                                        textInputType: TextInputType.text,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: StrongrText(
                                          "Date de naissance",
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      StrongrRoundedTextFormField(
                                          width:
                                              ScreenSize.width(context) / 2.5,
                                          controller: null,
                                          validator: null,
                                          autofocus: true,
                                          onSaved: (String value) =>
                                              setState(() => birthdate = value),
                                          onChanged: (String value) {
                                            setState(() => warning = null);
                                            isEmpty();
                                          },
                                          maxLength: 10,
                                          hint: "jj/mm/aaaa",
                                          textInputType:
                                              TextInputType.datetime),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: StrongrText(
                                          "Téléphone",
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      StrongrRoundedTextFormField(
                                        width: ScreenSize.width(context) / 2.5,
                                        controller: null,
                                        validator: null,
                                        onSaved: (String value) =>
                                            setState(() => lastName = value),
                                        onChanged: (String value) {
                                          setState(() => warning = null);
                                          isEmpty();
                                        },
                                        maxLength: 15,
                                        hint: "(Facultatif)",
                                        textInputType: TextInputType.number,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: StrongrText(
                                  "Nom d'utilisateur",
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              StrongrRoundedTextFormField(
                                textCapitalization: TextCapitalization.words,
                                controller: null,
                                validator: null,
                                onSaved: (String value) =>
                                    setState(() => lastName = value),
                                onChanged: (String value) {
                                  setState(() => warning = null);
                                  isEmpty();
                                },
                                maxLength: 30,
                                hint: 'Caractères autorisés : ( . ) et ( _ )',
                                textInputType: TextInputType.number,
                              ),
                              SizedBox(height: 10),
                              Visibility(
                                visible: _isLoading == false && warning != null,
                                child: StrongrText(
                                  warning,
                                  size: 16,
                                  color: Colors.red,
                                ),
                              ),
                              StrongrRaisedButton(
                                "Finaliser l'inscription",
                                width: ScreenSize.width(context) / 1.5,
                                onPressed: _isButtonEnabled
                                    ? () async {
                                        FocusScope.of(context).unfocus();
                                        sendToServer();
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.black,
                  height: ScreenSize.height(context),
                  width: ScreenSize.width(context),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
