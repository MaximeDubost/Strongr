import 'dart:convert';

class ProgramGoal {
  int id;
  String name;
  String description;
  
  ProgramGoal({
    this.id,
    this.name,
    this.description,
  });

  ProgramGoal copyWith({
    int id,
    String name,
    String description,
  }) {
    return ProgramGoal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  static ProgramGoal fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProgramGoal(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  static ProgramGoal fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'ProgramGoal(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProgramGoal &&
      o.id == id &&
      o.name == name &&
      o.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
