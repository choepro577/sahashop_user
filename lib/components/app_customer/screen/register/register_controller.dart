import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/login/login_controller.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';

class RegisterController extends GetxController {
  var isHidePassword = true.obs;
  var nameAccountEditingController = new TextEditingController().obs;
  var passwordEditingController = new TextEditingController().obs;
  var introduceCodeEditingController = new TextEditingController().obs;
  var phoneRequest = "";
  var mailRequest = "";
  var isSuccess = false.obs;
  LoginController loginController = LoginController();

  Future<void> registerAccount() async {
    try {
      var res = await CustomerRepositoryManager.registerCustomerRepository
          .registerAccount(nameAccountEditingController.value.text,
              passwordEditingController.value.text);
      await loginController.loginAccount(
          nameAccountEditingController.value.text,
          passwordEditingController.value.text);
      Get.back();
      SahaAlert.showError(message: "Đăng kí thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
