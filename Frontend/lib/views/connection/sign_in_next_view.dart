import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/models/Bodyweight.dart';
import 'package:strongr/services/UserService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/dialogs/bodyweight_dialog.dart';
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
      confirmPasswordVisibility,
      isLb;
  TextEditingController firstnameController,
      lastnameController,
      phonenumberController,
      usernameController;
  String firstname, lastname, birthdate, phonenumber, username, warning;
  Bodyweight bodyweight;
  RegExp nameRegExp, phonenumberRegExp, usernameRegExp;
  String textInputWarning, usernameWarning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled = _isLoading =
        passwordVisibility = confirmPasswordVisibility = isLb = false;
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
    bodyweight = Bodyweight();
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

  String validator(String value, RegExp regExp, String warning,
      {bool optional = false}) {
    bool condition;
    if (optional) {
      condition = value.length == 0 ? false : !regExp.hasMatch(value);
    } else {
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

      setState(() {
        _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result = await UserService.postSignIn(
        email: widget.email,
        password: widget.password,
        firstname: firstname,
        lastname: lastname,
        birthdate: birthdate,
        username: username.toLowerCase(),
        bodyweight: bodyweight.value != null ? bodyweight.toKg() : null,
        phonenumber: phonenumber,
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
        int statusCode = await UserService.postLogIn(
            connectId: widget.email, password: widget.password);
        if (statusCode == 200)
          Navigator.pushNamedAndRemoveUntil(
              context, HOMEPAGE_ROUTE, (Route<dynamic> route) => false);
      } else if (result == 409) {
        setState(() {
          warning = "Ce nom d'utilisateur n'est pas disponible.";
        });
      } else if (result == 123) {
        setState(() {
          warning = "OK";
        });
      }
      else // 503
      {
        setState(() {
          warning = "Service indisponible. Veuillez réessayer ultérieurement.";
        });
      }
      setState(() {
        _isButtonEnabled = true;
        _isLoading = false;
      });
    } 
    else setState(() => _validate = true);
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
                                width: ScreenSize.width(context),
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        width: ScreenSize.width(context) / 1.7,
                                        alignment: Alignment.center,
                                        child: StrongrText(
                                          "Finalisation de l'inscription",
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: BackButton(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  buildFirstnameInput(),
                                  buildLastnameInput(),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  buildBirthdateInput(),
                                  buildUsernameInput(),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  buildBodyweightInput(),
                                  buildPhoneNumberInput(),
                                ],
                              ),
                              SizedBox(height: 5),
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

  Widget buildFirstnameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: StrongrText(
            "Prénom",
            size: 16,
          ),
        ),
        SizedBox(height: 5),
        StrongrRoundedTextFormField(
          textCapitalization: TextCapitalization.words,
          width: ScreenSize.width(context) / 2.5,
          controller: firstnameController,
          validator: (String value) => validator(
            value,
            nameRegExp,
            textInputWarning,
          ),
          autofocus: true,
          onSaved: (String value) => setState(() => firstname = value),
          onChanged: (String value) {
            setState(() => warning = null);
            isEmpty();
          },
          maxLength: 30,
          hint: "Prénom",
          textInputType: TextInputType.text,
        ),
      ],
    );
  }

  Widget buildLastnameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: StrongrText(
            "Nom",
            size: 16,
          ),
        ),
        SizedBox(height: 5),
        StrongrRoundedTextFormField(
          textCapitalization: TextCapitalization.words,
          width: ScreenSize.width(context) / 2.5,
          controller: lastnameController,
          validator: (String value) => validator(
            value,
            nameRegExp,
            textInputWarning,
          ),
          onSaved: (String value) => setState(() => lastname = value),
          onChanged: (String value) {
            setState(() => warning = null);
            isEmpty();
          },
          maxLength: 30,
          hint: "Nom",
          textInputType: TextInputType.text,
        ),
      ],
    );
  }

  Widget buildBodyweightInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: StrongrText(
            "Poids",
            size: 16,
          ),
        ),
        SizedBox(height: 5),
        // StrongrRoundedTextFormField(
        //   textCapitalization: TextCapitalization.words,
        //   width: ScreenSize.width(context) / 2.5,
        //   controller: lastnameController,
        //   validator: (String value) => validator(
        //     value,
        //     nameRegExp,
        //     textInputWarning,
        //   ),
        //   onSaved: (String value) => setState(() => lastname = value),
        //   onChanged: (String value) {
        //     setState(() => warning = null);
        //     isEmpty();
        //   },
        //   maxLength: 30,
        //   hint: "(Facultatif)",
        //   textInputType: TextInputType.text,
        // ),
        Container(
          height: 60,
          width: ScreenSize.width(context) / 2.5,
          decoration: new BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black54, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              showDialog(
                context: context,
                builder: (context) => BodyweightDialog(
                  bodyweight: bodyweight.value != null ? bodyweight : Bodyweight(value: 62.0, isLb: isLb),
                ),
              ).then((newBodyweight) {
                if (newBodyweight != null) {
                  setState(() {
                    bodyweight = newBodyweight;
                    isLb = newBodyweight.isLb;
                  });
                }
              });
            },
            child: Container(
              width: ScreenSize.width(context) / 2.5,
              child: Text(
                bodyweight.value != null
                    ? bodyweight.value.toString() +
                        (!bodyweight.isLb ? " kg" : " lbs")
                    : "(Facultatif)",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: bodyweight.value != null ? StrongrColors.black : Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: StrongrText(
            "Téléphone",
            size: 16,
          ),
        ),
        SizedBox(height: 5),
        StrongrRoundedTextFormField(
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          width: ScreenSize.width(context) / 2.5,
          controller: phonenumberController,
          validator: (String value) => validator(
            value,
            phonenumberRegExp,
            textInputWarning,
            optional: true,
          ),
          onSaved: (String value) => setState(() => phonenumber = value),
          onChanged: (String value) {
            setState(() => warning = null);
            isEmpty();
          },
          maxLength: 15,
          hint: "(Facultatif)",
          textInputType: TextInputType.number,
        ),
      ],
    );
  }

  Widget buildBirthdateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: StrongrText(
            "Date de naissance",
            size: 16,
          ),
        ),
        SizedBox(height: 5),
        StrongrRoundedDatePicker(
          width: ScreenSize.width(context) / 2.5,
          text: birthdate,
          textColor: birthdate != null ? StrongrColors.black : null,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            showDatePicker(
              context: context,
              initialDate: birthdate == null || birthdate == ""
                  ? DateTime.now().subtract(Duration(days: 5840))
                  : DateTime.parse(birthdate),
              firstDate: DateTime.now().subtract(Duration(days: 36500)),
              lastDate: DateTime.now().subtract(Duration(days: 5840)),
              // .subtract(Duration(days: 5840)),
              // locale: Locale('fr'),
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
    );
  }

  Widget buildUsernameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: StrongrText(
            "Nom d'utilisateur",
            size: 16,
          ),
        ),
        SizedBox(height: 5),
        StrongrRoundedTextFormField(
          controller: usernameController,
          width: ScreenSize.width(context) / 2.5,
          validator: (String value) => validator(
            value,
            usernameRegExp,
            usernameWarning,
          ),
          onSaved: (String value) => setState(() => username = value),
          onChanged: (String value) {
            setState(() => warning = null);
            isEmpty();
          },
          maxLength: 30,
          hint: 'Autorisé : (.) & (_)',
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}
