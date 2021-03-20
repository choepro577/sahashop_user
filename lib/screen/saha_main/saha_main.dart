import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sahashop_user/screen/home/home_screen.dart';
import 'package:sahashop_user/screen/login/loginScreen.dart';
import 'package:sahashop_user/utils/user_info.dart';


class SahaMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SahaMainScreenState();
  }
}

class SahaMainScreenState extends State<SahaMainScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<Timer> checkUser() async {
    await Future.delayed(Duration(seconds: 1));
    if (await UserInfo().hasLogged()) {
      hasLogged();
    } else {
      noLogin();
    }
  }

  hasLogged() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        settings: RouteSettings(name: '/home'),
        builder: (context) {
          return HomeScreen();
        }));
  }


  noLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        settings: RouteSettings(name: '/navigation'),
        builder: (context) {
          return LoginScreen();
        }));
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
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text("SahaShop",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),)
            ],
          ),
        ),
      ),
    );
  }
}