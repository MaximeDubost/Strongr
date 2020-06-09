import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
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
      Response response = await http.get(
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
  static Future<Program> getProgram({@required String id}) async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/program/' + id,
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
        if(!found)
          sessionsFullList.add(SessionPreview(place: i));
      }
      program.sessions = sessionsFullList;
      return program;
    } catch (e) {
      return Program();
    }
  }
}