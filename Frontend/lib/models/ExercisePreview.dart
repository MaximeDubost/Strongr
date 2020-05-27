import 'dart:convert';

class ExercisePreview {
 int id;
 String name;
 String appExerciseName;
 String setCount;
 double tonnage;

  ExercisePreview({
    this.id,
    this.name,
    this.appExerciseName,
    this.setCount,
    this.tonnage,
  });

  ExercisePreview copyWith({
    int id,
    String name,
    String appExerciseName,
    int setCount,
    double tonnage,
  }) {
    return ExercisePreview(
      id: id ?? this.id,
      name: name ?? this.name,
      appExerciseName: appExerciseName ?? this.appExerciseName,
      setCount: setCount ?? this.setCount,
      tonnage: tonnage ?? this.tonnage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appExerciseName': appExerciseName,
      'setCount': setCount,
      'tonnage': tonnage,
    };
  }

  static ExercisePreview fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ExercisePreview(
      id: map['id'],
      name: map['name'],
      appExerciseName: map['app_exercise_name'],
      setCount: map['set_count'],
      tonnage: map['tonnage'],
    );
  }

  String toJson() => json.encode(toMap());

  static ExercisePreview fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExercisePreview(id: $id, name: $name, appExerciseName: $appExerciseName, setCount: $setCount, tonnage: $tonnage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ExercisePreview &&
      o.id == id &&
      o.name == name &&
      o.appExerciseName == appExerciseName &&
      o.setCount == setCount &&
      o.tonnage == tonnage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      appExerciseName.hashCode ^
      setCount.hashCode ^
      tonnage.hashCode;
  }
}
