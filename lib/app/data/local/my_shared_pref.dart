import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/translations/localization_service.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _isLogin = "is_login";
  static const String _name = "name";
  static const String _phone = "phone";

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ??
      true; // todo set the default theme (true for light, false for dark)

  /// save current locale
  static Future<void> setCurrentLanguage(String languageCode) =>
      _sharedPreferences.setString(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _sharedPreferences.getString(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() => _sharedPreferences.getString(_fcmTokenKey);

  /// save generated fcm token
  static Future<void> setIsAuth(bool isAuth) =>
      _sharedPreferences.setBool(_isLogin, isAuth);

  /// get generated fcm token
  static bool? getIsAuth() => _sharedPreferences.getBool(_isLogin) ?? false;

  /// save user name
  static Future<void> setUserName(String name) =>
      _sharedPreferences.setString(_name, name);

  /// get user name
  static String? getUserName() => _sharedPreferences.getString(_name);

  /// save phone
  static Future<void> setUserPhone(String phone) =>
      _sharedPreferences.setString(_phone, phone);

  /// get phone
  static String? getUserPhone() => _sharedPreferences.getString(_phone);

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();
}
