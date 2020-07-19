import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/services/UserService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/connection/recovery_code_view.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  GlobalKey<FormState> _key;
  bool _validate, _isButtonEnabled, _isLoading;
  TextEditingController _emailController;
  String email, warning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isLoading = false;
    _emailController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" ? true : false;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
    if (value.length == 0 || !regExp.hasMatch(value)) {
      return "L'adresse e-mail est invalide";
    } else
      return null;
  }

  void sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      setState(() {
        _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result =
          await UserService.postSendCode(email: email.toLowerCase());
      if (result == 200) {
        setState(() {
          _validate = false;
          warning = null;
          _isLoading = false;
          _isButtonEnabled = true;
        });

        Navigator.pushNamed(
          context,
          RECOVERY_CODE_ROUTE,
          arguments: RecoveryCodeView(
            email: email,
          ),
        );
      } else if (result == 404) {
        setState(() {
          warning = "Cette adresse e-mail ne correspond à aucun compte.";
        });
      } else // 503
      {
        setState(() {
          warning = "Service indisponible. Veuillez réessayer ultérieurement.";
        });
      }
      setState(() {
        _isButtonEnabled = true;
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
                                          "Changement de mot de passe",
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
                                onSaved: (String value) =>
                                    setState(() => email = value.toLowerCase()),
                                onChanged: (String value) {
                                  setState(() => warning = null);
                                  isEmpty();
                                },
                                maxLength: 50,
                                hint: "Adresse e-mail",
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 5),
                              Visibility(
                                visible: warning == null ? false : true,
                                child: StrongrText(
                                  warning,
                                  color: Colors.red,
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              FloatingActionButton.extended(
                                backgroundColor:
                                    _isButtonEnabled
                                        ? StrongrColors.black
                                        : Colors.grey,
                                label: StrongrText(
                                  "Envoyer un code",
                                  color: Colors.white,
                                ),
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
