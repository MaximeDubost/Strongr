import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:strongr/models/ProgramGoal.dart';

import 'SessionPreview.dart';

class Program {
  int id;
  String name;
  ProgramGoal programGoal;
  List<SessionPreview> sessions;
  double tonnage;
  DateTime creationDate;
  DateTime lastUpdate;

  Program({
    this.id,
    this.name,
    this.programGoal,
    this.sessions,
    this.tonnage,
    this.creationDate,
    this.lastUpdate,
  });

  Program copyWith({
    int id,
    int place,
    String name,
    String programGoalName,
    List<SessionPreview> sessions,
    double tonnage,
    DateTime creationDate,
    DateTime lastUpdate,
  }) {
    return Program(
      id: id ?? this.id,
      name: name ?? this.name,
      programGoal: programGoal ?? this.programGoal,
      sessions: sessions ?? this.sessions,
      tonnage: tonnage ?? this.tonnage,
      creationDate: creationDate ?? this.creationDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'programGoalName': programGoal,
      'sessions': sessions?.map((x) => x?.toMap())?.toList(),
      'tonnage': tonnage,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'lastUpdate': lastUpdate?.millisecondsSinceEpoch,
    };
  }

  static Program fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Program(
      id: map['id'],
      name: map['name'],
      programGoal: ProgramGoal.fromMap(map['program_goal']),
      sessions: List<SessionPreview>.from(map['sessions']?.map((x) => SessionPreview.fromMap(x))),
      tonnage: map['tonnage'],
      creationDate: DateTime.parse(map['creation_date']),
      lastUpdate: DateTime.parse(map['last_update']),
    );
  }

  String toJson() => json.encode(toMap());

  static Program fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Program(id: $id, name: $name, programGoal: $programGoal, sessions: $sessions, tonnage: $tonnage, creationDate: $creationDate, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Program &&
      o.id == id &&
      o.name == name &&
      o.programGoal == programGoal &&
      listEquals(o.sessions, sessions) &&
      o.tonnage == tonnage &&
      o.creationDate == creationDate &&
      o.lastUpdate == lastUpdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      programGoal.hashCode ^
      sessions.hashCode ^
      tonnage.hashCode ^
      creationDate.hashCode ^
      lastUpdate.hashCode;
  }
}
