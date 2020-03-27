import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/utils/global.dart' as global;

class ConnectionService {

  /// [POST] /user/add
  ///
  /// Description
  Future<dynamic> postSignIn({String email, String username, String password, String firstName, String lastName, String birthDate, String signDate}) async {
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
  /// Description
  Future<dynamic> postLogIn({String email, String username, String password}) async {
    Response response = await http.post(
      Uri.encodeFull(
        global.SERVER_URL + '/login',
      ),
      body: {
        'connectId' : '',
        'password' : '',
      }
    );
    if(response.statusCode == 200)
    {
      print(response.headers);
      print(response.body);
      return 'OK';
    }
    else throw HttpException('');
  }

}