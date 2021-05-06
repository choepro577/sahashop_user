import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/screen/config_app/config_screen.dart';
import 'package:sahashop_user/screen/home/choose_store/choose_store.dart';
import 'package:sahashop_user/screen/inventory/inventory_screen.dart';
import 'package:sahashop_user/screen/maketing_chanel/marketing_chanel_screen.dart';
import '../home_controller.dart';

class HeadHome extends StatelessWidget {
  List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/flash_icon.svg", "text": "Báo cáo"},
    {"icon": "assets/icons/bill_icon.svg", "text": "Đơn hàng", "numOfitem": 40},
    {"icon": "assets/icons/gift_icon.svg", "text": "Các ưu đãi"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
    // {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
    // {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
  ];

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [SahaPrimaryColor, SahaPrimaryLightColor],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.5, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
              ),
              Obx(() => Center(
                      child: Text(
                    homeController?.storeCurrent?.value?.name == null
                        ? "Xin chào"
                        : homeController.storeCurrent.value.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ))),
              Obx(() => !homeController.isExpansion.value
                  ? Container()
                  : Hero(
                      tag: "switch",
                      child: buttonExpansion(true),
                    ))
            ],
          ),
        ),
        Obx(() => AnimatedContainer(
              width: double.infinity,
              height: homeController.isExpansion.value ? 0 : 320,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInQuad,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemStoreView(
                              icon: 'assets/icons/flash_icon.svg',
                              text: 'Chọn cửa hàng',
                              press: () {
                                Get.to(ChooseStoreScreen());
                              },
                            ),
                            ItemStoreView(
                              icon: 'assets/icons/flash_icon.svg',
                              text: 'Chỉnh sửa mặt hàng',
                              press: () {
                                Get.to(InventoryScreen());
                              },
                            ),
                            ItemStoreView(
                              icon: 'assets/icons/gift_icon.svg',
                              text: 'Chỉnh sửa giao diện',
                              press: () {
                                Get.to(() => ConfigScreen());

                              },
                            ),
                            ItemStoreView(
                              icon: 'assets/icons/gift_icon.svg',
                              text: 'Chương trình khuyến mãi',
                              press: () {
                                Get.to(() => MarketingChanelScreen());

                              },
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(),
                        Hero(
                          tag: "switch",
                          child: buttonExpansion(false),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget buttonExpansion(bool isShow) {
    return InkWell(
      onTap: () {
        homeController.onChangeExpansion(!isShow);
      },
      child: Container(
        height: 30,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: Colors.blueGrey),
            color: Colors.white),
        child: Icon(!isShow ? Icons.arrow_drop_up : Icons.arrow_drop_down),
      ),
    );
  }
}

class ItemStoreView extends StatelessWidget {
  const ItemStoreView({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        child: MaterialButton(
          onPressed: press,
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [SahaPrimaryColor, SahaPrimaryLightColor],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.5, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: SvgPicture.asset(
                    icon,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Text(text, textAlign: TextAlign.center),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
