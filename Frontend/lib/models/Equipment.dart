import 'dart:convert';

class Equipment {
  int id;
  String name;
  
  Equipment({
    this.id,
    this.name,
  });

  Equipment copyWith({
    int id,
    String name,
  }) {
    return Equipment(
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

  static Equipment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Equipment(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static Equipment fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Equipment(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Equipment &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
