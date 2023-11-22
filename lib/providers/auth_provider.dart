import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../utils/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // GET USER
  Future<void> getUser(_token) async {
    try {
      UserModel user = await AuthService().getUser(token: _token);
      _user = user;
    } catch (e) {
      print(e);
    }
  }

  // LOGIN
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;

      UserPreferences().saveUser(_user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // LOGOUT
  Future<bool> logout({
    required String token,
  }) async {
    try {
      // API LOGOUT
      bool res = await AuthService().logout(
        token: token,
      );
      print('authprov :' + res.toString());
      // REMOVE TOKEN
      UserPreferences().removeToken();
      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
