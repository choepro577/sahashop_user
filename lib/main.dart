import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'components/app_customer/screen/data_app_screen.dart';
import 'model/theme_model.dart';
import 'saha_data_controller.dart';
import 'saha_load_app.dart';
import 'screen/config_app/config_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  SahaDataController sahaDataController = Get.put(SahaDataController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'SahaShop',
        theme: SahaUserPrimaryTheme,
        home: SahaMainScreen(),
        // routes: {"ConfigScreen": (context) => ConfigScreen()},
        getPages: [GetPage(name: "ConfigScreen", page: () => ConfigScreen())],
        builder: (context, widget) => Column(
              children: [
                Expanded(child: widget),
                Obx(
                  () => !sahaDataController.isPreview.value
                      ? Container()
                      : Material(
                          child: InkWell(
                            onTap: () {
                              Get.offNamedUntil("ConfigScreen",
                                  (route) => route.settings.name == "ConfigScreen"
                              );
                              Get.back();
                              sahaDataController.changeStatusPreview(false);
                            },
                            child: Container(
                              height: 23,
                              width: Get.width,
                              color: Colors.redAccent,
                              child: Center(
                                  child: AutoSizeText(
                                "Bạn đang xem thử App, nhấp vào đây để trở về",
                                maxFontSize: 13,
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                maxLines: 2,
                              )),
                            ),
                          ),
                        ),
                )
              ],
            ));
  }
}
