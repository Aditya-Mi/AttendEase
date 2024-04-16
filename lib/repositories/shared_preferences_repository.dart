import 'dart:convert';

import 'package:attendease/core/app_string.dart';
import 'package:attendease/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  Future<void> saveUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_KEY, user);
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(USER_KEY);
    Map userData = jsonDecode(userJson!)['user'];
    User user = User.fromJson(userData);
    return user;
  }

  Future<List<String>> getClassIds() async {
    print('getId called');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? classIds = prefs.getStringList(CLASS_KEY);
    print(classIds);
    if (classIds != null) {
      return classIds;
    }
    return [];
  }

  Future<void> saveClassId(String id) async {
    print('saveId called');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? classIds = prefs.getStringList(CLASS_KEY);
    if (classIds != null) {
      classIds.add(id);
      print(classIds);
      prefs.setStringList(CLASS_KEY, classIds);
    } else {
      List<String> ids = [];
      ids.add(id);
      print(ids);
      prefs.setStringList(CLASS_KEY, ids);
    }
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
