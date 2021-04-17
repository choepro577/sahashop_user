import 'package:sahashop_user/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  String _token;
  String _currentstoreCode;
  int _currentIdUser;

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  Future<void> setCurrentstoreCode(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (id == null) {
      await prefs.remove(CURRENT_ID_STORE);
    } else {
      await prefs.setString(CURRENT_ID_STORE, id);
    }
    this._currentstoreCode = id;
  }

  Future<void> setCurrentIdUser(int idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (idUser == null) {
      await prefs.remove(CURRENT_ID_USER);
    } else {
      await prefs.setInt(CURRENT_ID_USER, idUser);
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

  String getCurrentstoreCode() {
    return _currentstoreCode;
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

    this._currentstoreCode = prefs.getString(CURRENT_ID_STORE) ?? null;
  }
}
