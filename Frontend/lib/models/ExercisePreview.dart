import 'dart:convert';

class ExercisePreview {
 int id;
 int place;
 String name;
 String appExerciseName;
 String setCount;
 int volume;

  ExercisePreview({
    this.id,
    this.place,
    this.name,
    this.appExerciseName,
    this.setCount,
    this.volume,
  });

  ExercisePreview copyWith({
    int id,
    int place,
    String name,
    String appExerciseName,
    int setCount,
    int volume,
  }) {
    return ExercisePreview(
      id: id ?? this.id,
      place: place ?? this.place,
      name: name ?? this.name,
      appExerciseName: appExerciseName ?? this.appExerciseName,
      setCount: setCount ?? this.setCount,
      volume: volume ?? this.volume,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'name': name,
      'appExerciseName': appExerciseName,
      'setCount': setCount,
      'volume': volume,
    };
  }

  static ExercisePreview fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ExercisePreview(
      id: map['id'],
      place: map['place'],
      name: map['name'],
      appExerciseName: map['app_exercise_name'],
      setCount: map['set_count'],
      volume: map['volume'],
    );
    // try
    // {
    //   return ExercisePreview(
    //     id: map['id'],
    //     place: map['place'],
    //     name: null,
    //     appExerciseName: map['app_exercise_name'],
    //     setCount: map['set_count'],
    //     volume: map['volume'],
    //   );
    // } 
    // catch(e)
    // {
    //   return ExercisePreview(
    //     id: map['id'],
    //     place: null,
    //     name: map['name'],
    //     appExerciseName: map['app_exercise_name'],
    //     setCount: map['set_count'],
    //     volume: map['volume'],
    //   );
    // }
  }

  String toJson() => json.encode(toMap());

  static ExercisePreview fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExercisePreview(id: $id, place: $place, name: $name, appExerciseName: $appExerciseName, setCount: $setCount, volume: $volume)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ExercisePreview &&
      o.id == id &&
      o.place == place &&
      o.name == name &&
      o.appExerciseName == appExerciseName &&
      o.setCount == setCount &&
      o.volume == volume;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      place.hashCode ^
      name.hashCode ^
      appExerciseName.hashCode ^
      setCount.hashCode ^
      volume.hashCode;
  }
}
