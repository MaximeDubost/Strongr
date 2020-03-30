import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/utils/global.dart' as global;

class UserService {

  /// [POST] /checkEmail - TODO
  /// 
  /// Vérifie la disponibilité de l'e-mail [email].
  static Future<dynamic> postCheckEmail({@required String email}) async {
    Response response = await http.post(
      Uri.encodeFull(
        global.SERVER_URL + '/checkEmail',
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

  /// [POST] /user/add - TODO
  ///
  /// Crée l'utilisateur avec les attributs [email], [username], [password], [firstName], [lastName], [birthDate] et [signDate].
  static Future<dynamic> postSignIn({@required String email, @required String username, @required String password, @required String firstName, @required String lastName, @required String birthDate, @required String signDate}) async {
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

  /// [GET] /user/[id] - TODO
  ///
  /// Retourne l'utilisateur [id].
  static Future<dynamic> getUser({@required int id}) async {
    Response response = await http.get(
      Uri.encodeFull(
        global.SERVER_URL + '/user/' + id.toString(),
      ),
    );
    if(response.statusCode == 200)
    {
      return '';
    }
    else throw HttpException('');
  }

  /// [PUT] /user/update/[id] - TODO
  ///
  /// Modifie l'utilisateur [id].
  static Future<dynamic> putUser({@required int id}) async {
    Response response = await http.put(
      Uri.encodeFull(
        global.SERVER_URL + '/user/update/' + id.toString(),
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

  /// [DELETE] /user/delete/[id] - TODO
  ///
  /// Supprime l'utilisateur [id].
  static Future<dynamic> deleteUser({@required int id}) async {
    Response response = await http.delete(
      Uri.encodeFull(
        global.SERVER_URL + '/user/delete/' + id.toString(),
      ),
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

  /// [POST] /logout - TODO
  ///
  /// Demande la déconnexion d'un utilisateur.
  static Future<dynamic> postLogOut() async {
    Response response = await http.post(
      Uri.encodeFull(
        global.SERVER_URL + '/logout',
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

  /// [POST] /sendCode - TODO
  ///
  /// Envoie le code à l'adresse [email].
  static Future<dynamic> postSendCode({@required String email}) async {
    Response response = await http.post(
      Uri.encodeFull(
        global.SERVER_URL + '/sendCode',
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

  /// [POST] /checkCode - TODO
  ///
  /// Envoie le code [code].
  static Future<dynamic> postCheckCode({@required String code}) async {
    Response response = await http.post(
      Uri.encodeFull(
        global.SERVER_URL + '/checkCode',
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

  /// [PUT] /resetPassword - TODO
  ///
  /// Modifie le mot de passe de l'utilisateur [email] avec le nouveau mot de passe [password].
  static Future<dynamic> putResetPassword({@required String email, String password}) async {
    Response response = await http.put(
      Uri.encodeFull(
        global.SERVER_URL + '/resetPassword',
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

}