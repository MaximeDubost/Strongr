import 'dart:convert';
import 'package:collection/collection.dart';
import 'ExercisePreview.dart';
import 'SessionType.dart';

class Session {
  int id;
  int place;
  String name;
  SessionType sessionType;
  List<ExercisePreview> exercises;
  int volume;
  DateTime creationDate;
  DateTime lastUpdate;

  Session({
    this.id,
    this.place,
    this.name,
    this.sessionType,
    this.exercises,
    this.volume,
    this.creationDate,
    this.lastUpdate,
  });

  Session copyWith({
    int id,
    int place,
    String name,
    SessionType sessionType,
    List<ExercisePreview> exercises,
    int volume,
    DateTime creationDate,
    DateTime lastUpdate,
  }) {
    return Session(
      id: id ?? this.id,
      place: place ?? this.place,
      name: name ?? this.name,
      sessionType: sessionType ?? this.sessionType,
      exercises: exercises ?? this.exercises,
      volume: volume ?? this.volume,
      creationDate: creationDate ?? this.creationDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'name': name,
      'sessionType': sessionType?.toMap(),
      'exercises': exercises?.map((x) => x?.toMap())?.toList(),
      'volume': volume,
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
      sessionType: SessionType.fromMap(map['session_type']),
      exercises: List<ExercisePreview>.from(map['exercises']?.map((x) => ExercisePreview.fromMap(x))),
      volume: map['volume'],
      creationDate: DateTime.parse(map['creation_date']),
      lastUpdate: DateTime.parse(map['last_update']),
    );
  }

  String toJson() => json.encode(toMap());

  static Session fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Session(id: $id, place: $place, name: $name, sessionType: $sessionType, exercises: $exercises, volume: $volume, creationDate: $creationDate, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Session &&
      o.id == id &&
      o.place == place &&
      o.name == name &&
      o.sessionType == sessionType &&
      listEquals(o.exercises, exercises) &&
      o.volume == volume &&
      o.creationDate == creationDate &&
      o.lastUpdate == lastUpdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      place.hashCode ^
      name.hashCode ^
      sessionType.hashCode ^
      exercises.hashCode ^
      volume.hashCode ^
      creationDate.hashCode ^
      lastUpdate.hashCode;
  }
}
