import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/utils/phone_number.dart';
import 'package:sahashop_user/shared/components/text_field/text_field_input_otp.dart';

import 'sign_up_screen_controller.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = new SignUpController();

  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  String? phoneShop;
  // ignore: cancel_subscriptions
  StreamSubscription? sub;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (signUpController.phoneInputting.value == true) {
        return buildNumberInput();
      }

      if (signUpController.phoneInputtingOtp.value == true) {
        return buildInputOtp();
      }

      return Scaffold(
        appBar: SahaAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
          titleText: "Đăng ký",
        ),
        body: Obx(
          () => Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SahaTextField(
                      controller: signUpController.textEditingControllerName,
                      withAsterisk: true,
                      onChanged: (value) {},
                      textCapitalization: TextCapitalization.sentences,
                      autoFocus: true,
                      validator: (value) {
                        if (value!.length < 1) {
                          return 'Tên không được để trống';
                        }
                        return null;
                      },
                      obscureText: false,
                      labelText: "Tên đầy đủ",
                      hintText: "Mời nhập tên của bạn",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    SahaTextField(
                      withAsterisk: true,
                      controller: signUpController.textEditingControllerEmail,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.length < 1) {
                          return 'Không được để trống';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Email không hợp lệ';
                        }
                        return null;
                      },
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      labelText: "Email",
                      hintText: "Mời nhập email của bạn",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: SahaButtonSizeChild(
                        text: "Tiếp tục",
                        width: 200,
                        color: SahaPrimaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signUpController.checkHasEmail(noHas: () {
                              signUpController.phoneInputting.value = true;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              ),
              signUpController.checkingHasEmail.value
                  ? SahaLoadingFullScreen()
                  : Container()
            ],
          ),
        ),
      );
    });
  }

  Widget buildNumberInput() {
    final formKey2 = GlobalKey<FormState>();

    return Scaffold(
      appBar: SahaAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            signUpController.phoneInputting.value = false;
          },
        ),
        titleText: "Đăng ký",
      ),
      body: Stack(
        children: [
          Form(
            key: formKey2,
            child: Column(
              children: [
                SahaTextField(
                  withAsterisk: true,
                  controller: signUpController.textEditingControllerPhone,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.length < 1) {
                      return 'Bạn chưa nhập số điện thoại';
                    }
                    return PhoneNumberValid.validateMobile(value);
                  },
                  textInputType: TextInputType.number,
                  obscureText: false,
                  autoFocus: true,
                  labelText: "Số điện thoại",
                  hintText: "Nhập số điện thoại",
                  icon: Icon(Icons.lock),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SahaTextField(
                  withAsterisk: true,
                  controller: signUpController.textEditingControllerPass,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Mật khẩu phải hơn 6 kí tự';
                    }
                    return null;
                  },
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  labelText: "Mật khẩu",
                  hintText: "Đặt mật khẩu",
                  icon: Icon(Icons.lock),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Tiếp tục",
                    width: 200,
                    color: SahaPrimaryColor,
                    onPressed: () {
                      if (formKey2.currentState!.validate()) {
                        signUpController.checkHasPhoneNumber(noHas: () {
                          signUpController.phoneInputting.value = false;
                          signUpController.phoneInputtingOtp.value = true;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          signUpController.checkingHasPhone.value ? SahaLoadingFullScreen() : Container()
        ],
      ),
    );
  }

  Widget buildInputOtp() {
    final formKey3 = GlobalKey<FormState>();

    return Scaffold(
      appBar: SahaAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            signUpController.phoneInputting.value = true;
            signUpController.phoneInputtingOtp.value = false;
          },
        ),
        titleText: "Đăng ký",
      ),
      body: Form(
        key: formKey3,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFieldInputOtp(
                  numberPhone: signUpController.textEditingControllerPhone.text,
                  onChanged: (va) {
                    signUpController.otp = va;
                  },
                ),
                SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Hoàn thành",
                    width: 200,
                    color: SahaPrimaryColor,
                    onPressed: () {
                      if (formKey3.currentState!.validate()) {
                        signUpController.onSignUp();
                      }
                    },
                  ),
                ),
              ],
            ),
            signUpController.signUpping.value
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      child: SahaLoadingWidget(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
