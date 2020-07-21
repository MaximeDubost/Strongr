import 'dart:convert';

class ProgramPreview {
  int id;
  String name;
  String programGoalName;
  String sessionCount;
  int volume;

  ProgramPreview({
    this.id,
    this.name,
    this.programGoalName,
    this.sessionCount,
    this.volume,
  });

  ProgramPreview copyWith({
    int id,
    String name,
    String programGoalName,
    String sessionCount,
    int volume,
  }) {
    return ProgramPreview(
      id: id ?? this.id,
      name: name ?? this.name,
      programGoalName: programGoalName ?? this.programGoalName,
      sessionCount: sessionCount ?? this.sessionCount,
      volume: volume ?? this.volume,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'programGoalName': programGoalName,
      'sessionCount': sessionCount,
      'volume': volume,
    };
  }

  static ProgramPreview fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProgramPreview(
      id: map['id'],
      name: map['name'],
      programGoalName: map['program_goal_name'],
      sessionCount: map['session_count'],
      volume: map['volume'],
    );
  }

  String toJson() => json.encode(toMap());

  static ProgramPreview fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProgramPreview(id: $id, name: $name, programGoalName: $programGoalName, sessionCount: $sessionCount, volume: $volume)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProgramPreview &&
      o.id == id &&
      o.name == name &&
      o.programGoalName == programGoalName &&
      o.sessionCount == sessionCount &&
      o.volume == volume;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      programGoalName.hashCode ^
      sessionCount.hashCode ^
      volume.hashCode;
  }
}
