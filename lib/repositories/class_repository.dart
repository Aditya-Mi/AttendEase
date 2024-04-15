import 'dart:convert';

import 'package:attendease/core/app_string.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/models/class_record.dart';
import 'package:attendease/models/single_class_record.dart';
import 'package:attendease/models/student_attendance.dart';
import 'package:attendease/repositories/shared_preferences_repository.dart';
import 'package:http/http.dart' as http;

class ClassRepository {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  ClassRepository(
      {required SharedPreferencesRepository sharedPreferencesRepository})
      : _sharedPreferencesRepository = sharedPreferencesRepository;

  Map<String, String> _getHeader() {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
  }

  Future<List<Class>> getAllClasses() async {
    try {
      final id = await _sharedPreferencesRepository.getUserId();
      final url = Uri.https(BASE_URL, '/api/v1/teacher/classes/$id');
      final response = await http.get(url, headers: _getHeader());
      print(response.reasonPhrase);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<Class> classes = result['data']['classes']
            .map<Class>((classJson) => Class.fromJson(classJson))
            .toList();
        return classes;
      }
      throw 'An unexpected error occurred';
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<List<ClassRecord>> getRecords(
    List<String>? classIds,
    String startDate,
    String endDate,
  ) async {
    try {
      final queryParameters = {'date[gte]': startDate, 'date[lt]': endDate};
      final url = Uri.https(BASE_URL, '/api/v1/attendance/', queryParameters);
      final response = await http.post(
        url,
        headers: _getHeader(),
        body: jsonEncode(
          {"classIds": classIds},
        ),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<ClassRecord> classRecords = result['data']
            .map<ClassRecord>((model) => ClassRecord.fromJson(model))
            .toList();
        return classRecords;
      }
      throw 'An unexpected error occurred';
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<ClassRecord> getSingleRecord(
    String classIds,
    String startDate,
    String endDate,
  ) async {
    try {
      final queryParameters = {'date[gte]': startDate, 'date[lt]': endDate};
      final url = Uri.https(BASE_URL, '/api/v1/attendance/', queryParameters);
      final response = await http.post(
        url,
        headers: _getHeader(),
        body: jsonEncode(
          {
            "classIds": [classIds]
          },
        ),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        ClassRecord classRecords = ClassRecord.fromJson(result['data'][0]);
        return classRecords;
      }
      throw 'An unexpected error occurred';
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<SingleClassRecord> getStudentsAttendance(String classId) async {
    try {
      final url = Uri.https(BASE_URL, '/api/v1/classrecord/$classId');
      final response = await http.get(url, headers: _getHeader());
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        SingleClassRecord singleClassRecord = result['data']['classRecord'];
        return singleClassRecord;
      }
      throw 'An unexpected error occurred';
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<bool> submitAttendance(List<SubmitStudent> listOfAttendance) async {
    try {
      final url = Uri.https(
          BASE_URL, '/api/v1/attendance/${listOfAttendance[0].kClass}');
      List<Map<String, dynamic>> jsonList = [];
      for (var student in listOfAttendance) {
        Map<String, dynamic> jsonMap = {
          'class': student.kClass,
          'student': student.student,
          'status': student.status,
          'date': student.date,
        };
        jsonList.add(jsonMap);
      }
      Map<String, dynamic> jsonData = {'attendance': jsonList};
      final response = await http.post(
        url,
        headers: _getHeader(),
        body: jsonEncode(
          jsonData,
        ),
      );
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
    return false;
  }
}
