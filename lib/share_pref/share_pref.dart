import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static SharePref inst = SharePref();
  /*SET STRING*/
  late SharedPreferences sharePref;
  Future<void> setString(String key, String value) async {
    sharePref.setString(key, value);
  }

  /*SET BOOL*/
  Future<void> setBool(String key, bool value) async {
    sharePref.setBool(key, value);
  }

  /*SET INT*/
  Future<void> setInt(String key, int value) async {
    sharePref.setInt(key, value);
  }

  /*SET DOUBLE*/
  Future<void> setDouble(String key, double value) async {
    sharePref.setDouble(key, value);
  }

  /*GET STRING*/
  Future<String> getString(String key) async {
    return sharePref.getString(key) ?? '';
  }

  /*GET INT*/
  Future<int> getInt(String key) async {
    return sharePref.getInt(key) ?? 0;
  }

  /*GET BOOL*/
  Future<bool> getBool(String key) async {
    return sharePref.getBool(key) ?? false;
  }

  /*GET DOUBLE*/
  Future<double?> getDouble(String key) async {
    return sharePref.getDouble(key) ?? 0.00;
  }

  /*CLEAR SHAREPREF*/
  Future<void> clear() async {
    sharePref.clear();
  }

  /*REMOVE KEY*/
  Future<void> remove(String key) async {
    sharePref.remove(key);
  }
}
