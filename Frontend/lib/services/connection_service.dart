import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/utils/global.dart' as global;

class ConnectionService {

  /// [POST] /user/add
  ///
  /// Description
  static Future<dynamic> postSignIn({String email, String username, String password, String firstName, String lastName, String birthDate, String signDate}) async {
    Response response = await http.post(
      Uri.encodeFull(
        global.SERVER_URL + '/user/add',
      ),
      body: {
        '' : '',
      }
    );
    if(response.statusCode == 200)
    {
      return '';
    }
    else throw HttpException('');
  }

  /// [POST] /login
  ///
  /// Demande la connexion de l'utilisateur [connectId] avec le mot de passe [password].
  static Future<int> postLogIn({@required String connectId, @required String password}) async {
    try {
      Response response = await http.post(
        Uri.encodeFull(
          global.SERVER_URL + '/login',
        ),
        body: {
          'connectId' : connectId,
          'password' : password,
        }
      );
      if(response.statusCode == 200)
        global.token = response.headers['authorization'];
      return response.statusCode;
    }
    catch (e)
    {
      return 503;
    }
    
  }

}