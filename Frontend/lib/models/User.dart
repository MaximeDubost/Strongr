import 'dart:convert';

class User {
  int id;
  String email;
  String password;
  String firstName;
  String lastName;
  String phoneNumber;
  String birthdate;
  String username;
  double weight;
  String signedDate;
  String exerciseCount;
  String sessionCount;
  String programCount;
  int volumeAverage;

  User({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.birthdate,
    this.username,
    this.weight,
    this.signedDate,
    this.exerciseCount,
    this.sessionCount,
    this.programCount,
    this.volumeAverage,
  });

  User copyWith({
    int id,
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String birthdate,
    String username,
    double weight,
    String signedDate,
    int exerciseCount,
    int sessionCount,
    int programCount,
    int volumeAverage,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthdate: birthdate ?? this.birthdate,
      username: username ?? this.username,
      weight: weight ?? this.weight,
      signedDate: signedDate ?? this.signedDate,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      sessionCount: sessionCount ?? this.sessionCount,
      programCount: programCount ?? this.programCount,
      volumeAverage: volumeAverage ?? this.volumeAverage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'birthdate': birthdate,
      'username': username,
      'weight': weight,
      'signedDate': signedDate,
      'exerciseCount': exerciseCount,
      'sessionCount': sessionCount,
      'programCount': programCount,
      'volumeAverage': volumeAverage,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      id: map['id_user'],
      email: map['email'],
      password: map['password'],
      firstName: map['firstname'],
      lastName: map['lastname'],
      phoneNumber: map['phonenumber'],
      birthdate: map['birthdate'],
      username: map['username'],
      weight: map['weight'],
      signedDate: map['signeddate'],
      exerciseCount: map['nb_exercises'],
      sessionCount: map['nb_sessions'],
      programCount: map['nb_programs'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, password: $password, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, birthdate: $birthdate, username: $username, weight: $weight, signedDate: $signedDate, exerciseCount: $exerciseCount, sessionCount: $sessionCount, programCount: $programCount, volumeAverage: $volumeAverage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.id == id &&
      o.email == email &&
      o.password == password &&
      o.firstName == firstName &&
      o.lastName == lastName &&
      o.phoneNumber == phoneNumber &&
      o.birthdate == birthdate &&
      o.username == username &&
      o.weight == weight &&
      o.signedDate == signedDate &&
      o.exerciseCount == exerciseCount &&
      o.sessionCount == sessionCount &&
      o.programCount == programCount &&
      o.volumeAverage == volumeAverage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      password.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phoneNumber.hashCode ^
      birthdate.hashCode ^
      username.hashCode ^
      weight.hashCode ^
      signedDate.hashCode ^
      exerciseCount.hashCode ^
      sessionCount.hashCode ^
      programCount.hashCode ^
      volumeAverage.hashCode;
  }
}
