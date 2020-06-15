import 'dart:convert';

import 'package:strongr/models/Exercise.dart';

class SessionExercise {
  int place;
  Exercise exercise;
  
  SessionExercise({
    this.place,
    this.exercise,
  });

  SessionExercise copyWith({
    int place,
    Exercise exercise,
  }) {
    return SessionExercise(
      place: place ?? this.place,
      exercise: exercise ?? this.exercise,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'exercise': exercise?.toMap(),
    };
  }

  static SessionExercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SessionExercise(
      place: map['place'],
      exercise: Exercise.fromMap(map['exercise']),
    );
  }

  String toJson() => json.encode(toMap());

  static SessionExercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'SessionExercise(place: $place, exercise: $exercise)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is SessionExercise &&
      o.place == place &&
      o.exercise == exercise;
  }

  @override
  int get hashCode => place.hashCode ^ exercise.hashCode;
}
