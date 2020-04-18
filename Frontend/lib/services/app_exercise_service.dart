import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/utils/global.dart' as global;
import 'package:strongr/models/app_exercise.dart';

class AppExerciseService {
  /// [GET] /appexercises - TODO
  ///
  /// Retourne la liste des exercices de l'application.
  static Future<List<AppExercise>> getAppExercises() async {
    Response response = await http.get(
      Uri.encodeFull(
        global.SERVER_URL + '/appexercises',
      ),
    );
    if (response.statusCode == 200) {
      List<AppExercise> appExercisesList = List<AppExercise>();
      var data = jsonDecode(response.body)["data"];
      for(final appExercise in jsonDecode(response.body)["data"] as List)
        appExercisesList.add(AppExercise.fromMap(appExercise));
      return appExercisesList;
    } else
      throw HttpException('');
  }
}