import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/member/member_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/qr_screen/qr_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

import '../home_body.dart';
import 'home_style_1_controller.dart';
import 'widget/box_button.dart';

class HomeScreenStyle1 extends StatefulWidget {
  const HomeScreenStyle1({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle1State createState() => _HomeScreenStyle1State();
}

class _HomeScreenStyle1State extends State<HomeScreenStyle1> {
  HomeStyle1Controller homeStyle1Controller = HomeStyle1Controller();
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        homeStyle1Controller.changeOpacitySearch(1);
      } else {
        homeStyle1Controller
            .changeOpacitySearch(_scrollController.offset / 100);
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
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      BannerWidget(),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(QRScreen());
                                  },
                                  child: SvgPicture.asset(
                                    "assets/svg/qr-code-scan.svg",
                                    height: 30,
                                    width: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.grey,
                                  width: 10,
                                ),
                                dataAppCustomerController.infoCustomer.value ==
                                        null
                                    ? Container()
                                    : Container(
                                        child: Text(
                                          "${dataAppCustomerController.infoCustomer.value!.name ?? "Xin chào"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ),
                                Spacer(),
                                VerticalDivider(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => MemberScreen());
                                  },
                                  child: dataAppCustomerController
                                              .infoCustomer.value !=
                                          null
                                      ? Container(

                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/style1/money.png",
                                                        height: 13,
                                                        width: 13,
                                                        color: Colors.amber,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${dataAppCustomerController.badge.value.customerScore} điểm",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Săn điểm ngay",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Colors.grey,
                                                size: 12,
                                              )
                                            ],
                                          ),
                                        )
                                      : Row(children: [
                                          Text(
                                            "Tích điểm",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.grey,
                                            size: 12,
                                          )
                                        ]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),

                  HomeBodyWidget(),
                ],
              ),
            ),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(microseconds: 250),
                height: 100,
                width: double.infinity,
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(homeStyle1Controller.opacity.value),
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: SearchBarType1(
                  onSearch: () {
                    Get.to(CategoryProductScreen(
                      autoSearch: true,
                    ));
                  },
                ),
              ),
            )
          ],
        ));
  }
}
