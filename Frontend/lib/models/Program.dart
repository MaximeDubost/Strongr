import 'dart:convert';

import 'package:collection/collection.dart';

import 'Session.dart';

class Program {
  int id;
  int userId;
  String name;
  List<Session> sessionsList;
  
  Program({
    this.id,
    this.userId,
    this.name,
    this.sessionsList,
  });


  Program copyWith({
    int id,
    int userId,
    String name,
    List<Session> sessionsList,
  }) {
    return Program(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      sessionsList: sessionsList ?? this.sessionsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'sessionsList': List<dynamic>.from(sessionsList.map((x) => x.toMap())),
    };
  }

  static Program fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Program(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      sessionsList: List<Session>.from(map['sessionsList']?.map((x) => Session.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Program fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Program(id: $id, userId: $userId, name: $name, sessionsList: $sessionsList)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Program &&
      o.id == id &&
      o.userId == userId &&
      o.name == name &&
      listEquals(o.sessionsList, sessionsList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      sessionsList.hashCode;
  }
}
