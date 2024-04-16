import 'dart:convert';

import 'package:attendease/core/app_string.dart';
import 'package:attendease/repositories/shared_preferences_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Map<String, String> _getHeader() {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = Uri.https(BASE_URL, '/api/v1/user/auth/login');
      final response = await http.post(
        url,
        body: jsonEncode({'username': username, 'password': password}),
        headers: _getHeader(),
      );

      if (response.statusCode == 200) {
        await SharedPreferencesRepository().saveUser(response.body);
        final result = jsonDecode(response.body);
        final token = result['token'];
        await SharedPreferencesRepository().saveToken(token);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
