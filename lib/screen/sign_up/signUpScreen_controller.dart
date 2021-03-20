import 'package:get/get.dart';
import 'package:sahashop_user/data/remote/remote_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

class SignUpController extends GetxController {
  var stateSignUp = "".obs;
  var signUpping = false.obs;
  var shopPhones = "".obs;
  Future<bool> onSignUp ({String shopPhone, String pass}) async {
      signUpping.value = true;
      try {
        var dataRegister = await RemoteManager.authService.register(shopPhone: shopPhone, pass: pass);
        UserInfo().dataRegister = dataRegister;
        signUpping.value = false;
        stateSignUp.value = "success";
        shopPhones.value = shopPhone;
        return true;
      } catch (err) {
        signUpping.value = false;
        stateSignUp.value = err.toString();
        stateSignUp.refresh();
        return false;
    }
  }
}