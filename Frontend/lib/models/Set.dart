import 'dart:convert';

class Set {
  int id;
  int place;
  int repetitionCount;
  int restTime;
  double tonnage;

  Set({
    this.id,
    this.place,
    this.repetitionCount,
    this.restTime,
    this.tonnage,
  });

  Set copyWith({
    int id,
    int place,
    int repetitionCount,
    int restTime,
    double tonnage,
  }) {
    return Set(
      id: id ?? this.id,
      place: place ?? this.place,
      repetitionCount: repetitionCount ?? this.repetitionCount,
      restTime: restTime ?? this.restTime,
      tonnage: tonnage ?? this.tonnage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'repetitionCount': repetitionCount,
      'restTime': restTime,
      'tonnage': tonnage,
    };
  }

  static Set fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Set(
      id: map['id'],
      place: map['place'],
      repetitionCount: map['repetition_count'],
      restTime: map['rest_time'],
      tonnage: map['tonnage'],
    );
  }

  String toJson() => json.encode(toMap());

  static Set fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Set(id: $id, place: $place, repetitionCount: $repetitionCount, restTime: $restTime, tonnage: $tonnage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Set &&
      o.id == id &&
      o.place == place &&
      o.repetitionCount == repetitionCount &&
      o.restTime == restTime &&
      o.tonnage == tonnage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      place.hashCode ^
      repetitionCount.hashCode ^
      restTime.hashCode ^
      tonnage.hashCode;
  }
}
