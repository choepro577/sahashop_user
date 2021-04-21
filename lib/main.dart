import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sahashop_user/screen/config_app/widget/button_back_overlay.dart';

import 'components/app_customer/screen/data_app_screen.dart';
import 'model/theme_model.dart';
import 'saha_load_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/loadApp', page: () => LoadAppScreen()),
      ],
      title: 'SahaShop',
      theme: SahaUserPrimaryTheme,
      home: SahaMainScreen(),
    );
  }
}
