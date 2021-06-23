import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'components/app_customer/screen/navigation_scrren/navigation_screen.dart';
import 'model/theme_model.dart';
import 'saha_data_controller.dart';
import 'saha_load_app.dart';
import 'screen/config_app/config_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        debugShowCheckedModeBanner: false,
        theme: SahaUserPrimaryTheme,
        home: SahaMainScreen(),
        getPages: [
          GetPage(name: "ConfigScreen", page: () => ConfigScreen()),
          GetPage(name: "customer_home", page: () => NavigationScreen())
        ],
        builder: (context, widget) => Column(
              children: [
                Expanded(child: widget!),
                Obx(
                  () => !sahaDataController.isPreview.value
                      ? Container()
                      : Material(
                          child: InkWell(
                            onTap: () {
                              Get.until((route) =>
                                  route.settings.name == "ConfigScreen");

                        sahaDataController.changeStatusPreview(false);
                      },
                      child: Container(
                        height: 35,
                        width: Get.width,
                        color: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Center(
                                  child: AutoSizeText(
                                "Bạn đang xem thử App, nhấp vào đây để trở về",
                                maxFontSize: 13,
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                maxLines: 2,
                              )),
                            ),
                            Icon(
                              Icons.west,
                              size: 15,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('vi', 'VN'),
      ],
    );
  }
}
