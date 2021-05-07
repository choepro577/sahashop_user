import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/load_data/load_login.dart';
import 'package:sahashop_user/screen/home/home_screen.dart';
import 'package:sahashop_user/screen/login/loginScreen.dart';
import 'package:sahashop_user/utils/user_info.dart';

import 'data/remote/saha_service_manager.dart';
import 'load_data/load_data_local.dart';
import 'load_data/load_firebase.dart';

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
    LoadLogin.load();
    LoadDataLocal.load();
    LoadFirebase.initFirebase();

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
    Navigator.pushReplacement(
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
        decoration: BoxDecoration(
          color: Colors.white
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
