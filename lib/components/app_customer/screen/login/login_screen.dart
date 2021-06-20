import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:sahashop_user/components/app_customer/screen/login/login_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/register/register_customer_screen.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:get/get.dart';

class LoginScreenCustomer extends StatelessWidget {
  @override
  ConfigController configController = Get.find();
  LoginController loginController = LoginController();
  StreamSubscription? sub;

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width,
                height: 50,
              ),
              Container(
                height: 70,
                width: 70,
                child: CachedNetworkImage(
                  imageUrl: configController.configApp.logoUrl ??
                      "https://scontent.fhan4-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=uUCcbPvUrGYAX_8i3-1&_nc_ht=scontent.fhan4-1.fna&oh=5e3a391a8ec68f487149d6432595442c&oe=60D25ECA",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller:
                            loginController.nameAccountEditingController.value,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Tài khoản",
                        ),
                        style: TextStyle(fontSize: 15),
                        minLines: 1,
                        maxLines: 1,
                        onChanged: (v) {
                          loginController.nameAccountEditingController
                              .refresh();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.lock_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Obx(
                        () => TextField(
                          controller:
                              loginController.passwordEditingController.value,
                          obscureText: loginController.isHidePassword.value,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Mật khẩu",
                          ),
                          style: TextStyle(fontSize: 15),
                          minLines: 1,
                          maxLines: 1,
                          onChanged: (v) {
                            loginController.passwordEditingController.refresh();
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            loginController.isHidePassword.value =
                                !loginController.isHidePassword.value;
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Obx(() => loginController
                                    .isHidePassword.value
                                ? SvgPicture.asset("assets/icons/eyelash.svg")
                                : SvgPicture.asset(
                                    "assets/icons/visible_eye.svg")),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Quên?",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => loginController.nameAccountEditingController.value.text
                            .isNotEmpty &&
                        loginController
                            .passwordEditingController.value.text.isNotEmpty
                    ? SahaButtonFullParent(
                        text: "Đăng nhập",
                        onPressed: () {
                          loginController.loginAccount(
                              loginController
                                  .nameAccountEditingController.value.text,
                              loginController
                                  .passwordEditingController.value.text);
                          sub ??=
                              loginController.isLoginSuccess.listen((state) {
                            if (state == true) {
                              Get.back();
                              SahaAlert.showError(
                                  message: "Đăng nhập thành công");
                            }
                          });
                        },
                        color: Theme.of(context).primaryColor,
                      )
                    : IgnorePointer(
                        child: SahaButtonFullParent(
                          text: "Đăng nhập",
                          textColor: Colors.grey[600],
                          onPressed: () {},
                          color: Colors.grey[300],
                        ),
                      ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => RegisterCustomerScreen());
                  },
                  child: Text("Đăng ký"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
