import 'dart:convert';

import 'package:collection/collection.dart';

import 'SessionPreview.dart';

class Program {
  int id;
  int place;
  String name;
  String programGoalName;
  List<SessionPreview> exercises;
  double tonnage;
  DateTime creationDate;
  DateTime lastUpdate;

  Program({
    this.id,
    this.place,
    this.name,
    this.programGoalName,
    this.exercises,
    this.tonnage,
    this.creationDate,
    this.lastUpdate,
  });

  Program copyWith({
    int id,
    int place,
    String name,
    String programGoalName,
    List<SessionPreview> exercises,
    double tonnage,
    DateTime creationDate,
    DateTime lastUpdate,
  }) {
    return Program(
      id: id ?? this.id,
      place: place ?? this.place,
      name: name ?? this.name,
      programGoalName: programGoalName ?? this.programGoalName,
      exercises: exercises ?? this.exercises,
      tonnage: tonnage ?? this.tonnage,
      creationDate: creationDate ?? this.creationDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'name': name,
      'programGoalName': programGoalName,
      'exercises': exercises?.map((x) => x?.toMap())?.toList(),
      'tonnage': tonnage,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'lastUpdate': lastUpdate?.millisecondsSinceEpoch,
    };
  }

  static Program fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Program(
      id: map['id'],
      place: map['place'],
      name: map['name'],
      programGoalName: map['program_goal_name'],
      exercises: List<SessionPreview>.from(map['exercises']?.map((x) => SessionPreview.fromMap(x))),
      tonnage: map['tonnage'],
      creationDate: DateTime.parse(map['creation_date']),
      lastUpdate: DateTime.parse(map['last_update']),
    );
  }

  String toJson() => json.encode(toMap());

  static Program fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Program(id: $id, place: $place, name: $name, programGoalName: $programGoalName, exercises: $exercises, tonnage: $tonnage, creationDate: $creationDate, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Program &&
      o.id == id &&
      o.place == place &&
      o.name == name &&
      o.programGoalName == programGoalName &&
      listEquals(o.exercises, exercises) &&
      o.tonnage == tonnage &&
      o.creationDate == creationDate &&
      o.lastUpdate == lastUpdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      place.hashCode ^
      name.hashCode ^
      programGoalName.hashCode ^
      exercises.hashCode ^
      tonnage.hashCode ^
      creationDate.hashCode ^
      lastUpdate.hashCode;
  }
}
