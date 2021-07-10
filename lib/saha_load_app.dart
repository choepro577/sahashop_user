import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/screen/home/home_screen.dart';
import 'package:sahashop_user/app_user/screen/login/login_screen.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

import 'app_user/utils/showcase.dart';

class SahaMainScreen extends StatefulWidget {
  @override
  _SahaMainScreenState createState() => _SahaMainScreenState();
}

class _SahaMainScreenState extends State<SahaMainScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadInit(context);
    ShowCase().getStateShowCase();
  }

  void loadInit(BuildContext context) {
    checkLogin(context);
  }

  Future<void> checkLogin(BuildContext context) async {
    if (await UserInfo().hasLogged()) {
      hasLogged(context);
    } else {
      noLogin(context);
    }
  }

  hasLogged(BuildContext context) {
    Get.offAll(() => HomeScreen());
  }

  noLogin(BuildContext context) {
    Get.offAll(() => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   stops: [0.1, 0.5, 0.7, 0.9],
            //   colors: [
            //    SahaPrimaryColor,
            //     SahaPrimaryLightColor
            //   ],
            // ),
            ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Image.asset(
                  "assets/logo.png",
                  height: 150,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Text(
              //   "SahaShop",
              //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
