import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/load_data/load_firebase.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class ResetPasswordController extends GetxController {
  var resting = false.obs;
  var newPassInputting = false.obs;

  TextEditingController textEditingControllerNumberPhone =
      new TextEditingController();
  TextEditingController textEditingControllerOtp = new TextEditingController();
  TextEditingController textEditingControllerNewPass =
      new TextEditingController();

  Future<void> onReset() async {
    resting.value = true;
    try {
      var loginData = (await CustomerRepositoryManager.loginCustomerRepository
          .resetPassword(
              phone: textEditingControllerNumberPhone.text,
              pass: textEditingControllerNewPass.text,
              otp: textEditingControllerOtp.text))!;

      SahaAlert.showSuccess(
          message: "Lấy lại mật khẩu thành công, vui lòng đăng nhập lại");
      Get.back(result: {
        "success": true,
        "phone": textEditingControllerNumberPhone.text,
        "pass": textEditingControllerNewPass.text
      });
      resting.value = false;
    } catch (err) {
      resting.value = false;
      SahaAlert.showError(message: err.toString());

    }
    resting.value = false;
  }
}
