import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'data_app_controller.dart';

class LoadAppScreen extends StatefulWidget {
  final String? logo;
  const LoadAppScreen({Key? key, this.logo}) : super(key: key);

  @override
  _LoadAppScreenState createState() => _LoadAppScreenState();
}

class _LoadAppScreenState extends State<LoadAppScreen> {
  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  var isInit = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadInit(context);
  }

  Future<void> loadInit(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    isInit = true;

    Get.offNamed('customer_home')!.then((value) {
      //Get.back();
    });
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
              Image.network(
                widget.logo == null
                    ? "https://sahavi.vn/wp-content/uploads/2018/11/cb9551447aa689f8d0b7-1536x524.png"
                    : configController.configApp.logoUrl!,
                height: 150,
                width: 150,
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
