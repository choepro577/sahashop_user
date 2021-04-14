import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/customer_screen/config_customer_app_controller.dart';
import 'package:sahashop_user/components/data_app_customer/data_widget_config.dart';
import 'package:sahashop_user/screen/config_app/config_controller.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  ConfigAppCustomerController configController =
      Get.put(ConfigAppCustomerController());

  @override
  void initState() {
    // TODO: implement initState
    configController.getAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          LIST_WIDGET_HOME_SCREEN[
              configController.configAppCustomer.homePageType ?? 1]
        ],
      ),
    );
  }
}
