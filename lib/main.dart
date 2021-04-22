import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sahashop_user/const/const_database_hive.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';
import 'components/app_customer/screen/data_app_screen.dart';
import 'model/theme_model.dart';
import 'saha_load_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(DetailsAdapter());
  Hive.registerAdapter(AttributesAdapter());
  Hive.registerAdapter(ImageProductAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.openBox(CART);
  runApp(MyApp());
}

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
