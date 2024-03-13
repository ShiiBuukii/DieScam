import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ASharedPreferences {
  void setData(String key, dynamic value);
  dynamic getData(String key);
  Future<bool> getBool(String key);
  void setBool(String key, bool value);
  void removeData(String key);
}

class SharedPreferencesImpl implements ASharedPreferences {
  @override
  dynamic getData(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }

  @override
  void removeData(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  @override
  void setData(String key, dynamic value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    switch (value.runtimeType.toString()) {
      case 'String':
        await sharedPreferences.setString(key, value);
        break;
      case 'int':
        await sharedPreferences.setInt(key, value);
        break;
      case 'double':
        await sharedPreferences.setDouble(key, value);
        break;
      case 'List<String>':
        await sharedPreferences.setStringList(key, value);
        break;
      default:
        break;
    }
  }

  @override
  Future<bool> getBool(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  @override
  void setBool(String key, bool value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }
}
