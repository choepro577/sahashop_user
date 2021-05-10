import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/utils/keyboard.dart';
import 'package:sahashop_user/screen/home/home_screen.dart';
import 'package:sahashop_user/screen/login/loginScreen_controller.dart';
import 'package:sahashop_user/screen/sign_up/signUpScreen.dart';
import '../../const/constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<LoginScreen> {
  LoginController loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  bool remember = false;

  TextEditingController textEditingControllerPhoneShop =
      new TextEditingController();
  TextEditingController textEditingControllerPass = new TextEditingController();

  // ignore: cancel_subscriptions
  StreamSubscription sub;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sub ??= loginController.stateLogin.listen((state) {
      if (state != "success") {
        SahaDialogApp.showDialogError(context: context, errorMess: state);
        //Get.to(HomeScreen());
        EasyLoading.dismiss();
      }

      if (state == "success") {
        print("Đăng nhập thành công");
        Get.to(HomeScreen());
        EasyLoading.dismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SahaAppBar(
        titleText:  "Sign In",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Sign in with your email and password \n       or continue with social media",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SahaTextField(
                controller: textEditingControllerPhoneShop,
                onChanged: (value) {},
                // validator: (value) {
                //   if (!validateEmail(value)) {
                //     return 'Email không hợp lệ';
                //   }
                //   return null;
                // },
                validator: (value) {
                  if (value.length < 6) {
                    return 'mật khẩu chứa hơn 6 kí tự';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                labelText: "Email",
                hintText: "Enter your email",
                icon: Icon(Icons.email),
              ),
              SahaTextField(
                controller: textEditingControllerPass,
                onChanged: (value) {},
                validator: (value) {
                  if (value.length < 3) {
                    return 'mật khẩu chứa hơn 6 kí tự';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                labelText: "Password",
                hintText: "Enter your password",
                icon: Icon(Icons.lock),
              ),
              SizedBox(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Row(
                  children: [
                    Checkbox(
                      value: remember,
                      activeColor: bmColors,
                      onChanged: (value) {
                        setState(() {
                          remember = value;
                        });
                      },
                    ),
                    Text("Remember me"),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    EasyLoading.show(status: 'loading...',
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: true
                    );
                    loginController.onLogin(
                        shopPhone: textEditingControllerPhoneShop.text,
                        password: textEditingControllerPass.text);
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(12),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/google-icon.svg"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(12),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/facebook-2.svg"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16, color: bmColors),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
