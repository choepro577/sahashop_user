import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'components/app_customer/screen/data_app_screen.dart';
import 'model/theme_model.dart';
import 'saha_load_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SahaShop',
      theme: SahaUserPrimaryTheme,
      home: SahaMainScreen(),
    );
  }
}
