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
import 'register_controller.dart';
import 'widget/text_field_customer_auth.dart';

class RegisterCustomerScreen extends StatefulWidget {
  @override
  _RegisterCustomerScreenState createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  RegisterController registerController = new RegisterController();

  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  String? phoneShop;
  // ignore: cancel_subscriptions
  StreamSubscription? sub;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (registerController.phoneInputting.value == true) {
        return buildNumberInput();
      }

      if (registerController.phoneInputtingOtp.value == true) {
        return buildInputOtp();
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text("Đăng ký"),
        ),
        body: Obx(
          () => Stack(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFieldCustomerAuth(
                        textEditingController:
                            registerController.textEditingControllerName,
                        label: "Tên đầy đủ",
                        icon: Icon(
                          Icons.account_box,
                          color: Colors.grey,
                        ),
                        validator: (value) {
                          if (value!.length < 1) {
                            return 'Tên không được để trống';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      TextFieldCustomerAuth(
                        textEditingController:
                            registerController.textEditingControllerEmail,
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        validator: (value) {
                          if (value!.length < 1) {
                            return 'Không được để trống';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                        label: "Email",
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
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              registerController.checkHasEmail(noHas: () {
                                registerController.phoneInputting.value = true;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 40)
                    ],
                  ),
                ),
              ),
              registerController.checkingHasEmail.value
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            registerController.phoneInputting.value = false;
          },
        ),
        title: Text("Đăng ký"),
      ),
      body: Stack(
        children: [
          Form(
            key: formKey2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFieldCustomerAuth(
                    textEditingController:
                        registerController.textEditingControllerPhone,
                    label: "Số điện thoại",
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    autoFocus: true,
                    icon: Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                    validator: (value) {
                      if (value!.length < 1) {
                        return 'Bạn chưa nhập số điện thoại';
                      }
                      return PhoneNumberValid.validateMobile(value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  TextFieldCustomerAuth(
                    textEditingController:
                        registerController.textEditingControllerPass,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Mật khẩu phải hơn 6 kí tự';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    label: "Mật khẩu",
                    icon: Icon(Icons.lock,color: Colors.grey,),
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
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (formKey2.currentState!.validate()) {
                          registerController.checkHasPhoneNumber(noHas: () {
                            registerController.phoneInputting.value = false;
                            registerController.phoneInputtingOtp.value = true;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          registerController.checkingHasPhone.value
              ? SahaLoadingFullScreen()
              : Container()
        ],
      ),
    );
  }

  Widget buildInputOtp() {
    final formKey3 = GlobalKey<FormState>();

    registerController.textEditingControllerOtp = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            registerController.phoneInputting.value = true;
            registerController.phoneInputtingOtp.value = false;
          },
        ),
        title: Text("Đăng ký"),
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
                  numberPhone:
                      registerController.textEditingControllerPhone.text,
                  textEditingController:
                      registerController.textEditingControllerOtp,
                ),
                SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Hoàn thành",
                    width: 200,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (formKey3.currentState!.validate()) {
                        registerController.onSignUp();
                      }
                    },
                  ),
                ),
              ],
            ),
            registerController.signUpping.value
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
