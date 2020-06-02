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
        headers: {
          'Authorization': 'Bearer ' + Global.token
        },
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
        headers: {
          'Authorization': 'Bearer ' + Global.token
        },
      );
      return Session.fromJson(response.body);
    } catch (e) {
      return Session();
    }
  }
}
