import 'package:get/get.dart';
import 'package:sahashop_user/const/const_database.dart';
import 'package:sahashop_user/data/remote/remote_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginController extends GetxController {
  var stateLogin = "".obs;
  var logging = false.obs;
  Future<bool> onLogin({String shopPhone, String password}) async {
    logging.value = true;
    try {
      var loginData =
      await RemoteManager.authService.login(shopPhone: shopPhone, pass: password);

      UserInfo().dataLogin = loginData;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('tokenLogin', loginData.token);
      print("aaaaa" + prefs.getString(USER_TOKEN));

      logging.value = false;
      stateLogin.value = "success";
      return true;
    } catch (err) {
      stateLogin.value = err.toString();
      stateLogin.refresh();
      logging.value = false;
      return false;
    }
  }
}