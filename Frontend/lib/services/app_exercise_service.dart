import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/utils/Global.dart';
import 'package:strongr/models/AppExercise.dart';

class AppExerciseService {
  /// [GET] /appexercises
  ///
  /// Retourne la liste des exercices de l'application.
  static Future<List<AppExercise>> getAppExercises() async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/appexercises',
        ),
      );
      List<AppExercise> appExercisesList = List<AppExercise>();
      for (final appExercise in jsonDecode(response.body))
        appExercisesList.add(AppExercise.fromMap(appExercise));
      return appExercisesList;
    } catch (e) {
      return [];
    }
  }

  /// [GET] /appexercise/[id]
  ///
  /// Retourne les détails de l'exercice [id] de l'application.
  static Future<AppExercise> getAppExercise({@required int id}) async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/appexercise/' + id.toString(),
        ),
      );
      return AppExercise.fromJson(response.body);
    } catch (e) {
      return AppExercise();
    }
  }
}
