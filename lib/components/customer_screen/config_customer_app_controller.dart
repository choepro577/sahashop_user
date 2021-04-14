import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/data_app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/data_app_customer/screen/font_data/font_data.dart';
import 'package:sahashop_user/components/model_app_customer/config_app_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:unicorndial/unicorndial.dart';

class ConfigAppCustomerController extends GetxController {
  ConfigAppCustomer configAppCustomer = ConfigAppCustomer();
  var currentTheme = ThemeData().obs;
  var contactButton = RxList<UnicornButton>().obs;
  var isLoadingGet = false.obs;
  var isLoadingCreate = false.obs;

  Future<void> getAppTheme() async {
    isLoadingGet.value = true;
    try {
      var data =
          await CustomerRepositoryManager.configUiRepository.getAppTheme();

      configAppCustomer.colorMain1 = data.colorMain1 ?? "#ff93b9b4";

      configAppCustomer.fontFamily =
          data.fontFamily != null && FONT_DATA.containsKey(data.fontFamily)
              ? data.fontFamily
              : FONT_DATA.keys.toList()[0];
      configAppCustomer.searchType = data.searchType ?? 0;
      configAppCustomer.carouselType = data.carouselType ?? 0;
      configAppCustomer.homePageType = data.homePageType ?? 0;
      configAppCustomer.categoryPageType = data.categoryPageType ?? 0;
      configAppCustomer.productPageType = data.productPageType ?? 0;
      configAppCustomer.cartPageType = data.cartPageType ?? 0;
      configAppCustomer.logoUrl = data.logoUrl ?? "";
      configAppCustomer.phoneNumberHotline = data.phoneNumberHotline ?? "";
      configAppCustomer.contactEmail = data.contactEmail ?? "";
      configAppCustomer.idFacebook = data.idFacebook ?? "";
      configAppCustomer.idZalo = data.idZalo ?? "";
      configAppCustomer.isShowIconHotline = data.isShowIconHotline ?? false;
      configAppCustomer.isShowIconEmail = data.isShowIconEmail ?? false;
      configAppCustomer.isShowIconFacebook = data.isShowIconFacebook ?? false;
      configAppCustomer.isShowIconZalo = data.isShowIconZalo ?? false;
      isLoadingGet.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingGet.value = false;
  }

  void addButton() {
    if (configAppCustomer.isShowIconHotline == true) {
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configAppCustomer.phoneNumberHotline ?? "",
          currentButton: FloatingActionButton(
            heroTag: "train",
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Icon(Icons.phone),
            onPressed: () {},
          )));
    }
    if (configAppCustomer.isShowIconEmail == true) {
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configAppCustomer.contactEmail ?? "",
          currentButton: FloatingActionButton(
            heroTag: "train",
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Icon(Icons.email),
            onPressed: () {},
          )));
    }
    if (configAppCustomer.isShowIconFacebook == true) {
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configAppCustomer.idFacebook ?? "",
          currentButton: FloatingActionButton(
            heroTag: "train",
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
    if (configAppCustomer.isShowIconZalo == true) {
      contactButton.value.add(UnicornButton(
          hasLabel: true,
          labelText: configAppCustomer.idZalo ?? "",
          currentButton: FloatingActionButton(
            heroTag: "train",
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
