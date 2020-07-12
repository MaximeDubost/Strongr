import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/Session.dart';
import 'package:strongr/models/SessionPreview.dart';
import 'package:strongr/models/SessionType.dart';
import 'package:strongr/utils/global.dart';

class SessionService {
  /// [GET] /sessions
  ///
  /// Retourne la liste des sessions d'un utilisateur.
  static Future<List<SessionPreview>> getSessions() async {
    try {
      String token = await Global.getToken();
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/sessions',
        ),
        headers: {'Authorization': 'Bearer ' + token},
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
  /// Retourne le détail d'une session [id] d'un utilisateur.
  static Future<Session> getSession({@required int id}) async {
    try {
      String token = await Global.getToken();
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/session/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + token},
      );
      return Session.fromJson(response.body);
    } catch (e) {
      return Session();
    }
  }

  /// [POST] /session
  ///
  /// Crée une séance pour un utilisateur.
  static Future<int> postSession({
    @required String name,
    @required SessionType sessionType,
    @required List<ExercisePreview> exercises,
  }) async {
    try {
      String token = await Global.getToken();
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/session',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: jsonEncode(
            {'id_session_type': sessionType.id, 'name': name, 'exercises': exercises}),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [PUT] /session/[id]
  ///
  /// Modifie la séance [id] d'un utilisateur.
  static Future<int> putSession({
    @required int id,
    @required String name,
    @required SessionType sessionType,
    @required List<ExercisePreview> exercises,
  }) async {
    try {
      String token = await Global.getToken();
      Response response = await put(
        Uri.encodeFull(
          Global.SERVER_URL + '/session/' + id.toString(),
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: jsonEncode({
          'name': name,
          'session_type': sessionType,
          'exercises': exercises,
        }),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [DELETE] /session/[id]
  ///
  /// Supprime la séance [id] d'un utilisateur.
  static Future<int> deleteSession({@required int id}) async {
    try {
      String token = await Global.getToken();
      Response response = await delete(
        Uri.encodeFull(
          Global.SERVER_URL + '/session/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + token},
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [GET] /sessiontype/[id]
  ///
  /// Retourne le détail d'un type de session [id].
  static Future<SessionType> getSessionType({@required int id}) async {
    try {
      String token = await Global.getToken();
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/sessiontype/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + token},
      );
      return SessionType.fromJson(response.body);
    } catch (e) {
      return SessionType();
    }
  }
}
