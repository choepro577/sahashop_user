import 'package:flutter/cupertino.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/const/sms_pincode.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class SignUpController extends GetxController {
  var stateSignUp = "".obs;
  var signUpping = false.obs;
  var shopPhones = "".obs;
  var phoneInputting = false.obs;
  var phoneInputtingPinCode = false.obs;

  TextEditingController textEditingControllerPhone =
      new TextEditingController();
  TextEditingController textEditingControllerPass = new TextEditingController();
  TextEditingController textEditingControllerEmail =
      new TextEditingController();
  TextEditingController textEditingControllerName = new TextEditingController();

  TextEditingController textEditingControllerPinCode =
      new TextEditingController();

  Future<void> onSignUp() async {
    signUpping.value = true;
    try {
      var dataRegister = await RepositoryManager.registerRepository.register(
          phone: textEditingControllerPhone.text,
          pass: textEditingControllerPass.text,
          name: textEditingControllerName.text,
          pincode: textEditingControllerPinCode.text,
          email: textEditingControllerEmail.text);

    } catch (err) {
      SahaAlert.showError(message: err.toString());

    }
    signUpping.value = false;
  }

  Future<void> sendSms() async {
    try {
      String _result = await sendSMS(
          message: FIRST_CODE_SMS, recipients: ["+"+NUMBER_CODE_SMS]);
    } catch (error) {
     SahaAlert.showError(message: "Có lỗi khi gửi SMS");

    }
  }
}
