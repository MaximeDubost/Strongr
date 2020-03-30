import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
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
      _buttonPressSuccess,
      _isLoading,
      passwordVisibility,
      confirmPasswordVisibility;
  TextEditingController firstNameController,
      lastNameController,
      birthdateController,
      phoneNumberController,
      usernameController;
  String firstName, lastName, birthdate, phoneNumber, username, warning;
  RegExp nameRegExp,
      birthdateRegExp,
      phoneNumberRegExp,
      usernameRegExp;
  String textInputWarning, usernameWarning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled = _buttonPressSuccess =
        _isLoading = passwordVisibility = confirmPasswordVisibility = false;
    firstNameController = TextEditingController(text: "");
    lastNameController = TextEditingController(text: "");
    birthdateController = TextEditingController(text: "");
    phoneNumberController = TextEditingController(text: "");
    usernameController = TextEditingController(text: "");
    _isButtonEnabled = firstNameController.text.trim() != "" &&
            lastNameController.text.trim() != "" &&
            birthdateController.text.trim() != "" &&
            phoneNumberController.text.trim() != "" &&
            usernameController.text.trim() != ""
        ? true
        : false;
    nameRegExp = RegExp(r'^[a-zA-ZÀ-ÿ- ]*$');
    birthdateRegExp = RegExp(r'');
    phoneNumberRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    usernameRegExp = RegExp(r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{4,15}$');
    textInputWarning = "Format invalide";
    usernameWarning = "Nom d'utilisateur invalide";
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthdateController.dispose();
    phoneNumberController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  bool isEmpty() {
    // try {
      setState(() {
        _isButtonEnabled = firstNameController.text.trim() != "" &&
                lastNameController.text.trim() != "" &&
                birthdateController.text.trim() != "" &&
                phoneNumberController.text.trim() != "" &&
                usernameController.text.trim() != ""
            ? true
            : false;
      });
      return _isButtonEnabled;
    // } catch (e) {
    //   return false;
    // }
  }

  String validator(String value, RegExp regExp, String warning,
      {bool optional = false}) {
    bool condition = optional
        ? !regExp.hasMatch(value)
        : value.length == 0 || !regExp.hasMatch(value);
    if (condition)
      return warning;
    else
      return null;
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
                                        controller: firstNameController,
                                        validator: (String value) => validator(
                                          value,
                                          nameRegExp,
                                          textInputWarning,
                                        ),
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
                                        controller: lastNameController,
                                        validator: (String value) => validator(
                                          value,
                                          nameRegExp,
                                          textInputWarning,
                                        ),
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
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ],
                                          width:
                                              ScreenSize.width(context) / 2.5,
                                          controller: birthdateController,
                                          validator: (String value) =>
                                              validator(
                                                value,
                                                birthdateRegExp,
                                                textInputWarning,
                                              ),
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
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        width: ScreenSize.width(context) / 2.5,
                                        controller: phoneNumberController,
                                        validator: (String value) => validator(
                                          value,
                                          phoneNumberRegExp,
                                          textInputWarning,
                                          optional: true,
                                        ),
                                        onSaved: (String value) =>
                                            setState(() => phoneNumber = value),
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
                                  textInputWarning,
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
