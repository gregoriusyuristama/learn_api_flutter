import 'dart:convert';

import 'package:fetch_api_flutter/user_model.dart';
import 'package:http/http.dart' as http;

class UserController {
  static Future<User> fetchUser() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<List<User>> fetchUsers() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/'));
    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((element) => User.fromJson(element)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
