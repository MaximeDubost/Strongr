import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strongr/utils/Global.dart';

class UserService {
  /// [POST] /checkEmail
  ///
  /// Vérifie la disponibilité de l'e-mail [email].
  static Future<int> postCheckEmail({@required String email}) async {
    try {
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/checkEmail',
        ),
        body: {
          'email': email,
        },
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [POST] /user/add
  ///
  /// Crée l'utilisateur avec les attributs [email], [password], [firstname], [lastname], [birthdate], [phonenumber] et [username].
  static Future<int> postSignIn({
    @required String email,
    @required String password,
    @required String firstname,
    @required String lastname,
    @required String birthdate,
    @required String phonenumber,
    @required String username,
  }) async {
    try {
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/user/add',
        ),
        body: {
          'email': email,
          'password': password,
          'firstname': firstname,
          'lastname': lastname,
          'birthdate': birthdate,
          'phonenumber': phonenumber,
          'username': username,
        },
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [POST] /login
  ///
  /// Demande la connexion de l'utilisateur [connectId] avec le mot de passe [password].
  static Future<int> postLogIn({
    @required String connectId,
    @required String password,
  }) async {
    try {
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/login',
        ),
        body: {
          'connectId': connectId,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //print(Global.prefs);

        /// Hors debug :
        var token = jsonDecode(response.body);
        prefs.setString("token", token['token']);

        /// Debug :
        //Global.setStringDebug();
      }
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [POST] /sendCode
  ///
  /// Envoie le code à l'adresse [email].
  static Future<int> postSendCode({@required String email}) async {
    try {
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/sendCode',
        ),
        body: {
          'email': email,
        },
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [POST] /checkCode
  ///
  /// Envoie le code [code].
  static Future<int> postCheckCode({
    @required String email,
    @required String code,
  }) async {
    try {
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/checkCode',
        ),
        body: {
          'email': email,
          'code': code,
        },
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [PUT] /resetPassword
  ///
  /// Modifie le mot de passe de l'utilisateur [email] avec le nouveau mot de passe [password].
  static Future<int> putResetPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      Response response = await put(
        Uri.encodeFull(
          Global.SERVER_URL + '/resetPassword',
        ),
        body: {
          'email': email,
          'password': password,
        },
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }
}
