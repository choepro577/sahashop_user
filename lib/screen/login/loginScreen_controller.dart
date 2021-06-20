import 'package:get/get.dart';
import 'package:sahashop_user/data/remote/response-request/auth/login_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/load_data/load_firebase.dart';
import 'package:sahashop_user/utils/user_info.dart';

class LoginController extends GetxController {
  var stateLogin = "".obs;
  var logging = false.obs;
  Future<bool> onLogin({String? shopPhone, String? password}) async {
    logging.value = true;
    try {
      var loginData = await (RepositoryManager.loginRepository
          .login(phone: shopPhone, pass: password) as Future<DataLogin>);

      await UserInfo().setToken(loginData.token);

      if (FCMToken().getToken() != null) {
        RepositoryManager.deviceTokenRepository
            .updateDeviceTokenUser(FCMToken().getToken());
      }

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
