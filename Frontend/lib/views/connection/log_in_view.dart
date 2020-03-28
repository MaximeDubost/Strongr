import 'package:flutter/material.dart';
import 'package:strongr/services/user_service.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/global.dart' as global;
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class LogInView extends StatefulWidget {
  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  GlobalKey<FormState> _key;
  bool _validate,
      _isButtonEnabled,
      _buttonPressSuccess,
      _isLoading,
      passwordVisibility;
  TextEditingController _emailController, _passwordController;
  String email, password, warning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled =
        _buttonPressSuccess = _isLoading = passwordVisibility = false;
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" &&
            _passwordController.text.trim() != ""
        ? true
        : false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _emailController.text.trim() != "" &&
              _passwordController.text.trim() != ""
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
      return "L'identifiant est invalide";
    else
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

      dynamic result = await UserService.postLogIn(
          connectId: email.toLowerCase(), password: password);
      if (result == 200) {
        print(global.token);
        setState(() {
          _validate = false;
          warning = null;
          _isLoading = false;
          password = _passwordController.text = "";
          _isButtonEnabled = false;
          passwordVisibility = false;
        });
        Navigator.pushNamed(context, HOMEPAGE_ROUTE);
      } else if (result == 401 || result == 404) {
        setState(() {
          warning = "Identifiant ou mot de passe incorrect.";
        });
      } else // 503
      {
        setState(() {
          warning =
              "Service indisponible. Veuillez réessayer ultérieurement.";
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
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(30),
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Form(
                  key: _key,
                  autovalidate: _validate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: StrongrText("Connexion", size: 30),
                      ),
                      SizedBox(height: 30),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: StrongrText(
                            "Identifiant",
                            size: 16,
                          )),
                      SizedBox(height: 10),
                      StrongrRoundedTextFormField(
                        controller: _emailController,
                        validator: validateEmail,
                        autofocus: true,
                        onSaved: (String value) =>
                            setState(() => email = value.toLowerCase()),
                        onChanged: (String value) {
                          setState(() => warning = null);
                          isEmpty();
                        },
                        maxLength: 50,
                        hint: "Votre email ou nom d'utilisateur...",
                        textInputType: TextInputType.emailAddress,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: StrongrText(
                          "Mot de passe",
                          size: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      StrongrRoundedTextFormField(
                        controller: _passwordController,
                        validator: validatePassword,
                        obscureText: !passwordVisibility,
                        onSaved: (String value) =>
                            setState(() => password = value),
                        onChanged: (String value) {
                          setState(() => warning = null);
                          isEmpty();
                        },
                        hint: "Votre mot de passe...",
                        textInputType: TextInputType.visiblePassword,
                        suffixIcon: Icons.visibility_off,
                        suffixIconAlt: Icons.visibility,
                        onPressedSuffixIcon: () => setState(() => passwordVisibility = !passwordVisibility),
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
                      FlatButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: StrongrText(
                          "Mot de passe oublié ?",
                          size: 16,
                        ),
                      ),
                      StrongrRaisedButton(
                        "Connexion",
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
    );
  }
}
