import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:strongr/models/Program.dart';
import 'package:strongr/models/ProgramPreview.dart';
import 'package:strongr/models/SessionPreview.dart';
import 'package:strongr/utils/global.dart';

class ProgramService {
  /// [GET] /programs
  ///
  /// Retourne la liste des programmes.
  static Future<List<ProgramPreview>> getPrograms() async {
    try {
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/programs',
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      List<ProgramPreview> programs = List<ProgramPreview>();
      for (final program in jsonDecode(response.body))
        programs.add(ProgramPreview.fromMap(program));
      return programs;
    } catch (e) {
      return [];
    }
  }

  /// [GET] /program/[id]
  ///
  /// Retourne le détail d'une programme [id].
  static Future<Program> getProgram({@required int id}) async {
    try {
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/program/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      Program program = Program.fromJson(response.body);
      List<SessionPreview> sessionsFullList = List<SessionPreview>();
      bool found;
      for (int i = 1; i <= 7; i++) {
        found = false;
        for (final item in program.sessions)
          if (item.place == i) {
            found = true;
            sessionsFullList.add(
              SessionPreview(
                id: item.id,
                place: item.place,
                name: item.name,
                sessionTypeName: item.sessionTypeName,
                exerciseCount: item.exerciseCount,
                tonnage: item.tonnage,
              ),
            );
          }
        if (!found) sessionsFullList.add(SessionPreview(place: i));
      }
      program.sessions = sessionsFullList;
      return program;
    } catch (e) {
      return Program();
    }
  }

  /// [POST] /program
  ///
  /// Crée un programme pour un utilisateur.
  static Future<int> postProgram({
    @required int programGoalId,
    @required String name,
    @required List<SessionPreview> sessions,
  }) async {
    List<SessionPreview> definitiveSessions = List<SessionPreview>();
    for (final item in sessions)
      if (item.id != null) definitiveSessions.add(item);
    try {
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/program',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + Global.token
        },
        body: jsonEncode({
          'id_program_goal': programGoalId,
          'name': name,
          'sessions': definitiveSessions
        }),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [PUT] /program/[id]
  ///
  /// Modifie le programme [id] d'un utilisateur.
  static Future<int> putProgram({
    @required int id,
    @required String programGoalName,
    @required String name,
    @required List<SessionPreview> sessions,
  }) async {
    try {
      Response response = await put(
        Uri.encodeFull(
          Global.SERVER_URL + '/program/' + id.toString(),
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + Global.token
        },
        body: jsonEncode({
          'program_goal_name': programGoalName,
          'name': name,
          'sessions': sessions
        }),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [DELETE] /program/[id]
  ///
  /// Supprime le programme [id] d'un utilisateur.
  static Future<int> deleteProgram({@required int id}) async {
    try {
      Response response = await delete(
        Uri.encodeFull(
          Global.SERVER_URL + '/program/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }
}
