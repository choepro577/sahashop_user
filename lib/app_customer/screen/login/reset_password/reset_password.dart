import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen/register/widget/text_field_customer_auth.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/utils/keyboard.dart';
import 'package:sahashop_user/app_user/utils/phone_number.dart';
import 'package:sahashop_user/shared/components/text_field/text_field_input_otp.dart';
import 'reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<ResetPasswordScreen> {
  ResetPasswordController resetPasswordController = ResetPasswordController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (resetPasswordController.newPassInputting.value == true) {
        return buildNewPasswordInputScreen();
      }
      return buildNumInputScreen();
    });
  }

  Widget buildNumInputScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy lại mật khẩu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFieldCustomerAuth(
                      textEditingController:
                          resetPasswordController.textEditingControllerNumberPhone,

                      autoFocus: true,

                      validator: (value) {
                        if (value!.length < 1) {
                          return 'Bạn chưa nhập số điện thoại';
                        }
                        return PhoneNumberValid.validateMobile(value);
                      },
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      label: "Số điện thoại",

                      icon: Icon(Icons.phone),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SahaButtonSizeChild(
                        width: 200,
                        text: "Tiếp tục",
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            KeyboardUtil.hideKeyboard(context);
                            resetPasswordController.newPassInputting.value = true;
                          }
                        }),
                    Spacer(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            resetPasswordController.resting.value
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    child: SahaLoadingWidget(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget buildNewPasswordInputScreen() {
    resetPasswordController.textEditingControllerOtp =
        new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy lại mật khẩu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            resetPasswordController.newPassInputting.value = false;
          },
        ),
      ),
      body: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: Text(
                        "Nhập mã OTP và nhập mật khẩu mới để lấy lại mật khẩu"),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    padding: EdgeInsets.all(20),
                  ),
                  TextFieldInputOtp(
                    numberPhone: resetPasswordController
                        .textEditingControllerNumberPhone.text,
                    textEditingController:
                        resetPasswordController.textEditingControllerOtp,
                    autoFocus: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldCustomerAuth(
                      textEditingController:
                          resetPasswordController.textEditingControllerNewPass,
                      autoFocus: true,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Mật khẩu mới phải lớn hơn 6 ký tự';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,

                      label: "Mật khẩu mới",

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SahaButtonSizeChild(
                      width: 200,
                      color: Theme.of(context).primaryColor,
                      text: "Tiếp tục",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          KeyboardUtil.hideKeyboard(context);
                          resetPasswordController.onReset();
                        }
                      }),
                  Spacer(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          Obx(
              () {
                return  resetPasswordController.resting.value
                    ? Container(
                  width: Get.width,
                  height: Get.height,
                  child: SahaLoadingWidget(),
                )
                    : Container();
              }
           )
          ],

      ),
    );
  }
}
