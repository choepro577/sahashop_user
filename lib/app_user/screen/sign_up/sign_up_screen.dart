import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/const/sms_pincode.dart';
import 'package:sahashop_user/app_user/utils/keyboard.dart';
import 'package:sahashop_user/app_user/screen/login/login_screen_controller.dart';
import 'package:sahashop_user/app_user/screen/setup_Info/setup_info_shop.dart';
import 'package:sahashop_user/app_user/utils/phone_number.dart';

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

      if (signUpController.phoneInputtingPinCode.value == true) {
        return buildInputPinCode();
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
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SahaTextField(
                controller: signUpController.textEditingControllerName,
                onChanged: (value) {},
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
              SahaTextField(
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
                obscureText: false,
                labelText: "Email",
                hintText: "Mời nhập email của bạn",
              ),
              SizedBox(height: 15),
              Center(
                child: SahaButtonSizeChild(
                  text: "Tiếp tục",
                  width: 200,
                  color: SahaPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUpController.phoneInputting.value = true;
                    }
                  },
                ),
              ),
              SizedBox(height: 40)
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
      body: Form(
        key: formKey2,
        child: Column(
          children: [
            SahaTextField(
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
              labelText: "Số điện thoại",
              hintText: "Nhập số điện thoại",
              icon: Icon(Icons.lock),
            ),
            SahaTextField(
              controller: signUpController.textEditingControllerPass,
              onChanged: (value) {},
              validator: (value) {
                if (value!.length < 6) {
                  return 'Mật khẩu phải hơn 6 kí tự';
                }
                return null;
              },
              textInputType: TextInputType.text,
              obscureText: true,
              labelText: "Mật khẩu",
              hintText: "Đặt mật khẩu",
              icon: Icon(Icons.lock),
            ),
            SizedBox(height: 15),
            Center(
              child: SahaButtonSizeChild(
                text: "Tiếp tục",
                width: 200,
                color: SahaPrimaryColor,
                onPressed: () {
                  if(formKey2.currentState!.validate()) {
                    signUpController.phoneInputting.value = false;
                    signUpController.phoneInputtingPinCode.value = true;
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputPinCode() {
    final formKey3 = GlobalKey<FormState>();

    signUpController.textEditingControllerPinCode = new TextEditingController();
    return Scaffold(
      appBar: SahaAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            signUpController.phoneInputting.value = true;
            signUpController.phoneInputtingPinCode.value = false;
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
                Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.white,
                        length: 6,
                        //obscureText: true,
                        controller: signUpController.textEditingControllerPinCode,
                        obscuringCharacter: '*',
                        // obscuringWidget: Container(
                        //
                        // ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 6) {
                            return "Hãy điền đủ 6 mã số";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          inactiveColor: SahaPrimaryColor,
                          activeColor: SahaPrimaryColor,
                          activeFillColor: Colors.white,
                          disabledColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedColor: SahaPrimaryColor,
                          selectedFillColor: Colors.white,
                          fieldWidth: 40,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        autoFocus: true,
                        //errorAnimationController: errorController,
                        // controller: signUpController.textEditingControllerPinCode,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },

                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Dùng chính xác số điện thoại ${signUpController.textEditingControllerPhone.text} nhận mã hoặc soạn tin nhắn với nội dung $FIRST_CODE_SMS tới số $NUMBER_CODE_SMS để nhận mã (phí 500đ) ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    signUpController.sendSms();
                  },
                  child: Column(
                    children: [
                      Text(
                        "NHẬN MÃ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: SahaPrimaryColor),
                      ),
                      Text("(500đ)",
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Hoàn thành",
                    width: 200,
                    color: SahaPrimaryColor,
                    onPressed: () {
                      if(formKey3.currentState!.validate()) {
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

// if (_formKey.currentState!.validate()) {
// _formKey.currentState!.save();
// phoneShop = textEditingControllerPhoneShop.text;
//
// KeyboardUtil.hideKeyboard(context);
// signUpController.onSignUp(
// shopPhone: textEditingControllerPhoneShop.text,
// pass: textEditingControllerPass.text,
// );
// phoneShop = textEditingControllerPhoneShop.text;
// }
