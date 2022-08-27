import 'dart:convert';

import 'package:spice_blog_22/auth/datasource/models.dart';
import 'package:spice_blog_22/common/network_client/network_client.dart';

class AuthRepository {
  static AuthRepository? _instance;
  AuthRepository._(); // Private Constructor
  factory AuthRepository() {
    _instance ??= AuthRepository._(); // ??= is called Elvis Operator
    return _instance!;
  }

  User? _user;
  User? get currentUser => _user;

  Future<User?> signIn(
      {required String email, required String password}) async {
    final response = await NetworkClient.post(
      'login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      _user = User.fromJson(json.decode(response.body));
    }

    return _user;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await NetworkClient.post(
      'signup',
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );

    return response.statusCode == 200;
  }
}