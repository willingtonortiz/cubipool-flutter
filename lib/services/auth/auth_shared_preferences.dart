import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPreferences {
  static Future saveUserId(int userId) async {
    var instance = await SharedPreferences.getInstance();
    instance.setInt('USER_ID', userId);
  }

  static Future<int> getUserId() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getInt('USER_ID');
  }

  static Future saveUserToken(String token) async {
    var instance = await SharedPreferences.getInstance();
    instance.setString('USER_TOKEN', token);
  }

  static Future<String> getUserToken() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString('USER_TOKEN');
  }
}
