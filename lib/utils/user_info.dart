import 'package:sahashop_user/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  String _token;
  int _currentIdStore;

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  Future<void> setCurrentIdStore(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(id == null) {
      await prefs.remove(CURRENT_ID_STORE);
    } else {
      await prefs.setInt(CURRENT_ID_STORE, id);
    }
    this._currentIdStore = id;
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(token == null) {
      await prefs.remove(USER_TOKEN);
    } else {
      await prefs.setString(USER_TOKEN, token);
    }
    this._token = token;
  }

  String getToken() {
    return _token;
  }

  int getCurrentIdStore() {
    return _currentIdStore;
  }

  Future<bool> hasLogged() async {
    await loadDataUserSaved();
    if (this._token != null)
      return true;
    else
      return false;
  }

  Future<void> loadDataUserSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenLocal = prefs.getString(USER_TOKEN) ?? null;
    this._token = tokenLocal;

    this._currentIdStore = prefs.getInt(CURRENT_ID_STORE) ?? null;
  }
}
