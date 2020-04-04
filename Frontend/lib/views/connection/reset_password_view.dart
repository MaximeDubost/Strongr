import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/services/user_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/global.dart' as global;
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  GlobalKey<FormState> _key;
  bool _validate,
      isCodeSended,
      _isButtonEnabled,
      _isSendCodeButtonEnabled,
      _buttonPressSuccess,
      _isLoading,
      codeVisibility;
  TextEditingController _emailController, _codeController;
  String email, code, warning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled = _isSendCodeButtonEnabled = isCodeSended =
        _buttonPressSuccess = _isLoading = codeVisibility = false;
    _emailController = TextEditingController(text: "");
    _codeController = TextEditingController(text: "");
    _isButtonEnabled =
        _emailController.text.trim() != "" && _codeController.text.trim() != ""
            ? true
            : false;
    _isSendCodeButtonEnabled =
        _emailController.text.trim() != "" ? true : false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _codeController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _emailController.text.trim() != "" &&
              _codeController.text.trim() != ""
          ? true
          : false;
    });
    return _isButtonEnabled;
  }

  bool isEmailInputEmpty() {
    setState(() {
      _isSendCodeButtonEnabled =
          _emailController.text.trim() != "" ? true : false;
    });
    return _isButtonEnabled;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0 || !regExp.hasMatch(value)) {
      return "L'adresse e-mail est invalide";
    } else
      return null;
  }

  String validateCode(String value) {
    String pattern = r'^[0-9]{8,8}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0 || !regExp.hasMatch(value)) {
      return "Le code est invalide";
    } else
      return null;
  }

  void sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _buttonPressSuccess = true;

      // print("email: $email");
      // print("code: $code");

      setState(() {
        // code = _codeController.text = "";
        // _isButtonEnabled = false;
        _isLoading = true;
      });

      // dynamic result = await UserService.postLogIn(
      //     email: email.toLowerCase(), code: code);
      // if (result == 200) {
      //   print(global.token);
      //   setState(() {
      //     _validate = false;
      //     warning = null;
      //     _isLoading = false;
      //     code = _codeController.text = "";
      //     _isButtonEnabled = false;
      //     codeVisibility = false;
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
                        // padding: EdgeInsets.only(top: 30),
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
                                          "Changement de mot de pass",
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: BackButton(
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                               Container(
                                  alignment: Alignment.centerLeft,
                                  child: StrongrText(
                                    "Adresse e-mail",
                                    size: 16,
                                  )),
                              SizedBox(height: 10),
                              StrongrRoundedTextFormField(
                                controller: _emailController,
                                validator: validateEmail,
                                // EXCEPTION CAUGHT BY FOUNDATION LIBRARY
                                // autofocus: true,
                                onSaved: (String value) => setState(
                                    () => email = value.toLowerCase()),
                                onChanged: (String value) {
                                  setState(() => warning = null);
                                  isEmailInputEmpty();
                                },
                                maxLength: 50,
                                hint: "Adresse e-mail",
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 5),
                              Visibility(
                                visible: !isCodeSended,
                                child: StrongrRaisedButton(
                                  "Envoyer un code",
                                  onPressed: _isSendCodeButtonEnabled
                                      ? () async {
                                          FocusScope.of(context).unfocus();
                                          sendToServer();
                                        }
                                      : null,
                                ),
                              ),
                              Visibility(
                                visible: isCodeSended,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        // color: Colors.red,
                                        alignment: Alignment.centerLeft,
                                        width: ScreenSize.width(context) / 2,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: StrongrText(
                                                "Code",
                                                size: 16,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            StrongrRoundedTextFormField(
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              controller: _codeController,
                                              validator: validateCode,
                                              // obscureText: !codeVisibility,
                                              onSaved: (String value) =>
                                                  setState(() => code = value),
                                              onChanged: (String value) {
                                                setState(() => warning = null);
                                                isEmailInputEmpty();
                                              },
                                              hint: "XXXXXXXX",
                                              textInputType:
                                                  TextInputType.number,
                                              maxLength: 8,
                                              // suffixIcon: Icons.visibility_off,
                                              // suffixIconAlt: Icons.visibility,
                                              // onPressedSuffixIcon: () => setState(() =>
                                              //     codeVisibility = !codeVisibility,
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Visibility(
                                        visible: _isLoading == false &&
                                            warning != null,
                                        child: StrongrText(
                                          warning,
                                          size: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          Navigator.pushNamed(
                                              context, RESET_PASSWORD_ROUTE);
                                        },
                                        child: StrongrText(
                                          "Renvoyer un code",
                                          size: 16,
                                        ),
                                      ),
                                      StrongrRaisedButton(
                                        "Valider",
                                        onPressed: _isButtonEnabled
                                            ? () async {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                sendToServer();
                                              }
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   child: FlatButton(
                  //     onPressed: () {
                  //       FocusScope.of(context).unfocus();
                  //       Navigator.pushNamed(context, SIGN_IN_ROUTE);
                  //     },
                  //     child: StrongrText(
                  //       "Pas de compte ? Inscription",
                  //       size: 16,
                  //     ),
                  //   ),
                  // ),
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
