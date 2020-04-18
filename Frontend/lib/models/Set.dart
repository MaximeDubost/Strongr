import 'dart:convert';

class Set {
  int id;
  int repetitionsCount;
  int restTime;
  int expectedPerformance;
  int realizedPerformance;
  
  Set({
    this.id,
    this.repetitionsCount,
    this.restTime,
    this.expectedPerformance,
    this.realizedPerformance,
  });

  Set copyWith({
    int id,
    int repetitionsCount,
    int restTime,
    int expectedPerformance,
    int realizedPerformance,
  }) {
    return Set(
      id: id ?? this.id,
      repetitionsCount: repetitionsCount ?? this.repetitionsCount,
      restTime: restTime ?? this.restTime,
      expectedPerformance: expectedPerformance ?? this.expectedPerformance,
      realizedPerformance: realizedPerformance ?? this.realizedPerformance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'repetitionsCount': repetitionsCount,
      'restTime': restTime,
      'expectedPerformance': expectedPerformance,
      'realizedPerformance': realizedPerformance,
    };
  }

  static Set fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Set(
      id: map['id'],
      repetitionsCount: map['repetitionsCount'],
      restTime: map['restTime'],
      expectedPerformance: map['expectedPerformance'],
      realizedPerformance: map['realizedPerformance'],
    );
  }

  String toJson() => json.encode(toMap());

  static Set fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Set(id: $id, repetitionsCount: $repetitionsCount, restTime: $restTime, expectedPerformance: $expectedPerformance, realizedPerformance: $realizedPerformance)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Set &&
      o.id == id &&
      o.repetitionsCount == repetitionsCount &&
      o.restTime == restTime &&
      o.expectedPerformance == expectedPerformance &&
      o.realizedPerformance == realizedPerformance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      repetitionsCount.hashCode ^
      restTime.hashCode ^
      expectedPerformance.hashCode ^
      realizedPerformance.hashCode;
  }
}
