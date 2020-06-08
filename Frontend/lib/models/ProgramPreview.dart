import 'dart:convert';

class ProgramPreview {
  int id;
  String name;
  String programGoalName;
  String sessionCount;
  double tonnage;

  ProgramPreview({
    this.id,
    this.name,
    this.programGoalName,
    this.sessionCount,
    this.tonnage,
  });

  ProgramPreview copyWith({
    int id,
    String name,
    String programGoalName,
    String sessionCount,
    double tonnage,
  }) {
    return ProgramPreview(
      id: id ?? this.id,
      name: name ?? this.name,
      programGoalName: programGoalName ?? this.programGoalName,
      sessionCount: sessionCount ?? this.sessionCount,
      tonnage: tonnage ?? this.tonnage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'programGoalName': programGoalName,
      'sessionCount': sessionCount,
      'tonnage': tonnage,
    };
  }

  static ProgramPreview fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProgramPreview(
      id: map['id'],
      name: map['name'],
      programGoalName: map['program_goal_name'],
      sessionCount: map['session_count'],
      tonnage: map['tonnage'],
    );
  }

  String toJson() => json.encode(toMap());

  static ProgramPreview fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProgramPreview(id: $id, name: $name, programGoalName: $programGoalName, sessionCount: $sessionCount, tonnage: $tonnage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProgramPreview &&
      o.id == id &&
      o.name == name &&
      o.programGoalName == programGoalName &&
      o.sessionCount == sessionCount &&
      o.tonnage == tonnage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      programGoalName.hashCode ^
      sessionCount.hashCode ^
      tonnage.hashCode;
  }
}
