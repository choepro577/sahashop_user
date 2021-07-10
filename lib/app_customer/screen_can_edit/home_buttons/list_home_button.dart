import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/button_home.dart';
import '../../../app_customer/screen_default/data_app_controller.dart';
import '../repository_widget_config.dart';
import 'home_buttons_style_1/home_button_style_1.dart';
import 'list_home_button_controller.dart';

Widget buildImageButton({String? imageUrl, String? typeAction}) {
  Widget? svgImage;

  if (typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
    svgImage = SvgPicture.asset(
      "assets/app_customer/home_button/chat.svg",
      width: 15,
      height: 15,
    );
  }

  if (typeAction == mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]) {
    svgImage = SvgPicture.asset("assets/app_customer/home_button/chat.svg",
        width: 35,
        height: 35,
        color: SahaColorUtils().colorTextWithPrimaryColor());
  }

  return svgImage != null
      ? svgImage
      : CachedNetworkImage(
          imageUrl: imageUrl ?? "",
          fit: BoxFit.cover,
          placeholder: (context, url) => SahaLoadingContainer(),
          errorWidget: (context, url, error) => SahaEmptyImage(),
        );
}

class ListHomeButtonWidget extends StatelessWidget {
  DataAppCustomerController dataAppCustomerController = Get.find();
  ConfigController configController = Get.find();

  var WIDTH_BUTTON = 80;

  @override
  Widget build(BuildContext context) {
    var isScroll =
        configController.configApp.isScrollButton == false ? false : true;

    var buttonWidget;
    if (configController.configApp.typeButton != null &&
        configController.configApp.typeButton! <
            RepositoryWidgetCustomer().LIST_BUTTON_WIDGET.length) {
      buttonWidget = RepositoryWidgetCustomer()
          .LIST_BUTTON_WIDGET[configController.configApp.typeButton!];
    } else {
      buttonWidget = RepositoryWidgetCustomer().LIST_BUTTON_WIDGET[0];
    }

    var listButtons = dataAppCustomerController.homeData!.buttons?.list;
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
                    buttonWidget.homeButton = homeButton;
                    return buttonWidget;
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
                  buttonWidget.homeButton = homeButton;
                  return buttonWidget;
                },
                itemCount: listButtons.length,
                crossAxisCount:
                    (MediaQuery.of(context).size.width / WIDTH_BUTTON).floor(),
                mainAxisSpacing: 4,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
              );
  }
}
