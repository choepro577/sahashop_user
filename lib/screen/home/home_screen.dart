import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/screen/chat/chat_screen/all_message_user_screen.dart';
import 'package:sahashop_user/screen/config_payment/config_payment_screen.dart';
import 'package:sahashop_user/screen/config_store_address/config_store_address_screen.dart';
import 'package:sahashop_user/screen/customer_manage/customer_manage_screen.dart';
import 'package:sahashop_user/screen/home/home_controller.dart';
import 'package:sahashop_user/screen/inventory/inventory_screen.dart';
import 'package:sahashop_user/screen/maketing_chanel/marketing_chanel_screen.dart';
import 'package:sahashop_user/screen/order_manage/order_manage_screen.dart';
import 'package:sahashop_user/screen/posts/screen.dart';
import 'package:sahashop_user/screen/report/report_screen.dart';

import 'choose_store/choose_store.dart';
import 'widget/special_offers.dart';

const ITEM_HEIGHT = 100.0;
const ITEM_WIDTH = 100.0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedItem = 0;

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final double itemHeight = ITEM_HEIGHT;
    final double itemWidth = ITEM_WIDTH;
    var childAspectRatio = 100 / itemWidth;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            title: Obx(
              () => Text(homeController.storeCurrent?.value.name == null
                  ? "Xin chào"
                  : homeController.storeCurrent!.value.name!),
            ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.notifications),
                highlightColor: Colors.white,
                onPressed: () {},
              ),
            ],
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: CachedNetworkImage(
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://pdp.edu.vn/wp-content/uploads/2021/01/hinh-anh-girl-xinh-toc-ngan-de-thuong.jpg",
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  'Shop của bạn chưa có trên CHPlay và Appstore?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: Colors.white)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(ChooseStoreScreen());
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.white)))),
                                child: Text("Chuyển shop"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Cửa hàng",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              GridView.count(
                childAspectRatio: childAspectRatio,
                crossAxisCount: (Get.width / itemWidth).floor(),
                padding: EdgeInsets.all(5),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ItemStoreView(
                    icon: 'assets/icons/flash_icon.svg',
                    text: 'Đơn hàng',
                    press: () {
                      Get.to(() => OrderManageScreen());
                    },
                  ),
                  ItemStoreView(
                    icon: 'assets/icons/flash_icon.svg',
                    text: 'Báo cáo',
                    press: () {
                      Get.to(ReportScreen());
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
                    icon: 'assets/icons/flash_icon.svg',
                    text: 'Khách hàng',
                    press: () {
                      Get.to(() => CustomerManageScreen());
                    },
                  ),
                  ItemStoreView(
                    icon: 'assets/icons/gift_icon.svg',
                    text: 'Chương trình khuyến mãi',
                    press: () {
                      Get.to(() => MarketingChanelScreen());
                    },
                  ),
                  ItemStoreView(
                    icon: 'assets/icons/gift_icon.svg',
                    text: 'Chat',
                    press: () {
                      Get.to(() => AllMessageScreen());
                    },
                  ),
                  ItemStoreView(
                    icon: 'assets/icons/gift_icon.svg',
                    text: 'Tin tức - Bài viết',
                    press: () {
                      Get.to(() => PostNaviScreen());
                    },
                  ),
                ],
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Divider(),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Cài đặt",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              GridView.count(
                childAspectRatio: childAspectRatio,
                crossAxisCount: (Get.width / itemWidth).floor(),
                padding: EdgeInsets.all(5),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ItemStoreView(
                    icon: 'assets/icons/gift_icon.svg',
                    text: 'Chỉnh sửa giao diện',
                    press: () {
                      Get.toNamed("ConfigScreen");
                    },
                  ),
                  ItemStoreView(
                    icon: 'assets/icons/gift_icon.svg',
                    text: 'Cài đặt vận chuyển',
                    press: () {
                      Get.to(() => ConfigStoreAddressScreen());
                    },
                  ),
                  ItemStoreView(
                    icon: 'assets/icons/gift_icon.svg',
                    text: 'Cài đặt thanh toán',
                    press: () {
                      Get.to(() => ConfigPayment());
                    },
                  ),
                ],
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              SpecialOffers(),
            ])),
          ],
        ),
      ),
    );
  }
}

class ItemStoreView extends StatelessWidget {
  const ItemStoreView({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: press,
      child: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 40,
              width: 40,
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
            SizedBox(
              height: 10,
            ),
            Expanded(child: AutoSizeText(text, textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}
