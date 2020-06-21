import 'package:strongr/models/ProgramGoal.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:strongr/utils/global.dart';

class ProgramGoalService
{
  /// [GET] /programgoals
  ///
  /// Retourne la liste des equipements de l'exercice [idAppExercise] de l'application.
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
}