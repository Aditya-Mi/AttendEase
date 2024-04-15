class SingleClassRecord {
  final String id;
  final int noOfClasses;
  final List<Student> students;

  SingleClassRecord(
      {required this.id, required this.students, required this.noOfClasses});

  factory SingleClassRecord.fromJson(Map<String, dynamic> json) {
    return SingleClassRecord(
      id: json["class"],
      noOfClasses: json["noOfClass"],
      students: json["students"]
          .map<Student>((model) => Student.fromJson(model))
          .toList(),
    );
  }
}

class Student {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final int classAttended;

  Student({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.classAttended,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['student']['_id'],
      username: json['student']['username'],
      email: json['student']['email'],
      firstName: json['student']['firstName'],
      lastName: json['student']['lastName'],
      classAttended: json['classAttended'],
    );
  }
}
