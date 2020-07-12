import 'package:flutter/material.dart';
import 'package:strongr/services/UserService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
// import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/connection/sign_in_next_view.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';
// import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  GlobalKey<FormState> _key;
  bool _validate,
      _isButtonEnabled,
      _buttonPressSuccess,
      _isLoading,
      passwordVisibility,
      confirmPasswordVisibility;
  TextEditingController _emailController,
      _passwordController,
      _confirmPasswordController;
  String email, password, confirmPassword, warning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled = _buttonPressSuccess =
        _isLoading = passwordVisibility = confirmPasswordVisibility = false;
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
    _isButtonEnabled = _emailController.text.trim() != "" &&
            _passwordController.text.trim() != "" &&
            _confirmPasswordController.text.trim() != ""
        ? true
        : false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _emailController.text.trim() != "" &&
              _passwordController.text.trim() != "" &&
              _confirmPasswordController.text.trim() != ""
          ? true
          : false;
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

  String validatePassword(String value) {
    if (!_buttonPressSuccess) {
      String pattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0)
        return "Le mot de passe est invalide";
      else if (!regExp.hasMatch(value))
        return "Le format du mot de passe est invalide";
      else
        return null;
    } else {
      _buttonPressSuccess = false;
      return null;
    }
  }

  String validateConfirmPassword(String value) {
    if (!_buttonPressSuccess) {
      if (value != _passwordController.text)
        return "Les mots de passe ne sont pas identiques";
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
        _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result =
          await UserService.postCheckEmail(email: email.toLowerCase());
      if (result == 200) {
        setState(() {
          _validate = _isLoading = _isButtonEnabled =
              passwordVisibility = confirmPasswordVisibility = false;
          warning = null;
          _passwordController.text = "";
          _confirmPasswordController.text = "";
        });
        Navigator.pushNamed(
          context,
          SIGN_IN_NEXT_ROUTE,
          arguments: SignInNextView(
            email: email,
            password: password,
          ),
        );
      } else if (result == 409)
        setState(() => warning = "Cette adresse e-mail est déjà utilisée.");
      else
        setState(() => warning =
            "Service indisponible. Veuillez réessayer ultérieurement.");
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
                                alignment: Alignment.center,
                                child: StrongrText("Inscription", size: 30),
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
                                // autofocus: true,
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
                                onSaved: (String value) => setState(
                                  () => password = value,
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    password = value;
                                    warning = null;
                                  });
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
                              SizedBox(height: 5),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: StrongrText(
                                  "Confirmation mot de passe",
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              StrongrRoundedTextFormField(
                                controller: _confirmPasswordController,
                                validator: validateConfirmPassword,
                                obscureText: !confirmPasswordVisibility,
                                // onSaved: (String value) =>
                                //     setState(() => password = value),
                                onChanged: (String value) {
                                  setState(() => warning = null);
                                  isEmpty();
                                },
                                maxLength: 30,
                                hint: "Confirmation mot de passe",
                                textInputType: TextInputType.visiblePassword,
                                suffixIcon: Icons.visibility_off,
                                suffixIconAlt: Icons.visibility,
                                onPressedSuffixIcon: () => setState(() =>
                                    confirmPasswordVisibility =
                                        !confirmPasswordVisibility),
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
                                "S'inscrire",
                                onPressed: _isButtonEnabled
                                    ? () async {
                                        FocusScope.of(context).unfocus();
                                        sendToServer();
                                      }
                                    : null,
                              ),
                              // SizedBox(height: 15),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: <Widget>[
                              //     Container(
                              //       height: 2,
                              //       width: ScreenSize.width(context) / 3,
                              //       color: StrongrColors.greyA,
                              //     ),
                              //     StrongrText(
                              //       "OU",
                              //       size: 16,
                              //     ),
                              //     Container(
                              //       height: 2,
                              //       width: ScreenSize.width(context) / 3,
                              //       color: StrongrColors.greyA,
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: <Widget>[
                              //     GoogleSignInButton(
                              //       text: "S'inscrire",
                              //       onPressed: () {},
                              //     ),
                              //     FacebookSignInButton(
                              //       text: "S'inscrire",
                              //       onPressed: () {},
                              //     ),
                              //   ],
                              // ),
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
                        Navigator.pop(context);
                      },
                      child: StrongrText(
                        "Déjà un compte ? Connexion",
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
