import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<bool> saveTokenPreference(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userToken", token);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }

  Future<String> getTokenFromPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("userToken");
    return token;
  }

  removeToken() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    Set<String> keys = sharedPreference.getKeys();
    keys.remove("username");
  }
}
