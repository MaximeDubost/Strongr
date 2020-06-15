import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/models/Session.dart';
import 'package:strongr/models/SessionPreview.dart';
import 'package:strongr/utils/global.dart';

class SessionService {
  /// [GET] /sessions
  ///
  /// Retourne la liste des sessions.
  static Future<List<SessionPreview>> getSessions() async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/sessions',
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      List<SessionPreview> sessions = List<SessionPreview>();
      for (final session in jsonDecode(response.body))
        sessions.add(SessionPreview.fromMap(session));
      return sessions;
    } catch (e) {
      return [];
    }
  }

  /// [GET] /session/[id]
  ///
  /// Retourne le détail d'une session [id].
  static Future<Session> getSession({@required int id}) async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/session/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      return Session.fromJson(response.body);
    } catch (e) {
      return Session();
    }
  }
}

/* /// [POST] /session
  ///
  /// Crée une seance pour un utilisateur.
  static Future<int> postSession({
    @required int sessionTypeId,
    @required String name,
    @required List<SessionExercise> exercises,
  }) async {
    print(exercises);

    var body = {
      'sessionTypeId':sessionTypeId,
      'name': name,
      'exercises': exercises
    };

    try {
      Response response = await http.post(
        Uri.encodeFull(
          Global.SERVER_URL + '/session',
        ),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + Global.token,
        },
        body: jsonEncode(body),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  } */
