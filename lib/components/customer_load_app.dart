import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sahashop_user/components/customer_screen/home_screen/customer_screen.dart';
import 'package:sahashop_user/components/data_app_customer/remote/customer_service_manager.dart';

class CustomerMainScreen extends StatefulWidget {
  @override
  _CustomerMainScreenState createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadInit(context);
  }

  Future<void> loadInit(BuildContext context) async {
    CustomerServiceManager.initialize();
    await Future.delayed(Duration(seconds: 1));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerScreen()));
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
