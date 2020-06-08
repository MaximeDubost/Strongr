import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/models/Program.dart';
import 'package:strongr/models/ProgramPreview.dart';
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
        headers: {
          'Authorization': 'Bearer ' + Global.token
        },
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
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/program/' + id.toString(),
        ),
        headers: {
          'Authorization': 'Bearer ' + Global.token
        },
      );
      return Program.fromJson(response.body);
    } catch (e) {
      return Program();
    }
  }
}
