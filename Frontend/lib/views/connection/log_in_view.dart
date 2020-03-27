import 'package:flutter/material.dart';
import 'package:strongr/services/connection_service.dart';
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
  bool _validate, _isButtonEnabled, _buttonPressSuccess, _isLoading;
  TextEditingController _emailController, _passwordController;
  String email, password;
  Future<int> futureLogIn;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled = _buttonPressSuccess = _isLoading = false;
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" &&
            _passwordController.text.trim() != ""
        ? true
        : false;
        futureLogIn = ConnectionService.postLogIn(connectId: "maxime.dubost.75@gmail.com", password: "Aaaaaa1@");
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
      return "L'adresse e-mail est invalide";
    else
      return null;
  }

  String validatePassword(String value) {
    if (!_buttonPressSuccess) {
      String pattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0 || !regExp.hasMatch(value))
        return "Le mot de passe est incorrect";
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

      dynamic result = await ConnectionService.postLogIn(connectId: email, password: password);
      if(result == 200)
      {
        print(global.token);
        setState(() {
          _isLoading = false;
          password = _passwordController.text = "";
          _isButtonEnabled = false;
        });
        Navigator.pushNamed(context, HOMEPAGE_ROUTE);
      }
      else if (result == 401)
      {

      }
      else // 503
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
      body: Stack(
        children: <Widget>[
          Container(
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
                      onSaved: (String value) => setState(() => email = value),
                      onChanged: (String value) => isEmpty(),
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
                      obscureText: true,
                      onSaved: (String value) =>
                          setState(() => password = value),
                      onChanged: (String value) => isEmpty(),
                      hint: "Votre mot de passe...",
                      textInputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 20),
                    StrongrRaisedButton(
                      "Connexion",
                      onPressed: _isButtonEnabled
                          ? () async {
                              sendToServer();
                            }
                          : null,
                    ),
                  ],
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
