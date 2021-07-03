import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';

class RegisterController extends GetxController {
  var stateSignUp = "".obs;
  var signUpping = false.obs;
  var shopPhones = "".obs;
  var phoneInputting = false.obs;
  var phoneInputtingOtp = false.obs;

  var checkingHasEmail = false.obs;
  var checkingHasPhone = false.obs;

  var otp = "";

  TextEditingController textEditingControllerPhone =
      new TextEditingController();
  TextEditingController textEditingControllerPass = new TextEditingController();
  TextEditingController textEditingControllerEmail =
      new TextEditingController();
  TextEditingController textEditingControllerName = new TextEditingController();


  Future<void> onSignUp() async {
    signUpping.value = true;
    try {
      var dataRegister = await CustomerRepositoryManager
          .registerCustomerRepository
          .registerAccount(
              phone: textEditingControllerPhone.text,
              password: textEditingControllerPass.text,
              name: textEditingControllerName.text,
              email: textEditingControllerEmail.text);
      SahaAlert.showSuccess(
          message: "Đăng ký thành công hãy thực hiện đăng nhập");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    signUpping.value = false;
  }

  Future<void> checkHasEmail({Function? onHas, Function? noHas}) async {
    checkingHasEmail.value = true;
    try {
      var data =
          await CustomerRepositoryManager.loginCustomerRepository.checkExists(
        email: textEditingControllerEmail.text,
      );

      for (var e in data!) {
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
      var data =
          await CustomerRepositoryManager.loginCustomerRepository.checkExists(
        phoneNumber: textEditingControllerPhone.text,
      );

      for (var e in data!) {
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
