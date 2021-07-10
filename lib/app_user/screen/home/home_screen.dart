import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:sahashop_user/app_user/utils/init/get_position_widget.dart';
import 'package:sahashop_user/app_user/utils/showcase.dart';
import 'package:showcaseview/showcaseview.dart';
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

  GlobalKey editProduct = GlobalKey();
  GlobalKey configUI = GlobalKey();

  GlobalKey order = GlobalKey();
  GlobalKey report = GlobalKey();
  GlobalKey chat = GlobalKey();
  GlobalKey review = GlobalKey();
  GlobalKey customer = GlobalKey();
  GlobalKey editSale = GlobalKey();
  GlobalKey post = GlobalKey();
  GlobalKey shipment = GlobalKey();
  GlobalKey payment = GlobalKey();

  GetPositionSaha? positionEditProduct;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controllerScroll.addListener(() {
      handleScroll();
    });

    positionEditProduct ??= GetPositionSaha(
      key: editProduct,
      padding: EdgeInsets.all(5),
      screenWidth: MediaQuery.of(context).size.width,
      screenHeight: MediaQuery.of(context).size.height,
    );
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
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
          if (index == 0 && key == editProduct) {
            homeController.requiredProduct.value = true;
          }
          if (key == payment) {
            ShowCase().setStateShowCase(false);
            homeController.isFirstTimeLogin.value = false;
          }
        },
        builder: Builder(
          builder: (context) => Stack(
            children: [
              CustomScrollView(controller: controllerScroll, slivers: <Widget>[
                SliverAppBar(
                  floating: false,
                  backgroundColor: SahaPrimaryColor,

                  flexibleSpace: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: SahaPrimaryColor,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 30, right: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ReportScreen());
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
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //onTap();
                                      Get.to(ChooseStoreScreen())!
                                          .then((value) => {
                                                if (homeController
                                                        .isFirstTimeLogin
                                                        .value ==
                                                    true)
                                                  {
                                                    if(homeController.isFirstTimeLogin.value == true) {
                                                      ShowCaseWidget.of(context)!
                                                          .startShowCase(
                                                          [editProduct]),
                                                    }
                                                  }
                                              });
                                    },
                                    child: Row(
                                      children: [
                                        Obx(
                                          () => Text(
                                            homeController.storeCurrent?.value
                                                        .name ==
                                                    null
                                                ? "Tạo Shop ngay!"
                                                : homeController
                                                    .storeCurrent!.value.name!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: CachedNetworkImage(
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "https://pdp.edu.vn/wp-content/uploads/2021/01/hinh-anh-girl-xinh-toc-ngan-de-thuong.jpg",
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error)),
                                        ),
                                      ],
                                    ),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
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
                                        () => showCase(
                                          key: order,
                                          title: 'Theo dõi đơn hàng !',
                                          description:
                                              'Kiểm tra tình trạng các đơn hàng, và thay đổi trạng thái đơn hàng của khách hàng',
                                          onTargetClick: () {
                                            Get.to(() => OrderManageScreen())!
                                                .then((value) => {

                                              ShowCaseWidget.of(context)!
                                                  .startShowCase([
                                                report,
                                                chat,
                                                review,
                                                customer,
                                                editSale,
                                                post,
                                                shipment,
                                                payment,
                                              ])
                                            });
                                          },
                                          child: ItemStoreView(
                                            icon:
                                                'assets/app_user/svg/home/order.svg',
                                            text: 'Đơn hàng',
                                            opacityText:
                                                homeController.opacity.value,
                                            press: () {
                                              Get.to(() => OrderManageScreen());
                                            },
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => showCase(
                                          key: report,
                                          title: 'Báo cáo doanh thu !',
                                          description:
                                              'Báo cáo doanh thu, lượt xem, top sản phẩm,\nvv ...Theo thời gian chi tiết',
                                          onTargetClick: () {
                                            Get.to(() => ReportScreen())!.then((value) =>
                                            {
                                              ShowCaseWidget.of(context)!
                                                  .startShowCase([
                                                chat,
                                                review,
                                                customer,
                                                editSale,
                                                post,
                                                shipment,
                                                payment,
                                              ])
                                            });
                                          },
                                          child: ItemStoreView(
                                            icon:
                                                'assets/app_user/svg/home/report.svg',
                                            text: 'Báo cáo',
                                            opacityText:
                                                homeController.opacity.value,
                                            press: () {
                                              Get.to(() => ReportScreen());
                                            },
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => showCase(
                                          key: chat,
                                          title: 'Chat với khác hàng !',
                                          description:
                                              'Nơi giao tiếp với khách hàng trao đổi các vấn đề liên quan',
                                          onTargetClick: () {
                                            Get.to(() => AllMessageScreen())!.then((value) =>
                                            {
                                              ShowCaseWidget.of(context)!
                                                  .startShowCase([
                                                review,
                                                customer,
                                                editSale,
                                                post,
                                                shipment,
                                                payment,
                                              ])
                                            });
                                          },
                                          child: ItemStoreView(
                                            icon:
                                                'assets/app_user/svg/home/chat.svg',
                                            text: 'Chat',
                                            opacityText:
                                                homeController.opacity.value,
                                            press: () {
                                              Get.to(() => AllMessageScreen());
                                            },
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => showCase(
                                          key: review,
                                          title: 'Quản lí đánh giá !',
                                          description:
                                              'Phê duyệt đánh giá của khách hàng về sản phẩm',
                                          onTargetClick: () {
                                            Get.to(() => ReviewManageScreen())!.then((value) =>
                                            {
                                              ShowCaseWidget.of(context)!
                                                  .startShowCase([
                                                customer,
                                                editSale,
                                                post,
                                                shipment,
                                                payment,
                                              ])
                                            });
                                          },
                                          child: ItemStoreView(
                                            icon:
                                                'assets/app_user/svg/home/review.svg',
                                            text: 'Đánh giá từ khách',
                                            opacityText:
                                                homeController.opacity.value,
                                            press: () {
                                              Get.to(
                                                  () => ReviewManageScreen());
                                            },
                                          ),
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
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
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
                                          color: Colors.grey[800],
                                          fontSize: 12),
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: maxChildCount2.floor(),
                                  childAspectRatio: childAspectRatio2),
                          itemCount: 4,
                          itemBuilder: (context, pos) {
                            return [
                              showCase(
                                key: editProduct,
                                title: 'Chỉnh sửa mặt hàng !',
                                description:
                                    'Đầu tiên bạn cần thêm các sản phẩm bày bán trên app muốn tạo',
                                onTargetClick: () {
                                  Get.to(() => InventoryScreen())!
                                      .then((value) => {
                                            ShowCaseWidget.of(context)!
                                                .startShowCase([
                                              configUI,
                                              order,
                                              report,
                                              chat,
                                              review,
                                              customer,
                                              editSale,
                                              post,
                                              shipment,
                                              payment,
                                            ])
                                          });
                                },
                                child: ItemStoreView(
                                  icon:
                                      'assets/app_user/svg/home/inventory.svg',
                                  text: 'Chỉnh sửa mặt hàng',
                                  press: () {
                                    Get.to(() => InventoryScreen());
                                  },
                                ),
                              ),
                              showCase(
                                key: customer,
                                title: 'Quản lí khách hàng !',
                                description:
                                    'Quản lý tích điểm, Xem đầy đủ thông tin \n của khác hàng: tên, tuổi, các đơn hàng',
                                onTargetClick: () {
                                  Get.to(() => CustomerManageScreen())!.then((value) =>
                                  {
                                    ShowCaseWidget.of(context)!
                                        .startShowCase([
                                      editSale,
                                      post,
                                      shipment,
                                      payment,
                                    ])
                                  });
                                },
                                child: ItemStoreView(
                                  icon: 'assets/app_user/svg/home/customer.svg',
                                  text: 'Khách hàng',
                                  press: () {
                                    Get.to(() => CustomerManageScreen());
                                  },
                                ),
                              ),
                              showCase(
                                key: editSale,
                                title: 'Chương trình khuyến mãi !',
                                description:
                                    'Tạo các chương trình khuyến mãi: Giảm giá sản phẩm, thêm, xoá, sửa các Voucher, Combo sản phẩm',
                                onTargetClick: () {
                                  Get.to(() => MarketingChanelScreen())!.then((value) =>
                                  {
                                    ShowCaseWidget.of(context)!
                                        .startShowCase([
                                      post,
                                      shipment,
                                      payment,
                                    ])
                                  });
                                },
                                child: ItemStoreView(
                                  icon:
                                      'assets/app_user/svg/home/promotions.svg',
                                  text: 'Chương trình khuyến mãi',
                                  press: () {
                                    Get.to(() => MarketingChanelScreen());
                                  },
                                ),
                              ),
                              showCase(
                                key: post,
                                title: 'Tin tức - Bài viết !',
                                description:
                                    'Đưa các thông báo, tin tức bài viết lên app của khách hàng',
                                onTargetClick: () {
                                  Get.to(() => PostNaviScreen())!.then((value) =>
                                  {
                                    ShowCaseWidget.of(context)!
                                        .startShowCase([
                                      shipment,
                                      payment,
                                    ])
                                  });
                                },
                                child: ItemStoreView(
                                  icon: 'assets/app_user/svg/home/news.svg',
                                  text: 'Tin tức - Bài viết',
                                  press: () {
                                    Get.to(() => PostNaviScreen());
                                  },
                                ),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: maxChildCount2.floor(),
                                  childAspectRatio: childAspectRatio2),
                          itemCount: 4,
                          itemBuilder: (context, pos) {
                            return [
                              showCase(
                                key: configUI,
                                title: 'Chỉnh sửa giao diện !',
                                description:
                                    'Bây giờ bạn có thể vào chỉnh sửa giao diện app khách hàng tuỳ ý',
                                onTargetClick: () {
                                  Get.toNamed("ConfigScreen")!.then((value) => {
                                        ShowCaseWidget.of(context)!
                                            .startShowCase([
                                          order,
                                          report,
                                          chat,
                                          review,
                                          customer,
                                          editSale,
                                          post,
                                          shipment,
                                          payment,
                                        ])
                                      });
                                },
                                child: ItemStoreView(
                                  icon: 'assets/app_user/svg/home/ui.svg',
                                  text: 'Chỉnh sửa giao diện',
                                  press: () {
                                    Get.toNamed("ConfigScreen");
                                  },
                                ),
                              ),
                              showCase(
                                key: shipment,
                                title: 'Cài đặt vận chuyển !',
                                description:
                                    'Tại đây Bạn cần có tài khoản của các nhà vận\nchuyển, sau đó lấy mã token thêm vào\nlà có thể sử dụng dịch vụ',
                                onTargetClick: () {
                                  Get.to(() => ConfigStoreAddressScreen())!.then((value) =>
                                  {
                                    ShowCaseWidget.of(context)!
                                        .startShowCase([
                                      payment,
                                    ])
                                  });
                                },
                                child: ItemStoreView(
                                  icon: 'assets/app_user/svg/home/ship.svg',
                                  text: 'Cài đặt vận chuyển',
                                  press: () {
                                    Get.to(() => ConfigStoreAddressScreen());
                                  },
                                ),
                              ),
                              showCase(
                                key: payment,
                                title: 'Cài đặt thanh toán !',
                                description:
                                    'Thêm một số phương thức thanh toán online, VNPay, MoMo, vv...',
                                onTargetClick: () {
                                  Get.to(() => ConfigPayment());
                                },
                                child: ItemStoreView(
                                  icon: 'assets/app_user/svg/home/pay.svg',
                                  text: 'Cài đặt thanh toán',
                                  press: () {
                                    Get.to(() => ConfigPayment());
                                  },
                                ),
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
              ]),
              Obx(
                () => homeController.checkNoStore.value == true
                    ? Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[600]!.withOpacity(0.8),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 30, right: 10, bottom: 20),
                              child: Container(
                                width: 200,
                                height: 50,
                                padding: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white)),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(ChooseStoreScreen())!
                                        .then((value) => {
                                              if (homeController
                                                      .isFirstTimeLogin.value ==
                                                  true)
                                                {
                                                  ShowCaseWidget.of(context)!
                                                      .startShowCase(
                                                          [editProduct])
                                                }
                                            });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Tạo Shop ngay!",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: CachedNetworkImage(
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                "https://pdp.edu.vn/wp-content/uploads/2021/01/hinh-anh-girl-xinh-toc-ngan-de-thuong.jpg",
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              right: 230,
                              child: SvgPicture.asset(
                                "assets/svg/back_arrow_home.svg",
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => homeController.requiredProduct.value
                    ? Stack(
                        children: [
                          Container(
                            height: Get.height,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[700]!.withOpacity(0.8),
                            ),
                          ),
                          Positioned(
                            top: positionEditProduct!.getTop() -
                                MediaQuery.of(Get.context!).padding.top,
                            left: positionEditProduct!.getLeft(),
                            child: Container(
                              height: 90,
                              width: 110,
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Center(
                                child: ItemStoreView(
                                  icon:
                                      'assets/app_user/svg/home/inventory.svg',
                                  text: 'Chỉnh sửa mặt hàng',
                                  press: () {
                                    Get.to(() => InventoryScreen())!
                                        .then((value) => {
                                              ShowCaseWidget.of(context)!
                                                  .startShowCase([
                                                configUI,
                                                order,
                                                report,
                                                chat,
                                                review,
                                                customer,
                                                editSale,
                                                post,
                                                shipment,
                                                payment,
                                              ]),
                                              homeController.requiredProduct
                                                  .value = false,
                                            });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: positionEditProduct!.getTop() -
                                  MediaQuery.of(Get.context!).padding.top,
                              left: positionEditProduct!.getLeft() + 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset("assets/svg/undo.svg",
                                      height: 50, width: 50, color: Colors.red),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "Bạn nên tạo sản phẩm để có thể hiện thị trên app được tạo nhé !",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        autoPlay: false,
        autoPlayDelay: Duration(seconds: 3),
        autoPlayLockEnable: false,
      ),
    );
  }

  Widget showCase(
      {GlobalKey<State<StatefulWidget>>? key,
      String? title,
      String? description,
      Function? onTargetClick,
      required Widget child}) {
    return Showcase(
      overlayPadding: EdgeInsets.all(5),
      key: key,
      title: title,
      description: description,
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryTextTheme.headline6!.color),
      contentPadding: EdgeInsets.all(10.0),
      showcaseBackgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      shapeBorder: CircleBorder(),
      disposeOnTap: true,
      onTargetClick: onTargetClick == null
          ? null
          : () {
              onTargetClick();
            },
      child: child,
    );
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
