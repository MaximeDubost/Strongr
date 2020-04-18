import 'dart:convert';

import 'package:collection/collection.dart';

import 'exercise.dart';

class Session {
  int id;
  int userId;
  String name;
  List<Exercise> exerciseList;
  
  Session({
    this.id,
    this.userId,
    this.name,
    this.exerciseList,
  });

  Session copyWith({
    int id,
    int userId,
    String name,
    List<Exercise> exerciseList,
  }) {
    return Session(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      exerciseList: exerciseList ?? this.exerciseList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'exerciseList': List<dynamic>.from(exerciseList.map((x) => x.toMap())),
    };
  }

  static Session fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Session(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      exerciseList: List<Exercise>.from(map['exerciseList']?.map((x) => Exercise.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Session fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Session(id: $id, userId: $userId, name: $name, exerciseList: $exerciseList)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Session &&
      o.id == id &&
      o.userId == userId &&
      o.name == name &&
      listEquals(o.exerciseList, exerciseList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      exerciseList.hashCode;
  }
}
