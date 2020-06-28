import 'package:flutter/foundation.dart';
import 'package:strongr/models/ProgramGoal.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:strongr/utils/global.dart';

class ProgramGoalService
{
  /// [GET] /programgoals
  ///
  /// Retourne la liste des objectifs de programme.
  static Future<List<ProgramGoal>> getProgramGoals() async {
    try {
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/programgoals',
        ),
      );
      List<ProgramGoal> programGoals = List<ProgramGoal>();
      for (final programGoal in jsonDecode(response.body))
        programGoals.add(ProgramGoal.fromMap(programGoal));
      return programGoals;
    } catch (e) {
      return [];
    }
  }

  /// [GET] /programgoal/[id]
  ///
  /// Retourne l'objectif de programme [id].
  static Future<ProgramGoal> getProgramGoal({@required int id}) async {
    try {
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/programgoal/' + id.toString(),
        ),
      );
      return ProgramGoal.fromJson(response.body);
    } catch (e) {
      return ProgramGoal();
    }
  }
}