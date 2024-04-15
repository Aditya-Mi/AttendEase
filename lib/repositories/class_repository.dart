import 'dart:convert';

import 'package:attendease/core/app_string.dart';
import 'package:attendease/models/class.dart';
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
      final url = Uri.parse('$BASE_URL/teacher/classes/$id');
      final response = await http.get(url, headers: _getHeader());

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
}
