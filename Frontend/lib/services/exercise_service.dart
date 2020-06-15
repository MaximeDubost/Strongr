import 'dart:async';
import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/utils/Global.dart';
import 'package:strongr/models/Set.dart';

class ExerciseService {
  /// [GET] /exercises
  ///
  /// Retourne la liste des exercices.
  static Future<List<ExercisePreview>> getExercises() async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercises',
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      List<ExercisePreview> exercises = List<ExercisePreview>();
      for (final exercise in jsonDecode(response.body))
        exercises.add(ExercisePreview.fromMap(exercise));
      return exercises;
    } catch (e) {
      return [];
    }
  }

  /// [GET] /exercise/[id]
  ///
  /// Retourne le détail d'un exercice [id].
  static Future<Exercise> getExercise({@required int id}) async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      return Exercise.fromJson(response.body);
    } catch (e) {
      return Exercise();
    }
  }

  /// [POST] /exercise
  ///
  /// Crée un exercice pour un utilisateur.
  static Future<int> postExercise({
    @required int appExerciseId,
    @required int equipmentId,
    @required String name,
    @required List<Set> sets,
  }) async {
    try {
      Response response = await http.post(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + Global.token
        },
        body: jsonEncode({
          'id_app_exercise': appExerciseId,
          'id_equipment': equipmentId,
          'name': name,
          'sets': sets
        }),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [PUT] /exercise/[id]
  ///
  /// Modifie l'exercice [id].
  static Future<int> putExercise({@required int id}) async {
    try {
      Response response = await http.put(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [DELETE] /exercise/[id]
  ///
  /// Supprime l'exercice [id] d'un utilisateur.
  static Future<int> deleteExercise({@required int id}) async {
    try {
      Response response = await http.delete(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + Global.token},
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }
}
