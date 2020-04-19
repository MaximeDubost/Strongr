import 'dart:convert';

import 'package:collection/collection.dart';

import 'set.dart';

class Exercise {
  int id;
  int userId;
  String name;
  List<Set> setsList; 
  
  Exercise({
    this.id,
    this.userId,
    this.name,
    this.setsList,
  });

  Exercise copyWith({
    int id,
    int userId,
    String name,
    List<Set> setsList,
  }) {
    return Exercise(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      setsList: setsList ?? this.setsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'setsList': List<dynamic>.from(setsList.map((x) => x.toMap())),
    };
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Exercise(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      setsList: List<Set>.from(map['setsList']?.map((x) => Set.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Exercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(id: $id, userId: $userId, name: $name, setsList: $setsList)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is Exercise &&
      o.id == id &&
      o.userId == userId &&
      o.name == name &&
      listEquals(o.setsList, setsList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      setsList.hashCode;
  }
}
