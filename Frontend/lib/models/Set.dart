import 'dart:convert';

class Set {
  int id;
  int place;
  int repetitionCount;
  int restTime;
  int volume;

  Set({
    this.id,
    this.place,
    this.repetitionCount,
    this.restTime,
    this.volume,
  });

  Set copyWith({
    int id,
    int place,
    int repetitionCount,
    int restTime,
    int volume,
  }) {
    return Set(
      id: id ?? this.id,
      place: place ?? this.place,
      repetitionCount: repetitionCount ?? this.repetitionCount,
      restTime: restTime ?? this.restTime,
      volume: volume ?? this.volume,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id
      'place': place,
      'repetitions_count': repetitionCount,
      'rest_time': restTime,
      //'volume': 'volume'
    };
  }

  static Set fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Set(
      id: map['id'],
      place: map['place'],
      repetitionCount: map['repetitions_count'],
      restTime: map['rest_time'],
      volume: map['volume'],
    );
  }

  String toJson() => json.encode(toMap());

  static Set fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    if (id != null) {
      return 'Set(id: $id, place: $place, repetitionCount: $repetitionCount, restTime: $restTime, volume: $volume)';
    } else {
      return 'Set(place: $place, repetitionCount: $repetitionCount, restTime: $restTime)';
    }
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Set &&
        o.id == id &&
        o.place == place &&
        o.repetitionCount == repetitionCount &&
        o.restTime == restTime &&
        o.volume == volume;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        place.hashCode ^
        repetitionCount.hashCode ^
        restTime.hashCode ^
        volume.hashCode;
  }
}
