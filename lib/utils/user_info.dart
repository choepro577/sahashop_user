
import 'package:sahashop_user/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  String token;
  int currentIdStore;

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  void setCurrentIdStore() {
    this.currentIdStore = currentIdStore;
  }


  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_TOKEN, token);
    this.token = token;
  }

  Future<bool> hasLogged() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenLocal = prefs.getString(USER_TOKEN) ?? null;
      this.token = tokenLocal;
      if(tokenLocal != null) return false;
      return true;
  }
}