import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/components/saha_user/sahashopTextField.dart';
import 'package:sahashop_user/helper/keyboard.dart';
import 'package:sahashop_user/screen/login/loginScreen_controller.dart';
import 'package:sahashop_user/screen/setup_Info/setup_info_shop.dart';

import 'signUpScreen_controller.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = new SignUpController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController textEditingControllerPhoneShop = new TextEditingController();
  TextEditingController textEditingControllerPass = new TextEditingController();

  LoginController loginController = LoginController();
  String phoneShop;
  // ignore: cancel_subscriptions
  StreamSubscription sub;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sub ??= signUpController.stateSignUp.listen((state) {
      if (state != "success") {
        DialogApp.showDialogError(context: context,errorMess: state);
        EasyLoading.dismiss();
      }

      if (state == "success") {
        loginController.onLogin(shopPhone: textEditingControllerPhoneShop.text, password: textEditingControllerPass.text);
        Get.to(SetUpInfoShop());
        EasyLoading.dismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.grey,
          onPressed: (){
            Get.back();
          },
        ),
        title: Text(
          "Sign In",
          style: TextStyle(color: Colors.grey[600]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                "Complete Profile",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SahaTextField(
                controller: textEditingControllerPhoneShop,
                onChanged: (value) {},
                validator: (value) {
                  if (value.length < 9) {
                    return 'Bạn chưa nhập số điện thoại';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                obscureText: false,
                labelText: "Số điện thoại",
                hintText: "Nhập số điện thoại",
                icon: Icon(Icons.lock),
              ),
              SahaTextField(
                controller: textEditingControllerPass,
                onChanged: (value) {},
                validator: (value) {
                  if (value.length < 6) {
                    return 'mật khẩu chứa hơn 6 kí tự';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                labelText: "Mật khẩu",
                hintText: "Đặt mật khẩu",
                icon: Icon(Icons.lock),
              ),
              SahaTextField(
                onChanged: (value) {},
                validator: (value) {
                  if (value.length < 6) {
                    return 'mật khẩu chứa hơn 6 kí tự';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                labelText: "Xác nhận mật khẩu",
                hintText: "Xác nhận mật khẩu",
                icon: Icon(Icons.lock),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    phoneShop = textEditingControllerPhoneShop.text;
                    EasyLoading.show();
                    KeyboardUtil.hideKeyboard(context);
                    signUpController.onSignUp(
                        shopPhone: textEditingControllerPhoneShop.text,
                        pass: textEditingControllerPass.text,
                    );
                    phoneShop = textEditingControllerPhoneShop.text;
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
