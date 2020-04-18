import 'dart:convert';

class Muscle {
  int id;
  String name;
  
  Muscle({
    this.id,
    this.name,
  });

  Muscle copyWith({
    int id,
    String name,
  }) {
    return Muscle(
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

  static Muscle fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Muscle(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static Muscle fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Muscle(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Muscle &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
