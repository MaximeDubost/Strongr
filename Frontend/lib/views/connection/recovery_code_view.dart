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
  TextEditingController _emailController;
  String email, warning;

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _key = GlobalKey<FormState>();
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

      setState(() {
        _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result = 200;
      // await UserService.postSendCode(email: email.toLowerCase());
      if (result == 200) {
        setState(() {
          _validate = false;
          warning = null;
          _isLoading = false;
          _isButtonEnabled = true;
        });

        // Navigator.pushNamed(context, RECOVERY_CODE_ROUTE);
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
                                            child: BackButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
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
                                            controller: null,
                                            validator: null,
                                            // obscureText: !codeVisibility,
                                            onSaved: (String value) {},
                                            // setState(() => code = value),
                                            onChanged: (String value) {},
                                            //   setState(() => warning = null);
                                            //   isEmailInputEmpty();
                                            // },
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
                                  // FocusScope.of(context).unfocus();
                                  // Navigator.pushNamed(
                                  //     context, NEW_PASSWORD_ROUTE);
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
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
                                },
                                child: StrongrText(
                                  "Renvoyer un code",
                                  size: 16,
                                ),
                              ),
                              StrongrRaisedButton(
                                "Valider",
                                // onPressed: _isButtonEnabled
                                //     ? () async {
                                //         FocusScope.of(context)
                                //             .unfocus();
                                //         sendToServer();
                                //       }
                                //     : null,
                                onPressed: () {},
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
