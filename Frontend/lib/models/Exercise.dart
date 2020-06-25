import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:strongr/models/AppExercise.dart';
import 'package:strongr/models/Set.dart';

import 'Equipment.dart';

class Exercise {
  int id;
  String name;
  AppExercise appExercise;
  Equipment equipment;
  List<Set> sets;
  double tonnage;
  DateTime creationDate;
  DateTime lastUpdate;
  
  Exercise({
    this.id,
    this.name,
    this.appExercise,
    this.equipment,
    this.sets,
    this.tonnage,
    this.creationDate,
    this.lastUpdate,
  });

  Exercise copyWith({
    int id,
    int place,
    String name,
    AppExercise appExercise,
    Equipment equipment,
    List<Set> sets,
    double tonnage,
    DateTime creationDate,
    DateTime lastUpdate,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      appExercise: appExercise ?? this.appExercise,
      equipment: equipment ?? this.equipment,
      sets: sets ?? this.sets,
      tonnage: tonnage ?? this.tonnage,
      creationDate: creationDate ?? this.creationDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appExercise': appExercise?.toMap(),
      'equipment': equipment?.toMap(),
      'sets': sets,
      'tonnage': tonnage,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'lastUpdate': lastUpdate?.millisecondsSinceEpoch,
    };
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Exercise(
      id: map['id'],
      name: map['name'],
      appExercise: AppExercise.fromMap(map['app_exercise']),
      equipment: Equipment.fromMap(map['equipment']),
      sets: List<Set>.from(map['sets']?.map((x) => Set.fromMap(x))) ?? null,
      tonnage: map['tonnage'],
      creationDate: DateTime.parse(map['creation_date']),
      lastUpdate: DateTime.parse(map['last_update']),
    );
  }

  String toJson() => json.encode(toMap());

  static Exercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, appExercise: $appExercise, equipment: $equipment, sets: $sets, tonnage: $tonnage, creationDate: $creationDate, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Exercise &&
      o.id == id &&
      o.name == name &&
      o.appExercise == appExercise &&
      o.equipment == equipment &&
      listEquals(o.sets, sets) &&
      o.tonnage == tonnage &&
      o.creationDate == creationDate &&
      o.lastUpdate == lastUpdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      appExercise.hashCode ^
      equipment.hashCode ^
      sets.hashCode ^
      tonnage.hashCode ^
      creationDate.hashCode ^
      lastUpdate.hashCode;
  }
}
