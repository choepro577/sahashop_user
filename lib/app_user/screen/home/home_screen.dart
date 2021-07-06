import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/screen/account/account.dart';
import 'package:sahashop_user/app_user/screen/chat/chat_screen/all_message_user_screen.dart';
import 'package:sahashop_user/app_user/screen/config_payment/config_payment_screen.dart';
import 'package:sahashop_user/app_user/screen/config_store_address/config_store_address_screen.dart';
import 'package:sahashop_user/app_user/screen/customer_manage/customer_manage_screen.dart';
import 'package:sahashop_user/app_user/screen/home/home_controller.dart';
import 'package:sahashop_user/app_user/screen/inventory/inventory_screen.dart';
import 'package:sahashop_user/app_user/screen/maketing_chanel/marketing_chanel_screen.dart';
import 'package:sahashop_user/app_user/screen/order_manage/order_manage_screen.dart';
import 'package:sahashop_user/app_user/screen/posts/screen.dart';
import 'package:sahashop_user/app_user/screen/report/report_screen.dart';
import 'package:sahashop_user/app_user/screen/review_manager/review_page/review_manage_screen.dart';

import 'choose_store/choose_store.dart';
import 'widget/sliver_peristent.dart';
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
  var controllerScroll = new ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controllerScroll.addListener(() {
      handleScroll();
    });
  }

  void handleScroll() {
    if (controllerScroll.offset > 80) {
      homeController.changeOpacityText(0);
    } else if (controllerScroll.offset <= 0) {
      homeController.changeOpacityText(1);
    } else {
      var o = controllerScroll.offset / 80;
      homeController.changeOpacityText(1 - o);
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthButton = 65.0;
    final maxChildCount =
        (MediaQuery.of(context).size.width - 8 * 2) / widthButton;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var childAspectRatio = !isPortrait ? 100 / 40 : 90 / 110;

    final maxChildCount2 = (MediaQuery.of(context).size.width - 8 * 2) / 80;
    var childAspectRatio2 = !isPortrait ? 100 / 40 : 100 / 80;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.teal,
            )),
        body: CustomScrollView(controller: controllerScroll, slivers: <Widget>[
          SliverAppBar(
            floating: false,
            backgroundColor: SahaPrimaryColor,

            flexibleSpace: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 90,
                    color: SahaPrimaryColor,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 30, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(ReportScreen());
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Hôm nay",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "0₫",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => Text(
                                    homeController.storeCurrent?.value.name ==
                                            null
                                        ? "Xin chào"
                                        : homeController
                                            .storeCurrent!.value.name!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(ChooseStoreScreen());
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://pdp.edu.vn/wp-content/uploads/2021/01/hinh-anh-girl-xinh-toc-ngan-de-thuong.jpg",
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 80,
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: Delegate(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: SahaPrimaryColor,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: EdgeInsets.only(
                          bottom: 0, top: 4, left: 15, right: 15),
                      child: Container(
                        height: 110,
                        padding: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: SingleChildScrollView(
                          child: GridView.builder(
                            padding: EdgeInsets.all(8),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: childAspectRatio),
                            itemCount: 4,
                            itemBuilder: (context, pos) {
                              return [
                                Obx(
                                  () => ItemStoreView(
                                    icon: 'assets/app_user/svg/home/order.svg',
                                    text: 'Đơn hàng',
                                    opacityText: homeController.opacity.value,
                                    press: () {
                                      Get.to(() => OrderManageScreen());
                                    },
                                  ),
                                ),
                                Obx(
                                  () => ItemStoreView(
                                    icon: 'assets/app_user/svg/home/report.svg',
                                    text: 'Báo cáo',
                                    opacityText: homeController.opacity.value,
                                    press: () {
                                      Get.to(ReportScreen());
                                    },
                                  ),
                                ),
                                Obx(
                                  () => ItemStoreView(
                                    icon: 'assets/app_user/svg/home/chat.svg',
                                    text: 'Chat',
                                    opacityText: homeController.opacity.value,
                                    press: () {
                                      Get.to(() => AllMessageScreen());
                                    },
                                  ),
                                ),
                                Obx(
                                  () => ItemStoreView(
                                    icon: 'assets/app_user/svg/home/review.svg',
                                    text: 'Đánh giá từ khách',
                                    opacityText: homeController.opacity.value,
                                    press: () {
                                      Get.to(() => ReviewManageScreen());
                                    },
                                  ),
                                ),
                              ][pos];
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            'assets/app_user/svg/home/inventory.svg',
                            height: 30,
                            width: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Shop của bạn chưa có trên Google Play và Apple Store? Hãy đăng ký để đưa ứng dụng lên ",
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Text(
                                            "Đăng ký ngay",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 10,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cửa hàng",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.all(8),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: maxChildCount2.floor(),
                        childAspectRatio: childAspectRatio2),
                    itemCount: 4,
                    itemBuilder: (context, pos) {
                      return [
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/inventory.svg',
                          text: 'Chỉnh sửa mặt hàng',
                          press: () {
                            Get.to(InventoryScreen());
                          },
                        ),
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/customer.svg',
                          text: 'Khách hàng',
                          press: () {
                            Get.to(() => CustomerManageScreen());
                          },
                        ),
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/promotions.svg',
                          text: 'Chương trình khuyến mãi',
                          press: () {
                            Get.to(() => MarketingChanelScreen());
                          },
                        ),
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/news.svg',
                          text: 'Tin tức - Bài viết',
                          press: () {
                            Get.to(() => PostNaviScreen());
                          },
                        ),
                      ][pos];
                    },
                  ),
                  Divider(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cài đặt",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.all(8),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: maxChildCount2.floor(),
                        childAspectRatio: childAspectRatio2),
                    itemCount: 4,
                    itemBuilder: (context, pos) {
                      return [
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/ui.svg',
                          text: 'Chỉnh sửa giao diện',
                          press: () {
                            Get.toNamed("ConfigScreen");
                          },
                        ),
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/ship.svg',
                          text: 'Cài đặt vận chuyển',
                          press: () {
                            Get.to(() => ConfigStoreAddressScreen());
                          },
                        ),
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/pay.svg',
                          text: 'Cài đặt thanh toán',
                          press: () {
                            Get.to(() => ConfigPayment());
                          },
                        ),
                        ItemStoreView(
                          icon: 'assets/app_user/svg/home/account.svg',
                          text: 'Tài khoản',
                          press: () {
                            Get.to(() => AccountScreen());
                          },
                        ),
                      ][pos];
                    },
                  ),
                  Divider(
                    height: 20,
                  ),
                  SpecialOffers(),
                  Divider(
                    height: 10,
                  ),
                  SpecialOffers(),
                ],
              )
            ]),
          ),
        ]));
  }
}

class ItemStoreView extends StatelessWidget {
  const ItemStoreView({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    this.opacityText = 1,
  }) : super(key: key);

  final double opacityText;
  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: press,
      child: Container(

        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              height: 40,
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: AutoSizeText(
                text,
                textAlign: TextAlign.center,
                maxFontSize: 13,
                style:
                    TextStyle(color: Colors.black87.withOpacity(opacityText)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
