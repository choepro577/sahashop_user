import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/config_app.dart';
import 'package:sahashop_user/model/theme_model.dart';
import 'package:sahashop_user/screen/config_app/screens_config/font_type/font_data.dart';
import 'package:sahashop_user/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();
  var currentTheme = ThemeData().obs;
  var indexTab = 0.obs;
  var isLoadingGet = false.obs;
  var isLoadingCreate = false.obs;
  var contactButton = RxList<SpeedDialChild>();

  @override
  void onInit() {
    super.onInit();
    getAppTheme();
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
  void update([List<Object>? ids, bool condition = true]) {
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
            MaterialColor(HexColor.getColorFromHex(configApp.colorMain1!), {
          50: HexColor(configApp.colorMain1!).withOpacity(0.1),
          100: HexColor(configApp.colorMain1!).withOpacity(0.2),
          200: HexColor(configApp.colorMain1!).withOpacity(0.3),
          300: HexColor(configApp.colorMain1!).withOpacity(0.4),
          400: HexColor(configApp.colorMain1!).withOpacity(0.5),
          500: HexColor(configApp.colorMain1!).withOpacity(0.6),
          600: HexColor(configApp.colorMain1!).withOpacity(0.7),
          700: HexColor(configApp.colorMain1!).withOpacity(0.8),
          800: HexColor(configApp.colorMain1!).withOpacity(0.9),
          900: HexColor(configApp.colorMain1!).withOpacity(1),
        }));

    Get.changeTheme(currentTheme.value);
  }

  Future<bool?> getAppTheme() async {
    try {
      isLoadingGet.value = true;
      var data = (await RepositoryManager.configUiRepository.getAppTheme())!;
      configApp.colorMain1 = data.colorMain1 ?? "#ff93b9b4";
      configApp.fontFamily =
          data.fontFamily != null && FONT_DATA.containsKey(data.fontFamily)
              ? data.fontFamily
              : FONT_DATA.keys.toList()[0];
      configApp.searchType = data.searchType ?? 0;
      if (configApp.searchType! > LIST_WIDGET_SEARCH_BAR.length) {
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
      isLoadingGet.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi lấy dữ liệu Config App");
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

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void addButton(BuildContext context) {
    if (contactButton.isEmpty) {
      if (configApp.isShowIconHotline == true) {
        contactButton.add(
          SpeedDialChild(
            child: Icon(
              Icons.phone,
              color: Theme.of(context).primaryColor,
            ),
            backgroundColor: Colors.white,
            label: configApp.phoneNumberHotline!.isEmpty
                ? null
                : configApp.phoneNumberHotline,
            labelStyle: TextStyle(fontSize: 14.0),
            labelBackgroundColor: Colors.white,
            onTap: () => makePhoneCall(
              'tel:+214324234',
            ),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }
      if (configApp.isShowIconEmail == true) {
        contactButton.add(
          SpeedDialChild(
            child: Icon(Icons.email, color: Theme.of(context).primaryColor),
            backgroundColor: Colors.white,
            label:
                configApp.contactEmail!.isEmpty ? null : configApp.contactEmail,
            labelStyle: TextStyle(fontSize: 14.0),
            labelBackgroundColor: Colors.white,
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }
      if (configApp.isShowIconFacebook == true) {
        contactButton.add(
          SpeedDialChild(
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
            backgroundColor: Colors.white,
            label: configApp.idFacebook!.isEmpty ? null : configApp.idFacebook,
            labelStyle: TextStyle(fontSize: 14.0),
            labelBackgroundColor: Colors.white,
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }
      if (configApp.isShowIconZalo == true) {
        contactButton.add(
          SpeedDialChild(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/zalo.svg"),
            ),
            backgroundColor: Colors.white,
            label: configApp.idZalo!.isEmpty ? null : configApp.idZalo,
            labelStyle: TextStyle(fontSize: 14.0),
            labelBackgroundColor: Colors.white,
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
        );
      }
    }
  }

  void deleteContactButton() {
    contactButton = new RxList<SpeedDialChild>();
  }
}
