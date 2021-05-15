import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/const/const_database_hive.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/config_app.dart';
import 'package:sahashop_user/model/theme_model.dart';
import 'package:sahashop_user/screen/config_app/screens_config/font_type/font_data.dart';
import 'package:sahashop_user/utils/color.dart';
import 'package:sahashop_user/utils/user_info.dart';
import 'package:unicorndial/unicorndial.dart';

class ConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();
  var currentTheme = ThemeData().obs;
  var indexTab = 0.obs;

  var isLoadingGet = false.obs;
  var isLoadingCreate = false.obs;
  var contactButton = RxList<UnicornButton>();

  @override
  void onInit() {
    super.onInit();
    getAppTheme();
    openBoxHiveCurrentStore();
  }

  @override
  void onClose() {
    Get.changeTheme(SahaUserPrimaryTheme);
    deleteContactButton();
    print("onclose");
  }

  @override
  void refresh() {
    print("refresh");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void update([List<Object> ids, bool condition = true]) {
    print("upddate");
  }

  ConfigController() {
    currentTheme.value = ThemeData(
      primarySwatch: Colors.cyan,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void setTab(int va) {
    indexTab.value = va;
  }

  void updateTheme() {
    currentTheme.value = ThemeData(
        fontFamily: configApp.fontFamily,
        primarySwatch:
            MaterialColor(HexColor.getColorFromHex(configApp.colorMain1), {
          50: HexColor(configApp.colorMain1).withOpacity(0.1),
          100: HexColor(configApp.colorMain1).withOpacity(0.2),
          200: HexColor(configApp.colorMain1).withOpacity(0.3),
          300: HexColor(configApp.colorMain1).withOpacity(0.4),
          400: HexColor(configApp.colorMain1).withOpacity(0.5),
          500: HexColor(configApp.colorMain1).withOpacity(0.6),
          600: HexColor(configApp.colorMain1).withOpacity(0.7),
          700: HexColor(configApp.colorMain1).withOpacity(0.8),
          800: HexColor(configApp.colorMain1).withOpacity(0.9),
          900: HexColor(configApp.colorMain1).withOpacity(1),
        }));

    Get.changeTheme(currentTheme.value);
  }

  Future<void> getAppTheme() async {
    try {
      isLoadingGet.value = true;
      var data = await RepositoryManager.configUiRepository.getAppTheme();
      configApp.colorMain1 = data.colorMain1 ?? "#ff93b9b4";
      configApp.fontFamily =
          data.fontFamily != null && FONT_DATA.containsKey(data.fontFamily)
              ? data.fontFamily
              : FONT_DATA.keys.toList()[0];
      configApp.searchType = data.searchType ?? 0;
      if (configApp.searchType > LIST_WIDGET_SEARCH_BAR.length) {
        configApp.searchType = LIST_WIDGET_SEARCH_BAR.length - 1;
      }
      configApp.carouselType = data.carouselType ?? 0;
      configApp.homePageType = data.homePageType ?? 0;
      configApp.categoryPageType = data.categoryPageType ?? 0;
      configApp.productPageType = data.productPageType ?? 0;
      configApp.cartPageType = data.cartPageType ?? 0;
      configApp.logoUrl = data.logoUrl ?? "";
      configApp.phoneNumberHotline = data.phoneNumberHotline ?? "";
      configApp.contactEmail = data.contactEmail ?? "";
      configApp.idFacebook = data.idFacebook ?? "";
      configApp.idZalo = data.idZalo ?? "";
      configApp.isShowIconHotline = data.isShowIconHotline ?? false;
      configApp.isShowIconEmail = data.isShowIconEmail ?? false;
      configApp.isShowIconFacebook = data.isShowIconFacebook ?? false;
      configApp.isShowIconZalo = data.isShowIconZalo ?? false;
      configApp.carouselAppImages = data.carouselAppImages;
      updateTheme();
      addButton();
      isLoadingGet.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      isLoadingGet.value = false;
    }
  }

  Future<void> createAppTheme() async {
    isLoadingCreate.value = true;
    try {
      var data =
          await RepositoryManager.configUiRepository.createAppTheme(configApp);
      SahaAlert.showSuccess(message: "Cập nhật thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }

  void addButton() {
    if (configApp.isShowIconHotline == true) {
      contactButton.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.phoneNumberHotline ?? "",
          currentButton: FloatingActionButton(
            heroTag: "hotline",
            backgroundColor: currentTheme.value.primaryColor,
            mini: true,
            child: Icon(Icons.phone),
            onPressed: () {},
          )));
    }
    if (configApp.isShowIconEmail == true) {
      contactButton.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.contactEmail ?? "",
          currentButton: FloatingActionButton(
            heroTag: "email",
            backgroundColor: currentTheme.value.primaryColor,
            mini: true,
            child: Icon(Icons.email),
            onPressed: () {},
          )));
    }
    if (configApp.isShowIconFacebook == true) {
      contactButton.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.idFacebook ?? "",
          currentButton: FloatingActionButton(
            heroTag: "facebook",
            backgroundColor: currentTheme.value.primaryColor,
            mini: true,
            child: Container(
              padding: EdgeInsets.all(12),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/facebook-2.svg"),
            ),
            onPressed: () {},
          )));
    }
    if (configApp.isShowIconZalo == true) {
      contactButton.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.idZalo ?? "",
          currentButton: FloatingActionButton(
            heroTag: "zalo",
            backgroundColor: currentTheme.value.primaryColor,
            mini: true,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/zalo.svg"),
            ),
            onPressed: () {},
          )));
    }
  }

  void deleteContactButton() {
    contactButton = RxList<UnicornButton>();
  }

  void openBoxHiveCurrentStore() {
    Hive.openBox(CART + '${UserInfo().getCurrentStoreCode()}');
  }
}
