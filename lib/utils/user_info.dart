

import 'package:sahashop_user/const/const_database.dart';
import 'package:sahashop_user/data/remote/auth/model/login_response.dart';
import 'package:sahashop_user/data/remote/auth/model/register_response.dart';
import 'package:sahashop_user/data/remote/createShop/model/createShop_respont.dart';
import 'package:sahashop_user/data/remote/createShop/model/listTypeShop_respones.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  String token;

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  DataLogin dataLogin;
  DataRegister dataRegister;
  List<DataTypeShop> dataTypeShop;
  DataCreateShop dataCreateShop;

  Future<bool> hasLogged() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenLocal = prefs.getString(USER_TOKEN) ?? null;
      this.token = tokenLocal;
      if(tokenLocal != null) return false;
      return true;
  }
}