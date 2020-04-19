import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/utils/global.dart' as global;
import 'package:strongr/models/app_exercise.dart';

class AppExerciseService {
  /// [GET] /appexercises
  ///
  /// Retourne la liste des exercices de l'application.
  static Future<List<AppExercise>> getAppExercises() async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          global.SERVER_URL + '/appexercises',
        ),
      );
      List<AppExercise> appExercisesList = List<AppExercise>();
      for(final appExercise in jsonDecode(response.body)['data'] as List)
        appExercisesList.add(AppExercise.fromMap(appExercise));
      return appExercisesList;
    }
    catch (e)
    {
      return [];
    }
    // return [];
  }
}