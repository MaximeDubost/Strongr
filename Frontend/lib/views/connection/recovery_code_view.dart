import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/services/user_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class RecoveryCodeView extends StatefulWidget {
  final String email;

  RecoveryCodeView({@required this.email});

  @override
  _RecoveryCodeViewState createState() => _RecoveryCodeViewState();
}

class _RecoveryCodeViewState extends State<RecoveryCodeView> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<FormState> _key;
  bool _validate, _isButtonEnabled, _isLoading;
  TextEditingController _codeController;
  String code, warning;

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _key = GlobalKey<FormState>();
    _validate = _isLoading = false;
    _codeController = TextEditingController(text: "");
    _isButtonEnabled = _codeController.text.trim() != "" ? true : false;
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  bool isInvalid() {
    setState(() {
      _isButtonEnabled = _codeController.text.trim().length != 8 ? false : true;
    });
    return _isButtonEnabled;
  }

  // bool isInvalid() {
  //   setState(() {
  //     _isButtonEnabled = _codeController.text.trim().length < 8 ? true : false;
  //   });
  //   return _isButtonEnabled;
  // }

  String validateCode(String value) {
    String pattern = r'^[0-9]{8,8}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0 || !regExp.hasMatch(value)) {
      return "Le code est invalide";
    } else
      return null;
  }

  void resendCode() async {
    setState(() {
      _isLoading = true;
    });

    dynamic result = await UserService.postSendCode(email: widget.email.toLowerCase());
    if (result == 200) {
      setState(() {
        _validate = false;
        warning = null;
        _isLoading = false;
      });

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: StrongrColors.blue,
          content: StrongrText(
            "Code renvoyé",
            size: 18,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          content: StrongrText(
            "Le code n'a pas pu être renvoyé",
            size: 18,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      setState(() {
        _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result = await UserService.postCheckCode(email: widget.email.toLowerCase(), code: code);

      setState(() {
        code = _codeController.text = "";
      });

      if (result == 200) {
        setState(() {
          _validate = false;
          warning = null;
          _isLoading = false;
        });

        Navigator.pushNamed(
          context,
          NEW_PASSWORD_ROUTE,
          arguments: RecoveryCodeView(
            email: widget.email,
          ),
        );
        
      } else if (result == 401 || result == 404) {
        setState(() {
          warning = "Le code saisi est incorrect.";
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
      key: _scaffoldKey,
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
                                // color: Colors.red,
                                alignment: Alignment.centerLeft,
                                // width: ScreenSize.width(context) / 2,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenSize.width(context),
                                      child: Stack(
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: ScreenSize.width(context) /
                                                  1.7,
                                              alignment: Alignment.center,
                                              child: StrongrText(
                                                "Code de vérification",
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
                                    StrongrText(
                                      "Un code de vérification a été envoyé à \"" +
                                          widget.email +
                                          "\".",
                                      size: 18,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(height: 15),
                                    Container(
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
                                              isInvalid();
                                            },
                                            hint: "XXXXXXXX",
                                            textInputType: TextInputType.number,
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
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Visibility(
                                visible: warning == null ? false : true,
                                child: StrongrText(
                                  warning,
                                  size: 16,
                                  color: Colors.red,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  resendCode();
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
