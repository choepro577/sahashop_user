import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/font_data/font_data.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/config_app.dart';
import 'package:unicorndial/unicorndial.dart';

class DataAppController extends GetxController {
  ConfigApp configApp = ConfigApp();
  var currentTheme = ThemeData().obs;
  var contactButton = RxList<UnicornButton>();
  var isLoadingGet = false.obs;
  var isLoadingCreate = false.obs;

  Future<void> getAppTheme() async {
    isLoadingGet.value = true;
    try {
      var data =
          await CustomerRepositoryManager.configUiRepository.getAppTheme();

      configApp.colorMain1 = data.colorMain1 ?? "#ff93b9b4";

      configApp.fontFamily =
          data.fontFamily != null && FONT_DATA.containsKey(data.fontFamily)
              ? data.fontFamily
              : FONT_DATA.keys.toList()[0];
      configApp.searchType = data.searchType ?? 0;
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
      isLoadingGet.value = false;
      addButton();
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingGet.value = false;
  }

  void addButton() {
    if (configApp.isShowIconHotline == true) {
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.phoneNumberHotline ?? "",
          currentButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Icon(Icons.phone),
            onPressed: () {},
          )));
    }
    if (configApp.isShowIconEmail == true) {
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.contactEmail ?? "",
          currentButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Icon(Icons.email),
            onPressed: () {},
          )));
    }
    if (configApp.isShowIconFacebook == true) {
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.idFacebook ?? "",
          currentButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
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
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configApp.idZalo ?? "",
          currentButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
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
}
