import 'package:flutter/cupertino.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/const/sms_otp.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class SignUpController extends GetxController {
  var stateSignUp = "".obs;
  var signUpping = false.obs;
  var shopPhones = "".obs;
  var phoneInputting = false.obs;
  var phoneInputtingOtp = false.obs;

  var checkingHasEmail = false.obs;
  var checkingHasPhone = false.obs;

  TextEditingController textEditingControllerPhone =
      new TextEditingController();
  TextEditingController textEditingControllerPass = new TextEditingController();
  TextEditingController textEditingControllerEmail =
      new TextEditingController();
  TextEditingController textEditingControllerName = new TextEditingController();

  TextEditingController textEditingControllerOtp = new TextEditingController();

  Future<void> onSignUp() async {
    signUpping.value = true;
    try {
      var dataRegister = await RepositoryManager.registerRepository.register(
          phone: textEditingControllerPhone.text,
          pass: textEditingControllerPass.text,
          name: textEditingControllerName.text,
          otp: textEditingControllerOtp.text,
          email: textEditingControllerEmail.text);
      SahaAlert.showSuccess(
          message: "Đăng ký thành công hãy thực hiện đăng nhập");
      Navigator.of(Get.context!).popUntil((route) => route.isFirst);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    signUpping.value = false;
  }

  Future<void> checkHasEmail({Function? onHas, Function? noHas}) async {
    checkingHasEmail.value = true;
    try {
      var data = await RepositoryManager.loginRepository.checkExists(
        email: textEditingControllerEmail.text,
      );

      for(var e in data!) {
        if (e.name == "email" && e.value == true) {
          SahaAlert.showError(message: "Email đã tồn tại");
          if (onHas != null) onHas();
          checkingHasEmail.value = false;
          return;
        }
      }

      if (noHas != null) noHas();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    checkingHasEmail.value = false;
  }


  Future<void> checkHasPhoneNumber({Function? onHas, Function? noHas}) async {
    checkingHasPhone.value = true;
    try {
      var data = await RepositoryManager.loginRepository.checkExists(
        phoneNumber: textEditingControllerPhone.text,
      );

      for(var e in data!) {
        if (e.name == "phone_number" && e.value == true) {
          SahaAlert.showError(message: "Số điện thoại đã tồn tại");
          if (onHas != null) onHas();
          checkingHasPhone.value = false;
          return;
        }
      }

      if (noHas != null) noHas();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    checkingHasPhone.value = false;
  }
}
