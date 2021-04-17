import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'data_app_controller.dart';

class LoadAppScreen extends StatefulWidget {
  final String logo;

  const LoadAppScreen({Key key, this.logo}) : super(key: key);

  @override
  _LoadAppScreenState createState() => _LoadAppScreenState();
}

class _LoadAppScreenState extends State<LoadAppScreen> {
  var dataAppController = Get.put(DataAppController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadInit(context);
  }

  Future<void> loadInit(BuildContext context) async {
    // CustomerServiceManager.initialize();
    await dataAppController.getAppTheme();
    await Future.delayed(Duration(seconds: 1));
    Get.off(() =>
        LIST_WIDGET_HOME_SCREEN[dataAppController.configApp.homePageType]);
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
                widget.logo ?? dataAppController.configApp.logoUrl,
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

class SplashAppCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
