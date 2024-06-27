import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LocalStorage {
  static late SharedPreferences _prefs;
  static final _sStorage = FlutterSecureStorage();
  static String? authToken;
  static String? registeredUserId;
  static String? usercredentialsid;

  static Future<void> init() async {
    // ignore: unused_local_variable
    _prefs = await SharedPreferences.getInstance();
    authToken = await _getSecureAuthToken();
    registeredUserId = await getUserId();
    usercredentialsid = await getUserLoginId();
  }

  static Future<Map<String, dynamic>?> get currentUserMap async {
    String? value = await _secureRead(Keys.CURRENT_USER);
    return value != null ? json.decode(value) : null;
  }

  static Future<void> writeUser(User user) async {
    try {
      await _secureWrite(
          Keys.CURRENT_USER, json.encode(user.toSharedPreference()));
      if (user.userregistrationid != null) {
        await writeSecureAuthToken("${user.userregistrationid!}");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> writeString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static String? readString(String key) {
    return _prefs.getString(key);
  }

  static Future<String?> _getSecureAuthToken() async =>
      await _secureRead(Keys.AUTH_TOKEN);

  static Future<String?> getUserId() async =>
      await _secureRead(Keys.CURRENT_USER);

      static Future<String?> getUserLoginId() async =>
      await _secureRead(Keys.loginId);

  static Future<String?> _secureRead(String key) async => await _sStorage.read(
      key: key,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true));

  //CLEAR Portion
  static Future<bool> clear() async {
    print(LocalStorage.currentUserMap);
    await _prefs.clear();
    print(LocalStorage.currentUserMap);
    await _sStorage.deleteAll();
    authToken = null;
    return true;
  }

  static Future<void> writeSecureAuthToken(String token) async {
    try {
      await _secureWrite(Keys.AUTH_TOKEN, token);
      authToken = token;
    } catch (e) {
      //TODO
    }
  }

  static Future<void> writeUserId(String userid) async {
    try {
      await _secureWrite(Keys.CURRENT_USER, userid);
      registeredUserId = userid;
      print('User Register Id ----------------->>  $registeredUserId');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> writeUserLoginId(String loginId) async {
    try {
      await _secureWrite(Keys.loginId, loginId);
      usercredentialsid = loginId;
      print('Login Id ----------------->>  $usercredentialsid');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> _secureWrite(String key, String value) async {
    try {
      await _sStorage.write(
        key: key,
        value: value,
        aOptions: const AndroidOptions(encryptedSharedPreferences: true),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}



class Keys {
  static const CURRENT_USER = 'current-user';
  static String AUTH_TOKEN = 'token';
  static const String loginId = 'login-id';
}
