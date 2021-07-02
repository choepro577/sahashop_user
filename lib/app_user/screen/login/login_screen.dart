import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/screen/sign_up/sign_up_screen.dart';
import 'package:sahashop_user/app_user/utils/keyboard.dart';
import 'package:sahashop_user/app_user/screen/login/login_screen_controller.dart';
import '../../const/constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<LoginScreen> {
  LoginController loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  bool? remember = false;

  TextEditingController textEditingControllerPhoneShop =
      new TextEditingController();
  TextEditingController textEditingControllerPass = new TextEditingController();

  // ignore: cancel_subscriptions
  StreamSubscription? sub;

  late PageController controller;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (loginController.loginInputting.value == true) {
            return buildLoginInputScreen();
          }
          return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/background_login.png",
                        height: Get.height * 0.7,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                      PageIndicatorContainer(
                        child: PageView(
                          children: <Widget>[
                            buildPage(
                                title: "Tạo và quản lý App bán hàng đơn giản",
                                image: "assets/images/page_login/page1.png"),
                            buildPage(
                                title: "Chỉnh sửa giao diện",
                                sub:
                                    "Tùy chỉnh giao diện App bán hàng theo sở thích và thẩm mỹ của bạn",
                                image: "assets/images/page_login/page2.png"),
                            buildPage(
                                title: "Tùy biến sản phẩm",
                                sub: "Tự tay quản lý sản phẩm theo ý muốn",
                                image: "assets/images/page_login/page3.png"),
                            buildPage(
                                title: "Chương trình khuyến mãi",
                                sub:
                                    "Thúc đẩy bán hàng với các chương trình khuyến mãi của bạn",
                                image: "assets/images/page_login/page4.png"),
                            buildPage(
                                title: "Báo cáo thống kê",
                                sub:
                                    "Quản lý bán hàng thông minh với chức năng báo cáo biểu đồ rõ ràng",
                                image: "assets/images/page_login/page5.png"),
                          ],
                          controller: controller,
                          reverse: true,
                        ),
                        align: IndicatorAlign.bottom,
                        length: 5,
                        indicatorColor: Colors.grey.withOpacity(0.7),
                        indicatorSelectorColor: SahaPrimaryColor,
                        indicatorSpace: 10.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Đăng nhập",
                    width: 200,
                    color: SahaPrimaryColor,
                    onPressed: () {
                      loginController.loginInputting.value = true;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SahaButtonSizeChild(width: 200, text: "Đăng ký",
                color: Colors.grey[500],
                onPressed: () {
                  Get.to(SignUpScreen());
                },
                ),
                SizedBox(height: 40),
                Text(
                  "© 2021 SAHA TECHNOLOGY JSC",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(height: 15),
              ],
            )
          ;
        },
      ),
    );
  }

  Widget buildPage({String? title, String? sub, String? image}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image ?? "",
          height: 150,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: SahaPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            sub ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoginInputScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            loginController.loginInputting.value = false;
          },
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SahaTextField(
                  controller: textEditingControllerPhoneShop,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.length < 9) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  labelText: "Số điện thoại",
                  hintText: "Mời nhập số điện thoại",
                  icon: Icon(Icons.email),
                ),
                SahaTextField(
                  controller: textEditingControllerPass,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.length < 1) {
                      return 'Mật khẩu không được để trống';
                    }
                    return null;
                  },
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  labelText: "Mật khẩu",
                  hintText: "Mời nhập mật khẩu",
                  icon: Icon(Icons.lock),
                ),


                SizedBox(
                  height: 30,
                ),
                SahaButtonSizeChild(
                    width: 200,
                    text: "Tiếp tục",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        KeyboardUtil.hideKeyboard(context);

                        loginController.onLogin(
                            shopPhone: textEditingControllerPhoneShop.text,
                            password: textEditingControllerPass.text);
                      }
                    }),
                Spacer(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Quên mật khẩu?"),
                    )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          loginController.logging.value ? Container(
            width: Get.width,
            height: Get.height,
            child: SahaLoadingWidget(),
          ) : Container()
        ],
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern as String);
  return (!regex.hasMatch(value)) ? false : true;
}
