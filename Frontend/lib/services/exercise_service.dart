import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/utils/Global.dart';
import 'package:strongr/models/Set.dart';

class ExerciseService {
  /// [POST] /exercise/create
  ///
  /// Crée un exercice pour un utilisateur.
  static Future<int> postExercise({@required String name, @required List<Set> sets}) async {
    try {
      Response response = await http.post(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/create',
        ),
        body: {
          'name': name,
          'sets': sets,
        },
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [GET] /exercise/read
  ///
  /// Retourne la liste des exercices d'un utilisateur.
  static Future<List<Exercise>> getExercises() async {
    try {
      Response response = await http.get(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/read',
        ),
        headers: {
          'Authorization': 'Bearer ' + Global.token
        }
      );
      List<Exercise> exercises = List<Exercise>();
      for (final exercise in jsonDecode(response.body))
        exercises.add(Exercise.fromMap(exercise));
      return exercises;
    } catch (e) {
      return [];
    }
  }

  /// [PUT] /exercise/update/[id]
  ///
  /// Modifie l'exercice [id] d'un utilisateur.
  static Future<int> putExercise({@required int id}) async {
    try {
      Response response = await http.put(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/update/' + id.toString(),
        ),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }

  /// [DELETE] /exercise/delete/[id]
  ///
  /// Supprime l'exercice [id] d'un utilisateur.
  static Future<int> deleteExercise({@required int id}) async {
    try {
      Response response = await http.delete(
        Uri.encodeFull(
          Global.SERVER_URL + '/exercise/delete/' + id.toString(),
        ),
      );
      return response.statusCode;
    } catch (e) {
      return 503;
    }
  }
}
