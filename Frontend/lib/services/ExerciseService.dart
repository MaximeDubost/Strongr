import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/TargetMusclesByExercise.dart';
import 'package:strongr/utils/Global.dart';
import 'package:strongr/models/Set.dart';

class ExerciseService {
  /// [GET] /exercises
  ///
  /// Retourne la liste des exercices d'un utilisateur.
  static Future<List<ExercisePreview>> getExercises() async {
    try {
      String token = await Global.getToken();
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercises',
        ),
        headers: {'Authorization': 'Bearer ' + token},
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
  /// Retourne le détail d'un exercice [id] d'un utilisateur.
  static Future<Exercise> getExercise({@required int id}) async {
    try {
      String token = await Global.getToken();
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + token},
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
      String token = await Global.getToken();
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token
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
  /// Modifie l'exercice [id] d'un utilisateur.
  static Future<int> putExercise({
    @required int id,
    @required int equipmentId,
    @required String name,
    @required List<Set> sets,
  }) async {
    try {
      String token = await Global.getToken();
      Response response = await put(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/' + id.toString(),
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: jsonEncode({
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

  /// [DELETE] /exercise/[id]
  ///
  /// Supprime l'exercice [id] d'un utilisateur.
  static Future<int> deleteExercise({@required int id}) async {
    try {
      String token = await Global.getToken();
      Response response = await delete(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/' + id.toString(),
        ),
        headers: {'Authorization': 'Bearer ' + token},
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [POST] /exercises/targetmuscles
  ///
  /// Retourne la liste des muscles ciblés de chaque exercice dont les id sont passés en POST
  static Future<List<ExerciseTargetMuscles>> targetMusclesByExercise(List<int> exerciseIDs) async {
    try {
      String token = await Global.getToken();
      Response response = await post(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercises/targetmuscles',
        ),
        headers: {'Authorization': 'Bearer ' + token},
        body: {
          'id_exercises': jsonEncode(exerciseIDs),
        }
      );
      List<ExerciseTargetMuscles> exercises = List<ExerciseTargetMuscles>();
      for (final exercise in jsonDecode(response.body))
        exercises.add(ExerciseTargetMuscles.fromMap(exercise));
      return exercises;
    } catch (e) {
      return [];
    }
  }
}
