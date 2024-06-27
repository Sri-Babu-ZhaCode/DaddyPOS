import 'package:easybill_app/app/data/models/login.dart';
import 'package:flutter/material.dart';

import '../../core/exceptions.dart';
import '../models/user.dart';
import 'base_repository.dart';

class AuthRepo extends BaseRepo {
  AuthRepo._privateConstructor();

  // Static instance variable
  static final AuthRepo _instance = AuthRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory AuthRepo() {
    return _instance;
  }
  Future<List<User>?> register(User u) async {
    try {
      return await post<User>("/register",
          body: u.toJson(), decoder: (json) => User.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Login>?> login(Login l) async {
    try {
      return await post<Login>("/login",
          body: l.toJson(), decoder: (json) => Login.fromJson(json));
    } catch (e) {
      debugPrintStack();
      throw EbException(e);
    }
  }

  Future<List<Login>?> logOut(Login l) async {
    try {
      return await post<Login>("/logout",
          body: l.toJson(), decoder: (json) => Login.fromJson(json));
    } catch (e) {
      debugPrintStack();
      throw EbException(e);
    }
  }

  Future<List<Login>?> setPassword(Login l) async {
    try {
      return await post<Login>("/createPassword",
          body: l.toJson(), decoder: (json) => Login.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
