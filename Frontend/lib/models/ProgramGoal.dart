import 'dart:convert';

class ProgramGoal {
  int id;
  String name;
  
  ProgramGoal({
    this.id,
    this.name,
  });

  ProgramGoal copyWith({
    int id,
    String name,
  }) {
    return ProgramGoal(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static ProgramGoal fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProgramGoal(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static ProgramGoal fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'ProgramGoal(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProgramGoal &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
