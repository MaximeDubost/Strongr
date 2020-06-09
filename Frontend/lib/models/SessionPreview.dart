import 'dart:convert';

class SessionPreview {
  int id;
  int place;
  String name;
  String sessionTypeName;
  String exerciseCount;
  double tonnage;

  SessionPreview({
    this.id,
    this.place,
    this.name,
    this.sessionTypeName,
    this.exerciseCount,
    this.tonnage,
  });

  SessionPreview copyWith({
    int id,
    int place,
    String name,
    String sessionTypeName,
    String exerciseCount,
    double tonnage,
  }) {
    return SessionPreview(
      id: id ?? this.id,
      place: place ?? this.place,
      name: name ?? this.name,
      sessionTypeName: sessionTypeName ?? this.sessionTypeName,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      tonnage: tonnage ?? this.tonnage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'name': name,
      'sessionTypeName': sessionTypeName,
      'exerciseCount': exerciseCount,
      'tonnage': tonnage,
    };
  }

  static SessionPreview fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SessionPreview(
      id: map['id'],
      place: map['place'],
      name: map['name'],
      sessionTypeName: map['session_type_name'],
      exerciseCount: map['exercise_count'],
      tonnage: map['tonnage'],
    );
  }

  String toJson() => json.encode(toMap());

  static SessionPreview fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'SessionPreview(id: $id, place: $place, name: $name, sessionTypeName: $sessionTypeName, exerciseCount: $exerciseCount, tonnage: $tonnage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is SessionPreview &&
      o.id == id &&
      o.place == place &&
      o.name == name &&
      o.sessionTypeName == sessionTypeName &&
      o.exerciseCount == exerciseCount &&
      o.tonnage == tonnage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      place.hashCode ^
      name.hashCode ^
      sessionTypeName.hashCode ^
      exerciseCount.hashCode ^
      tonnage.hashCode;
  }
}
