import 'dart:convert';

class Equipment {
  int id;
  String name;
  String description;
  String image;
  
  Equipment({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  Equipment copyWith({
    int id,
    String name,
    String description,
    String image,
  }) {
    return Equipment(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  static Equipment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Equipment(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  static Equipment fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Equipment(id: $id, name: $name, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Equipment &&
      o.id == id &&
      o.name == name &&
      o.description == description &&
      o.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode;
  }
}
