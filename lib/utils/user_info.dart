import 'package:sahashop_user/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  String _token;
  String _currentStoreCode;
  int _currentIdUser;

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  Future<void> setCurrentStoreCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (code == null) {
      await prefs.remove(CURRENT_STORE_CODE);
    } else {
      await prefs.setString(CURRENT_STORE_CODE, code);
    }
    this._currentStoreCode = code;
  }

  Future<void> setCurrentIdUser(int idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (idUser == null) {
      await prefs.remove(CURRENT_USER_ID);
    } else {
      await prefs.setInt(CURRENT_USER_ID, idUser);
    }
    this._currentIdUser = idUser;
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(USER_TOKEN);
    } else {
      await prefs.setString(USER_TOKEN, token);
    }
    this._token = token;
  }

  String getToken() {
    return _token;
  }

  String getCurrentStoreCode() {
    return _currentStoreCode;
  }

  int getCurrentIdUser() {
    return _currentIdUser;
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

    this._currentStoreCode = prefs.getString(CURRENT_STORE_CODE) ?? null;
  }
}
