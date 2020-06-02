import 'dart:convert';
import 'package:collection/collection.dart';
import 'ExercisePreview.dart';

class Session {
  int id;
  int place;
  String name;
  String sessionTypeName;
  List<ExercisePreview> exercises;
  double tonnage;
  DateTime creationDate;
  DateTime lastUpdate;

  Session({
    this.id,
    this.place,
    this.name,
    this.sessionTypeName,
    this.exercises,
    this.tonnage,
    this.creationDate,
    this.lastUpdate,
  });

  Session copyWith({
    int id,
    int place,
    String name,
    String sessionTypeName,
    List<ExercisePreview> exercises,
    double tonnage,
    DateTime creationDate,
    DateTime lastUpdate,
  }) {
    return Session(
      id: id ?? this.id,
      place: place ?? this.place,
      name: name ?? this.name,
      sessionTypeName: sessionTypeName ?? this.sessionTypeName,
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
      'sessionTypeName': sessionTypeName,
      'exercises': exercises?.map((x) => x?.toMap())?.toList(),
      'tonnage': tonnage,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'lastUpdate': lastUpdate?.millisecondsSinceEpoch,
    };
  }

  static Session fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Session(
      id: map['id'],
      place: map['place'],
      name: map['name'],
      sessionTypeName: map['session_type_name'],
      exercises: List<ExercisePreview>.from(map['exercises']?.map((x) => ExercisePreview.fromMap(x))),
      tonnage: map['tonnage'],
      creationDate: DateTime.parse(map['creation_date']),
      lastUpdate: DateTime.parse(map['last_update']),
    );
  }

  String toJson() => json.encode(toMap());

  static Session fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Session(id: $id, place: $place, name: $name, sessionTypeName: $sessionTypeName, exercises: $exercises, tonnage: $tonnage, creationDate: $creationDate, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Session &&
      o.id == id &&
      o.place == place &&
      o.name == name &&
      o.sessionTypeName == sessionTypeName &&
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
      sessionTypeName.hashCode ^
      exercises.hashCode ^
      tonnage.hashCode ^
      creationDate.hashCode ^
      lastUpdate.hashCode;
  }
}
