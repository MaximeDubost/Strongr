import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/services/UserService.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/widgets/strongr_raised_button.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class NewPasswordView extends StatefulWidget {
  final String email;

  NewPasswordView({this.email});

  @override
  _NewPasswordViewState createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  GlobalKey<FormState> _key;
  bool _validate,
      _isButtonEnabled,
      _buttonPressSuccess,
      _isLoading,
      passwordVisibility,
      confirmPasswordVisibility;
  TextEditingController _passwordController, _confirmPasswordController;
  String password, confirmPassword, warning;

  @override
  void initState() {
    _key = GlobalKey();
    _validate = _isButtonEnabled = _buttonPressSuccess =
        _isLoading = passwordVisibility = confirmPasswordVisibility = false;
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
    _isButtonEnabled = _passwordController.text.trim() != "" &&
            _confirmPasswordController.text.trim() != ""
        ? true
        : false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  bool isEmpty() {
    setState(() {
      _isButtonEnabled = _passwordController.text.trim() != "" &&
              _confirmPasswordController.text.trim() != ""
          ? true
          : false;
    });
    return _isButtonEnabled;
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

  String validateConfirmPassword(String value) {
    if (!_buttonPressSuccess) {
      String pattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0 ||
          !regExp.hasMatch(value) ||
          value != _passwordController.text)
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

      setState(() {
        _isButtonEnabled = false;
        _isLoading = true;
      });

      dynamic result = await UserService.putResetPassword(email: widget.email.toLowerCase(), password: password);
      if (result == 200) {
        setState(() {
          _validate = false;
          warning = null;
          _isLoading = false;
          _isButtonEnabled = true;
        });

        Navigator.pushNamedAndRemoveUntil(
          context,
          LOG_IN_ROUTE,
          (Route<dynamic> route) => false
        );
      } 
      else // 503 ou Exception()
      {
        setState(() {
          warning = "Une erreur est survenue. Veuillez réessayer ultérieurement.";
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
                                          "Nouveau mot de passe",
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
                                    setState(() => password = value,
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
                                "Terminer",
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
