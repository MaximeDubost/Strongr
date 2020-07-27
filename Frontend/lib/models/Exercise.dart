import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:strongr/models/AppExercise.dart';
import 'package:strongr/models/Status.dart';
import 'package:strongr/models/Set.dart';
import 'Equipment.dart';

class Exercise {
  int id;
  String name;
  AppExercise appExercise;
  Equipment equipment;
  List<Set> sets;
  int volume;
  DateTime creationDate;
  DateTime lastUpdate;
  Status status;

  Exercise({
    this.id,
    this.name,
    this.appExercise,
    this.equipment,
    this.sets,
    this.volume,
    this.creationDate,
    this.lastUpdate,
    this.status = Status.none,
  });

  Exercise copyWith({
    int id,
    int place,
    String name,
    AppExercise appExercise,
    Equipment equipment,
    List<Set> sets,
    int volume,
    DateTime creationDate,
    DateTime lastUpdate,
    Status status,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      appExercise: appExercise ?? this.appExercise,
      equipment: equipment ?? this.equipment,
      sets: sets ?? this.sets,
      volume: volume ?? this.volume,
      creationDate: creationDate ?? this.creationDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appExercise': appExercise?.toMap(),
      'equipment': equipment?.toMap(),
      'sets': sets,
      'volume': volume,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'lastUpdate': lastUpdate?.millisecondsSinceEpoch,
      'status': status,
    };
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Exercise(
      id: map['id'],
      name: map['name'],
      appExercise: AppExercise.fromMap(map['app_exercise']),
      equipment: map['equipment'].length == 0
          ? null
          : Equipment.fromMap(map['equipment']),
      sets: List<Set>.from(map['sets']?.map((x) => Set.fromMap(x))) ?? null,
      volume: map['volume'],
      creationDate: DateTime.parse(map['creation_date']),
      lastUpdate: DateTime.parse(map['last_update']),
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  static Exercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, appExercise: $appExercise, equipment: $equipment, sets: $sets, volume: $volume, creationDate: $creationDate, lastUpdate: $lastUpdate, status: $status)';
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
        o.volume == volume &&
        o.creationDate == creationDate &&
        o.lastUpdate == lastUpdate &&
        o.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        appExercise.hashCode ^
        equipment.hashCode ^
        sets.hashCode ^
        volume.hashCode ^
        creationDate.hashCode ^
        lastUpdate.hashCode ^
        status.hashCode;
  }
}
