import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/services/user_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_rounded_datepicker.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SignInNextView extends StatefulWidget {
  final String email;
  final String password;

  SignInNextView({@required this.email, @required this.password});

  @override
  _SignInNextViewState createState() => _SignInNextViewState();
}

class _SignInNextViewState extends State<SignInNextView> {
  GlobalKey<FormState> _key;
  bool _validate,
      _isButtonEnabled,
      _isLoading,
      passwordVisibility,
      confirmPasswordVisibility;
  TextEditingController firstnameController,
      lastnameController,
      phonenumberController,
      usernameController;
  String firstname, lastname, birthdate, phonenumber, username, warning;
  RegExp nameRegExp, phonenumberRegExp, usernameRegExp;
  String textInputWarning, usernameWarning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled =
        _isLoading = passwordVisibility = confirmPasswordVisibility = false;
    firstnameController = TextEditingController(text: "");
    lastnameController = TextEditingController(text: "");
    phonenumberController = TextEditingController(text: "");
    usernameController = TextEditingController(text: "");
    _isButtonEnabled = firstnameController.text.trim() != "" &&
            lastnameController.text.trim() != "" &&
            (birthdate != "" || birthdate != null) &&
            // phonenumberController.text.trim() != "" &&
            usernameController.text.trim() != ""
        ? true
        : false;
    nameRegExp = RegExp(r'^[a-zA-ZÀ-ÿ- ]*$');
    phonenumberRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    usernameRegExp = RegExp(r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{3,29}$');
    textInputWarning = "Format invalide";
    usernameWarning = "Nom d'utilisateur invalide";
    super.initState();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    phonenumberController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  bool isEmpty() {
    // try {
    setState(() {
      _isButtonEnabled = firstnameController.text.trim() != "" &&
              lastnameController.text.trim() != "" &&
              birthdate != null &&
              // phonenumberController.text.trim() != "" &&
              usernameController.text.trim() != ""
          ? true
          : false;
    });
    return _isButtonEnabled;
    // } catch (e) {
    //   return false;
    // }
  }

  String validator(String value, RegExp regExp, String warning, {bool optional = false}) {
    bool condition;
    if(optional)
    {
      condition = value.length == 0 ? false : !regExp.hasMatch(value);
    }
    else
    {
      condition = value.length == 0 || !regExp.hasMatch(value);
    }
    if (condition)
      return warning;
    else
      return null;
  }

  void sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      // _buttonPressSuccess = true;

      // print("email: $email");
      // print("password: $password");

      setState(() {
        // password = _passwordController.text = "";
        // _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result = await UserService.postSignIn(
        email: widget.email,
        password: widget.password,
        firstname: firstname,
        lastname: lastname,
        birthdate: birthdate,
        phonenumber: phonenumber,
        username: username,
      );
      if (result == 201) {
        setState(() {
          _validate = false;
          warning = null;
          _isLoading = false;
          _isButtonEnabled = false;
          passwordVisibility = false;
          confirmPasswordVisibility = false;
        });
        Navigator.pushNamedAndRemoveUntil(context, HOMEPAGE_ROUTE, (Route<dynamic> route) => false);
      } else if (result == 409) {
        setState(() {
          warning = "Ce nom d'utilisateur n'est pas disponible.";
        });
      } else // 503
      {
        setState(() {
          warning = "Service indisponible. Veuillez réessayer ultérieurement.";
        });
      }
      setState(() {
        _isLoading = false;
      });
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
                                        controller: firstnameController,
                                        validator: (String value) => validator(
                                          value,
                                          nameRegExp,
                                          textInputWarning,
                                        ),
                                        autofocus: true,
                                        onSaved: (String value) =>
                                            setState(() => firstname = value),
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
                                        controller: lastnameController,
                                        validator: (String value) => validator(
                                          value,
                                          nameRegExp,
                                          textInputWarning,
                                        ),
                                        onSaved: (String value) =>
                                            setState(() => lastname = value),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      StrongrRoundedDatePicker(
                                        width: ScreenSize.width(context) / 2.5,
                                        text: birthdate,
                                        textColor: birthdate != null
                                            ? StrongrColors.black
                                            : null,
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          showDatePicker(
                                            context: context,
                                            initialDate: birthdate == null ||
                                                    birthdate == ""
                                                ? DateTime.now()
                                                : DateTime.parse(birthdate),
                                            firstDate: DateTime.now().subtract(
                                                Duration(days: 36500)),
                                            lastDate: DateTime.now(),
                                            locale: Locale('fr'),
                                          ).then((date) {
                                            if (date != null) {
                                              setState(() {
                                                birthdate = date.toString();
                                                warning = null;
                                              });
                                              isEmpty();
                                            }
                                          });
                                        },
                                      )
                                      // StrongrRoundedTextFormField(
                                      //   inputFormatters: [
                                      //     WhitelistingTextInputFormatter
                                      //         .digitsOnly
                                      //   ],
                                      //   width: ScreenSize.width(context) / 2.5,
                                      //   controller: birthdateController,
                                      //   validator: (String value) => validator(
                                      //     value,
                                      //     birthdateRegExp,
                                      //     textInputWarning,
                                      //   ),
                                      //   onSaved: (String value) =>
                                      //       setState(() => birthdate = value),
                                      //   onChanged: (String value) {
                                      //     setState(() => warning = null);
                                      //     isEmpty();
                                      //   },
                                      //   maxLength: 10,
                                      //   hint: "jj/mm/aaaa",
                                      //   textInputType: TextInputType.datetime,
                                      // ),
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
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        width: ScreenSize.width(context) / 2.5,
                                        controller: phonenumberController,
                                        validator: (String value) => validator(
                                          value,
                                          phonenumberRegExp,
                                          textInputWarning,
                                          optional: true,
                                        ),
                                        onSaved: (String value) =>
                                            setState(() => phonenumber = value),
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
                                controller: usernameController,
                                validator: (String value) => validator(
                                  value,
                                  usernameRegExp,
                                  usernameWarning,
                                ),
                                onSaved: (String value) =>
                                    setState(() => username = value),
                                onChanged: (String value) {
                                  setState(() => warning = null);
                                  isEmpty();
                                },
                                maxLength: 30,
                                hint: 'Caractères autorisés : ( . ) et ( _ )',
                                textInputType: TextInputType.text,
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
                              SizedBox(height: 10),
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
