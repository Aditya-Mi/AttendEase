import 'dart:convert';

import 'package:attendease/core/app_string.dart';
import 'package:attendease/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  Future<void> saveUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_KEY, user);
  }

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentJson = prefs.getString(USER_KEY);
    if (studentJson != null) {
      User user = User.fromJson(jsonDecode(studentJson)['user']);
      return user;
    }
    return null;
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(USER_KEY);
    Map userData = jsonDecode(userJson!)['user'];
    User user = User.fromJson(userData);
    return user.id;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN_KEY, token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(TOKEN_KEY);
    return token;
  }
}
