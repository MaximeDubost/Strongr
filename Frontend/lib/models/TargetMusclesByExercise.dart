import 'dart:convert';

import 'package:collection/collection.dart';

import 'Muscle.dart';

class ExerciseTargetMuscles {
  int id;
  List<Muscle> targetMuscles;

  ExerciseTargetMuscles({
    this.id,
    this.targetMuscles,
  });

  ExerciseTargetMuscles copyWith({
    int id,
    List<Muscle> targetMuscles,
  }) {
    return ExerciseTargetMuscles(
      id: id ?? this.id,
      targetMuscles: targetMuscles ?? this.targetMuscles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'targetMuscles': targetMuscles?.map((x) => x?.toMap())?.toList(),
    };
  }

  static ExerciseTargetMuscles fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ExerciseTargetMuscles(
      id: map['id'],
      targetMuscles: List<Muscle>.from(map['target_muscles']?.map((x) => Muscle.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static ExerciseTargetMuscles fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'ExerciseTargetMuscles(id: $id, targetMuscles: $targetMuscles)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is ExerciseTargetMuscles &&
      o.id == id &&
      listEquals(o.targetMuscles, targetMuscles);
  }

  @override
  int get hashCode => id.hashCode ^ targetMuscles.hashCode;
}
