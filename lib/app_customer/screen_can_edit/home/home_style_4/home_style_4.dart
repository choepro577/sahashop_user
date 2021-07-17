import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_style_1/search_text_field_screen/search_text_field_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/home_buttons/list_home_button.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/home/home_style_4/home_style_4_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/chat_customer/chat_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/member/member_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/qr_screen/qr_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/search_bar_type5.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';

import '../home_body.dart';

class HomeScreenStyle4 extends StatefulWidget {
  const HomeScreenStyle4({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle4State createState() => _HomeScreenStyle4State();
}

class _HomeScreenStyle4State extends State<HomeScreenStyle4> {
  final ScrollController _scrollController = ScrollController();
  final HomeStyle4Controller homeStyle4Controller = HomeStyle4Controller();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      if (_scrollController.offset > 1 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        homeStyle4Controller.isTouch.value = true;
      } else if (_scrollController.offset < 1 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        homeStyle4Controller.isTouch.value = false;
      }
    });

    configController.addButton(context);
  }

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: configController.contactButton.isNotEmpty
            ? SpeedDial(
                marginEnd: 18,
                marginBottom: 20,
                icon: Icons.phone,
                activeIcon: Icons.read_more_sharp,
                buttonSize: 56.0,
                visible: true,
                closeManually: false,
                renderOverlay: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.grey[300],
                overlayOpacity: 0.5,
                onOpen: () => print('OPENING DIAL'),
                onClose: () => print('DIAL CLOSED'),
                tooltip: 'Speed Dial',
                heroTag: 'speed-dial-hero-tag',
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColor,
                elevation: 8.0,
                shape: CircleBorder(),
                children: configController.contactButton,
              )
            : Container(),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Positioned(
                    top: -200,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 800,
                      width: 800,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withOpacity(0.85),
                              Theme.of(context).primaryColor.withOpacity(0.4),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.5],
                            tileMode: TileMode.clamp),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      Container(
                        width: double.infinity,
                        child: BannerWidget(),
                      ),
                      HomeBodyWidget()
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => MemberScreen());
              },
              child: Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => Text(
                        "Chào bạn ${dataAppCustomerController.infoCustomer.value!.name ?? ""} !",
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(QRScreen());
                      },
                      child: SvgPicture.asset(
                        "assets/svg/qr-code-scan.svg",
                        height: 25,
                        width: 25,
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ChatCustomerScreen());
                      },
                      child: SvgPicture.asset(
                        "assets/icons/chat_appbar.svg",
                        height: 25,
                        width: 25,
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                top: homeStyle4Controller.isTouch.value ? 40 : 80,
                height: 40,
                right: homeStyle4Controller.isTouch.value ? 80 : 10,
                left: 10,
                //width: Get.width,
                child: SearchBarType5(
                  onSearch: () {
                    Get.to(CategoryProductScreen(
                      autoSearch: true,
                    ));
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key, this.category}) : super(key: key);

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(CategoryProductScreen(
            categoryId: category!.id,
          ));
        },
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: category!.imageUrl ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SahaLoadingContainer(),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    category!.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
