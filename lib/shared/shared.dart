import 'package:shared_preferences/shared_preferences.dart';

mixin SharedManager {
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedManagerKey.TOKEN.toString(), token);
    return true;
  }
  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedManagerKey.TOKEN.toString());
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedManagerKey.TOKEN.toString());
  }
}

enum SharedManagerKey { TOKEN }
