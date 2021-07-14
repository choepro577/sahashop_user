import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/utils/action_tap.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/button_home.dart';
import '../../../app_customer/screen_default/data_app_controller.dart';
import '../repository_widget_config.dart';
import 'list_home_button_controller.dart';
import 'package:collection/collection.dart';

Widget buildImageButton({String? imageUrl, String? typeAction}) {
  Widget? svgImage;

  if (typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
    svgImage = Center(
      child: SvgPicture.asset(
        "assets/app_customer/home_button/phone_call.svg",
        width: 35,
        height: 35,
        color: SahaColorUtils().colorTextWithPrimaryColor(),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/app_customer/home_button/chat.svg",
          width: 35,
          height: 35,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/app_customer/home_button/phone_call.svg",
          width: 35,
          height: 35,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.VOUCHER]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/app_customer/home_button/voucher.svg",
          width: 35,
          height: 35,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.QR]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/svg/qr-code.svg",
          width: 35,
          height: 35,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_TOP_SALES]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/app_customer/home_button/top_three.svg",
          width: 35,
          height: 35,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_NEW]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/app_customer/home_button/new.svg",
          width: 30,
          height: 30,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_DISCOUNT]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/app_customer/home_button/coupon.svg",
          width: 35,
          height: 35,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.SCORE]) {
    svgImage = Center(
      child: SvgPicture.asset("assets/app_customer/home_button/score.svg",
          width: 35,
          height: 35,
          color: SahaColorUtils().colorTextWithPrimaryColor()),
    );
  } else {
    if (imageUrl != null) {
      svgImage = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => SahaLoadingContainer(),
        errorWidget: (context, url, error) => SahaEmptyImage(),
      );
    } else {
      svgImage = Center(
        child: SvgPicture.asset(
          "assets/app_customer/home_button/forward.svg",
          width: 35,
          height: 35,
        ),
      );
    }
  }

  return svgImage;
}

class ListHomeButtonWidget extends StatelessWidget {
  DataAppCustomerController dataAppCustomerController = Get.find();
  ConfigController configController = Get.find();

  var WIDTH_BUTTON = 80;

  @override
  Widget build(BuildContext context) {
    var isScroll =
        configController.configApp.isScrollButton == false ? false : true;

    var listButtons;
    if (dataAppCustomerController.homeData?.listLayout != null) {
      var button = dataAppCustomerController.homeData?.listLayout
          ?.firstWhereOrNull((element) => element.model == 'HomeButton');

      if (button != null) {
        listButtons = button.list!.cast<HomeButton>();
      }
    }

    return listButtons == null || listButtons.length == 0
        ? Container()
        : isScroll
            ? Container(
                height: 100,
                child: new ListView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemBuilder: (context, pos) {
                    var homeButton = listButtons[pos];

                    return InkWell(
                      onTap: () {
                        ActionTap.onTap(listButtons[pos].typeAction,
                            listButtons[pos].value);
                      },
                      child: HomeButtonWidget(homeButton),
                    );
                  },
                  itemCount: listButtons.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                ),
              )
            : new StaggeredGridView.countBuilder(
                shrinkWrap: true,
                primary: true,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemBuilder: (context, pos) {
                  var homeButton = listButtons[pos];

                  return InkWell(
                    onTap: () {
                      ActionTap.onTap(
                          listButtons[pos].typeAction, listButtons[pos].value);
                    },
                    child: HomeButtonWidget(homeButton),
                  );
                },
                itemCount: listButtons.length,
                crossAxisCount:
                    (MediaQuery.of(context).size.width / WIDTH_BUTTON).floor(),
                mainAxisSpacing: 0,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
              );
  }
}

class HomeButtonWidget extends StatelessWidget {
  ConfigController configController = Get.find();
  HomeButton homeButton;

  HomeButtonWidget(this.homeButton);

  @override
  Widget build(BuildContext context) {
    var buttonWidget;
    if (configController.configApp.typeButton != null &&
        configController.configApp.typeButton! <
            RepositoryWidgetCustomer().LIST_BUTTON_WIDGET.length) {
      buttonWidget = RepositoryWidgetCustomer()
          .LIST_BUTTON_WIDGET[configController.configApp.typeButton!];
    } else {
      buttonWidget = RepositoryWidgetCustomer().LIST_BUTTON_WIDGET[0];
    }
    buttonWidget.homeButton = homeButton;

    return buttonWidget;
  }
}
