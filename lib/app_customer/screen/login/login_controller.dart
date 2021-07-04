import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../repository/repository_customer.dart';
import '../../screen/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import '../../utils/customer_info.dart';

class LoginController extends GetxController {
  var isHidePassword = true.obs;
  var phoneEditingController = new TextEditingController().obs;
  var passwordEditingController = new TextEditingController().obs;
  var isLoginSuccess = false.obs;

  DataAppCustomerController dataAppCustomerController = Get.find();

  Future<void> loginAccount(String phone, String password) async {
    try {
      var res = await CustomerRepositoryManager.loginCustomerRepository
          .loginAccount(phone, password);
      await CustomerInfo().setToken(res!.data!.token);
      isLoginSuccess.value = true;
      dataAppCustomerController.getInfoCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }


}
