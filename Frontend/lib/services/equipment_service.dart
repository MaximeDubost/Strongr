import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:strongr/models/Equipment.dart';
import 'package:strongr/utils/global.dart';

class EquipmentService {
  /// [GET] /equipments/[idAppExercise]
  ///
  /// Retourne la liste des equipements de l'exercice [idAppExercise] de l'application.
  static Future<List<Equipment>> getEquipmentsOfAppExercise({@required int idAppExercise}) async {
    try {
      Response response = await get(
        Uri.encodeFull(
          Global.SERVER_URL + '/equipments/appexercise/' + idAppExercise.toString(),
        ),
      );
      List<Equipment> equipmentList = List<Equipment>();
      for (final equipment in jsonDecode(response.body))
        equipmentList.add(Equipment.fromMap(equipment));
      return equipmentList;
    } catch (e) {
      return [];
    }
  }
}