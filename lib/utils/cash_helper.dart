import 'package:shared_preferences/shared_preferences.dart';

import 'enums/shared_prefs_enums.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putString({required SharedPrefsKey key, required String value}) async {
    await sharedPreferences!.setString(key.name, value);
  }

  static getString({required SharedPrefsKey key}) {
    return sharedPreferences!.getString(key.name) ?? "";
  }

  static putBool({required SharedPrefsKey key, required bool value}) async {
    await sharedPreferences!.setBool(key.name, value);
  }

  static getBool({required SharedPrefsKey key}) {
    return sharedPreferences!.getBool(key.name) ?? false;
  }

  static putDouble({required SharedPrefsKey key, required double value}) async {
    await sharedPreferences!.setDouble(key.name, value);
  }

  static getDouble({required SharedPrefsKey key}) {
    return sharedPreferences!.getDouble(key.name) ?? 0.0;
  }

  static putInt({required SharedPrefsKey key, required int value}) async {
    await sharedPreferences!.setInt(key.name, value);
  }

  static getInt({required SharedPrefsKey key}) {
    return sharedPreferences!.getInt(key.name) ?? 0;
  }

  static delete({required SharedPrefsKey key}) {
    return sharedPreferences!.remove(key.name);
  }

  static deleteDb() {
    sharedPreferences!.clear();
  }
}
