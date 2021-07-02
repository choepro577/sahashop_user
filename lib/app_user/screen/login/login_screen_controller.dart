import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/load_data/load_firebase.dart';
import 'package:sahashop_user/app_user/screen/home/home_screen.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class LoginController extends GetxController {
  var logging = false.obs;
  var loginInputting = false.obs;
  Future<bool> onLogin({String? shopPhone, String? password}) async {
    logging.value = true;
    try {
      var loginData = (await RepositoryManager.loginRepository
          .login(phone: shopPhone, pass: password))!;

      await UserInfo().setToken(loginData.token);

      if (FCMToken().getToken() != null) {
        RepositoryManager.deviceTokenRepository
            .updateDeviceTokenUser(FCMToken().getToken());
      }

      Get.offAll(HomeScreen());

      logging.value = false;

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());

      logging.value = false;
      return false;
    }
  }
}
