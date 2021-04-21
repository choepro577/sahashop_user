import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/screen/home/home_screen.dart';
import 'package:sahashop_user/screen/login/loginScreen.dart';
import 'package:sahashop_user/utils/user_info.dart';

import 'data/remote/saha_service_manager.dart';

class SahaMainScreen extends StatefulWidget {
  @override
  _SahaMainScreenState createState() => _SahaMainScreenState();
}

class _SahaMainScreenState extends State<SahaMainScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadInit(context);
  }

  void loadInit(BuildContext context) {
    SahaServiceManager.initialize();
    CustomerServiceManager.initialize();

    checkLogin(context);
  }

  Future<void> checkLogin(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    if (await UserInfo().hasLogged()) {
      hasLogged(context);
    } else {
      noLogin(context);
    }
  }

  hasLogged(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  noLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icon.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
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
