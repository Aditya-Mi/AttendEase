class ClassRecord {
  final String id;
  final List<Student> students;

  ClassRecord({
    required this.id,
    required this.students,
  });

  factory ClassRecord.fromJson(Map<String, dynamic> json) {
    return ClassRecord(
      id: json["classId"],
      students: json["attendanceRecords"]
          .map<Student>((model) => Student.fromJson(model))
          .toList(),
    );
  }

  double calculateAttendancePercentage() {
    if (students.isEmpty) {
      return 0.0;
    }
    int totalStudents = students.length;
    int presentStudents =
        students.where((student) => student.status == 'Present').length;
    return (presentStudents / totalStudents) * 100;
  }
}

class Student {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String status;

  Student({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.status,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['student']['_id'],
      username: json['student']['username'],
      email: json['student']['email'],
      firstName: json['student']['firstName'],
      lastName: json['student']['lastName'],
      status: json['status'],
    );
  }
}
