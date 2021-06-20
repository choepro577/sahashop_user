import 'package:get/get.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

class SignUpController extends GetxController {
  var stateSignUp = "".obs;
  var signUpping = false.obs;
  var shopPhones = "".obs;
  Future<bool> onSignUp({required String shopPhone, String? pass}) async {
    signUpping.value = true;
    try {
      var dataRegister = await RepositoryManager.loginRepository
          .login(phone: shopPhone, pass: pass);
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
