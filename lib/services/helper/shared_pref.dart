import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController {
  SharedPreferences? _prefs;

  static final SharedPrefsController _instance =
  SharedPrefsController._internal();

  factory SharedPrefsController() {
    return _instance;
  }

  Future<void> _checkInstance() async {
    if (_prefs == null) {
      await init();
    }
  }

  Future<bool> containsKey(String key) async {
    await _checkInstance();
    return _prefs!.containsKey(key);
  }

  SharedPrefsController._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool?> setData(String key, dynamic data) async {
    await _checkInstance();
    switch (data.runtimeType) {
      case int:
        return _prefs?.setInt(key, data);

      case String:
        return _prefs?.setString(key, data);
      case bool:
        return _prefs?.setBool(key, data);
    }
    return null;
  }

  Future<bool?> deleteData(String key) async {
    await _checkInstance();

    return _prefs?.remove(key);
  }

  Future<dynamic> getData(String key) async {
    await _checkInstance();

    // return jsonDecode(_prefs?.get(key).toString() ?? "");
    return _prefs?.get(key);
  }
}