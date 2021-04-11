import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'model/theme_model.dart';
import 'saha_load_app.dart';

void main() => runApp(ChangeNotifierProvider<ThemeModel>(
    create: (BuildContext context) => ThemeModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SahaShop',
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: SahaMainScreen(),
    );
  }
}
