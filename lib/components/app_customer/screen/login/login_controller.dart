import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/components/utils/customer_info.dart';

class LoginController extends GetxController {
  var isHidePassword = true.obs;
  var nameAccountEditingController = new TextEditingController().obs;
  var passwordEditingController = new TextEditingController().obs;
  var isLoginSuccess = false.obs;

  Future<void> loginAccount(String phone, String password) async {
    try {
      var res = await CustomerRepositoryManager.loginCustomerRepository
          .loginAccount(phone, password);
      await CustomerInfo().setToken(res.data.token);
      isLoginSuccess.value = true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}