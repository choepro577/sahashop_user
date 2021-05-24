import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:sahashop_user/components/app_customer/screen/register/register_controller.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:get/get.dart';

class RegisterCustomerScreen extends StatelessWidget {
  RegisterController registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
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
                        controller: registerController
                            .nameAccountEditingController.value,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Số điện thoại",
                        ),
                        style: TextStyle(fontSize: 15),
                        minLines: 1,
                        maxLines: 1,
                        onChanged: (v) {
                          registerController.nameAccountEditingController
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
                          controller: registerController
                              .passwordEditingController.value,
                          obscureText: registerController.isHidePassword.value,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Mật khẩu",
                          ),
                          style: TextStyle(fontSize: 15),
                          minLines: 1,
                          maxLines: 1,
                          onChanged: (v) {
                            registerController.passwordEditingController
                                .refresh();
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            registerController.isHidePassword.value =
                                !registerController.isHidePassword.value;
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Obx(() => registerController
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
              Container(
                height: 50,
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset(
                        "assets/icons/group.svg",
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: registerController
                            .introduceCodeEditingController.value,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Nhập mã giới thiệu để đc nhận quà nhé !",
                        ),
                        style: TextStyle(fontSize: 15),
                        minLines: 1,
                        maxLines: 1,
                        onChanged: (v) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => registerController.nameAccountEditingController.value.text
                            .isNotEmpty &&
                        registerController
                            .passwordEditingController.value.text.isNotEmpty
                    ? SahaButtonFullParent(
                        text: "Đăng ký",
                        onPressed: () {
                          registerController.registerAccount();
                        },
                        color: Theme.of(context).primaryColor,
                      )
                    : IgnorePointer(
                        child: SahaButtonFullParent(
                          text: "Đăng ký",
                          textColor: Colors.grey[600],
                          onPressed: () {},
                          color: Colors.grey[300],
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
