// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> subjectsId;
  final String role;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.subjectsId,
    required this.role,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    List<String>? subjectsId,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      subjectsId: subjectsId ?? this.subjectsId,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'subjectsId': subjectsId,
      'role': role,
    };
  }

  factory User.fromJson(Map map) {
    return User(
      id: map['_id'],
      username: map['username'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      subjectsId: map['subject'].cast<String>(),
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, subjectsId: $subjectsId, role: $role)';
  }
}
