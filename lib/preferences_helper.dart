import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {

  static final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  ///================== default key =====================>////

  static const String _loginKey = "login";

  ///================== Save login value =====================>////

  static Future<void> setLogin(String value) async {
    await _asyncPrefs.setString(_loginKey, value);
  }

  ///================== Get login value =====================>////
  static Future<String?> getLogin() async {
    return await _asyncPrefs.getString(_loginKey);
  }

  ///================== Remove login =====================>////

  static Future<void> removeLogin() async {
    await _asyncPrefs.remove(_loginKey);
  }

  ///================== Clear all keys =====================>////

  static Future<void> clearAll() async {
    await _asyncPrefs.clear();
  }
}







// class PreferencesHelper {
//   Future init() async => _asyncPref = await   SharedPreferences.getInstance()
//   static  SharedPreferencesAsync _asyncPref = SharedPreferencesAsync();
//
//   static late SharedPreferencesAsync _asyncPref;
//
//   static const _token = '_token';
//
//   static Future tokenSetString(String value) async {
//     await _asyncPref.setString(_token, value);
//   }

// static Future<String?> getString(String key) async {
//   return await _asyncPref.getString(key);
// }
//
// static Future<void> setInt(String key, int value) async {
//   await _asyncPref.setInt(key, value);
// }
//
// static Future<int?> getInt(String key) async {
//   return await _asyncPref.getInt(key);
// }
//
// static Future<void> setBool(String key, bool value) async {
//   await _asyncPref.setBool(key, value);
// }
//
// static Future<bool?> getBool(String key) async {
//   return await _asyncPref.getBool(key);
// }
//
// static Future<void> remove(String key) async {
//   await _asyncPref.remove(key);
// }

//   static Future<void> clear() async {
//     await _asyncPref.clear();
//   }
//
//   static  get token => _asyncPref.getString(_token)??"";
// }
