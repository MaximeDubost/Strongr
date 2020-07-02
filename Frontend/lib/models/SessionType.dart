import 'dart:convert';

class SessionType {
  int id;
  String name;
  String description;

  SessionType({
    this.id,
    this.name,
    this.description,
  });

  SessionType copyWith({
    int id,
    String name,
    String description,
  }) {
    return SessionType(
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

  static SessionType fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SessionType(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  static SessionType fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'SessionType(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SessionType &&
        o.id == id &&
        o.name == name &&
        o.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
