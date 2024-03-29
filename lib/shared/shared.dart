import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<String?> getToken(args) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedManagerKey.TOKEN.toString());
  }
}

enum SharedManagerKey { TOKEN }
