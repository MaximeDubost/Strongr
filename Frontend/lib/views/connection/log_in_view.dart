import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strongr/services/UserService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
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
  TextEditingController _connectIdController, _passwordController;
  String connectId, password, warning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled =
        _buttonPressSuccess = _isLoading = passwordVisibility = false;
    _connectIdController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _isButtonEnabled = _connectIdController.text.trim() != "" &&
            _passwordController.text.trim() != ""
        ? true
        : false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _connectIdController.dispose();
    _passwordController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _connectIdController.text.trim() != "" &&
              _passwordController.text.trim() != ""
          ? true
          : false;
    });
    return _isButtonEnabled;
  }

  String validateConnectId(String value) {
    String pattern;
    String result;
    if (value.contains('@')) {
      pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      result = "L'adresse e-mail est invalide";
    } else {
      pattern = r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{4,15}$';
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

  void sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _buttonPressSuccess = true;

      setState(() {
        // password = _passwordController.text = "";
        _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result = await UserService.postLogIn(
        connectId: connectId.toLowerCase(),
        password: password,
      );
      if (result == 200) {
        // SharedPreferences prefs = 
        await SharedPreferences.getInstance();
        // print("TOKEN : " + prefs.getString("token"));
        setState(() {
          _validate = false;
          warning = null;
          _isLoading = false;
          password = _passwordController.text = "";
          _isButtonEnabled = false;
          passwordVisibility = false;
        });
        Navigator.pushNamedAndRemoveUntil(context, HOMEPAGE_ROUTE, ModalRoute.withName(LOG_IN_ROUTE));
      } else if (result == 401 || result == 404) {
        setState(() {
          warning = "Identifiant ou mot de passe incorrect.";
        });
      } else // 503
      {
        setState(() {
          warning = "Service indisponible. Veuillez réessayer ultérieurement.";
        });
      }
      setState(() {
        password = _passwordController.text = "";
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
                                controller: _connectIdController,
                                validator: validateConnectId,
                                // EXCEPTION CAUGHT BY FOUNDATION LIBRARY
                                // autofocus: true,
                                onSaved: (String value) => setState(
                                    () => connectId = value.toLowerCase()),
                                onChanged: (String value) {
                                  setState(() => warning = null);
                                  isEmpty();
                                },
                                maxLength: 50,
                                hint: "Nom d'utilisateur ou adresse e-mail",
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 5),
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
                                maxLength: 30,
                                hint: "Mot de passe",
                                textInputType: TextInputType.visiblePassword,
                                suffixIcon: Icons.visibility_off,
                                suffixIconAlt: Icons.visibility,
                                onPressedSuffixIcon: () => setState(() =>
                                    passwordVisibility = !passwordVisibility),
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
                                  Navigator.pushNamed(
                                      context, RESET_PASSWORD_ROUTE);
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
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pushNamed(context, SIGN_IN_ROUTE);
                      },
                      child: StrongrText(
                        "Pas de compte ? Inscription",
                        size: 16,
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
