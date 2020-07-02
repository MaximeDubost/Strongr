import 'dart:convert';

import 'package:collection/collection.dart';

import 'Muscle.dart';

class TargetMusclesByExercise {
  int id;
  List<Muscle> targetMuscles;
  TargetMusclesByExercise({
    this.id,
    this.targetMuscles,
  });

  TargetMusclesByExercise copyWith({
    int id,
    List<Muscle> targetMuscles,
  }) {
    return TargetMusclesByExercise(
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

  static TargetMusclesByExercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TargetMusclesByExercise(
      id: map['id'],
      targetMuscles: List<Muscle>.from(map['target_muscles']?.map((x) => Muscle.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static TargetMusclesByExercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'TargetMusclesByExercise(id: $id, targetMuscles: $targetMuscles)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is TargetMusclesByExercise &&
      o.id == id &&
      listEquals(o.targetMuscles, targetMuscles);
  }

  @override
  int get hashCode => id.hashCode ^ targetMuscles.hashCode;
}
