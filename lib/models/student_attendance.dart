// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore_for_file: constant_identifier_names

class StudentAttendance {
  final String studentId;
  final String classId;
  final String date;
  AttendanceStatus attendanceStatus;

  StudentAttendance({
    required this.studentId,
    required this.classId,
    required this.date,
    required this.attendanceStatus,
  });
}

enum AttendanceStatus {
  Present,
  Absent,
  None,
}

class SubmitStudent {
  final String student;
  final String kClass;
  final String date;
  final String status;

  SubmitStudent({
    required this.student,
    required this.kClass,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'class': kClass,
      'student': student,
      'status': status,
      'date': date,
    };
  }
}
