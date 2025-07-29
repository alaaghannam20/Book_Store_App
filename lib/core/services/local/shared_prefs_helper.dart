import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _preferences;


  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

 
  static Future <void> saveData({required String key,required dynamic value}) async {
   
   if (value is String) {
      await _preferences?.setString(key, value);
    } else if (value is bool) {
      await _preferences?.setBool(key, value);
    } else if (value is int) {
      await _preferences?.setInt(key, value);
    } else if (value is double) {
      await _preferences?.setDouble(key, value);
    }else if (value is List<String>) {
      await _preferences?.setStringList(key, value); 
    }
  }


  static getData({required String key}) {
    return _preferences?.get(key);
  }


  static deleteData({required String key}) async {
    await _preferences?.remove(key);
  }

   static List<String> getSearchHistory() {
    return _preferences?.getStringList(SharedPrefsKey.searchHistory) ?? [];
  }

    static Future<void> addToSearchHistory(String query) async {
    List<String> history = getSearchHistory();
    history.remove(query); 
    history.insert(0, query);
    if (history.length > 10) history = history.sublist(0, 10);
    await saveData(key: SharedPrefsKey.searchHistory, value: history);
  }
}

class SharedPrefsKey {
  static const String userToken = 'userToken';
  static const String searchHistory = 'searchHistory';
}
