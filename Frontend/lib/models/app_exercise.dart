import 'dart:convert';

import 'package:collection/collection.dart';

import 'equipment.dart';
import 'muscle.dart';

class AppExercise {
  int id;
  String name;
  List<Muscle> muscleList;
  List<Equipment> equipmentList;
  
  AppExercise({
    this.id,
    this.name,
    this.muscleList,
    this.equipmentList,
  });

  AppExercise copyWith({
    int id,
    String name,
    List<Muscle> muscleList,
    List<Equipment> equipmentList,
  }) {
    return AppExercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleList: muscleList ?? this.muscleList,
      equipmentList: equipmentList ?? this.equipmentList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'muscleList': List<dynamic>.from(muscleList.map((x) => x.toMap())),
      'equipmentList': List<dynamic>.from(equipmentList.map((x) => x.toMap())),
    };
  }

  static AppExercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return AppExercise(
      id: map['id'],
      name: map['name'],
      muscleList: List<Muscle>.from(map['muscleList']?.map((x) => Muscle.fromMap(x))) ?? null,
      equipmentList: List<Equipment>.from(map['equipmentList']?.map((x) => Equipment.fromMap(x))) ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  static AppExercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppExercise(id: $id, name: $name, muscleList: $muscleList, equipmentList: $equipmentList)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is AppExercise &&
      o.id == id &&
      o.name == name &&
      listEquals(o.muscleList, muscleList) &&
      listEquals(o.equipmentList, equipmentList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      muscleList.hashCode ^
      equipmentList.hashCode;
  }
}
