import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/home/home_style_3/home_style_3_controller.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_default/chat_customer/chat_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/member/member_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/qr_screen/qr_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/seach_bar_type4.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_customer/screen_default/search_screen/search_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/home/widget/section_title.dart';

class HomeScreenStyle3 extends StatefulWidget {
  const HomeScreenStyle3({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle3State createState() => _HomeScreenStyle3State();
}

class _HomeScreenStyle3State extends State<HomeScreenStyle3> {
  HomeStyle3Controller homeStyle3Controller = HomeStyle3Controller();
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        homeStyle3Controller.changeOpacitySearch(1);
      } else {
        homeStyle3Controller
            .changeOpacitySearch(_scrollController.offset / 100);
      }

      if (_scrollController.offset > 315 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        homeStyle3Controller.checkTouch.value = true;
        homeStyle3Controller.changeHeightAppbar(0);
      } else if (_scrollController.offset < 315 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        homeStyle3Controller.changeHeightAppbar(35.0);
      }
    });
  }

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  final List<Map<String, dynamic>> option = [
    {"icon": "assets/icons/bill_icon.svg", "text": "Ví"},
    {"icon": "assets/icons/gift_icon.svg", "text": "My Voucher"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Quét QR"},
    {"icon": "assets/icons/discover.svg", "text": "Tin Tức"},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var discountProducts = [];

    if (dataAppCustomerController.homeData?.discountProducts?.list != null) {
      dataAppCustomerController.homeData!.discountProducts!.list!
          .forEach((listDiscount) {
        discountProducts.addAll(listDiscount.products!);
      });
    }

    configController.addButton(context);

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
                  AnimatedContainer(
                    duration: const Duration(microseconds: 250),
                    height: 145,
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: Column(
                      children: [
                        Spacer(),
                        SearchBarType4(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              dataAppCustomerController.homeData!.allCategory ==
                                      null
                                  ? []
                                  : dataAppCustomerController
                                      .homeData!.allCategory!.list!
                                      .map(
                                        (category) => CategoryButton(
                                          category: category,
                                        ),
                                      )
                                      .toList()),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 248,
                    child: BannerWidget(),
                  ),
                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       height: 20,
                  //     ),
                  //     SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: List.generate(
                  //           option.length,
                  //           (index) => SahaBoxButton(
                  //             icon: option[index]["icon"],
                  //             text: option[index]["text"],
                  //             numOfitem: option[index]["numOfitem"],
                  //             press: () {},
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  discountProducts.length == 0
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SectionTitle(
                                  title: "Sản phẩm khuyến mãi",
                                  titleEnd: "Xem thêm",
                                  pressTitleEnd: () {
                                    Get.to(CategoryProductScreen());
                                  }),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 251,
                                alignment: Alignment.topLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: discountProducts
                                        .map((product) => ProductItemWidget(
                                              width: 180,
                                              product: product,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                  dataAppCustomerController.homeData?.bestSellProduct?.list ==
                              null ||
                          dataAppCustomerController
                                  .homeData?.bestSellProduct?.list?.length ==
                              0
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SectionTitle(
                                  title: "Sản phẩm bán chạy",
                                  titleEnd: "Tất cả",
                                  pressTitleEnd: () {
                                    Get.to(CategoryProductScreen());
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 251,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: dataAppCustomerController
                                        .homeData!.bestSellProduct!.list!
                                        .map((product) => ProductItemWidget(
                                              width: 180,
                                              product: product,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                  dataAppCustomerController.homeData?.newProduct?.list == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SectionTitle(
                                  title: "Sản phẩm mới",
                                  titleEnd: "Tất cả",
                                  pressTitleEnd: () {
                                    Get.to(CategoryProductScreen());
                                  }),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 251,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: dataAppCustomerController
                                        .homeData!.newProduct!.list!
                                        .map((product) => ProductItemWidget(
                                              width: 180,
                                              product: product,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                  dataAppCustomerController.homeData?.newPost?.list == null ||
                          dataAppCustomerController
                                  .homeData!.newPost!.list!.length ==
                              0
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SectionTitle(
                                  title: "Tin tức - bài viết",
                                  titleEnd: "Tất cả",
                                  pressTitleEnd: () {
                                    dataAppCustomerController.toPostAllScreen();
                                  }),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: dataAppCustomerController
                                      .homeData!.newPost!.list!
                                      .map((post) => PostItemWidget(
                                            width: 300,
                                            post: post,
                                          ))
                                      .toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 110),
                height: 115 + homeStyle3Controller.changeHeight.value,
                width: double.infinity,
                color: Colors.white
                    .withOpacity(homeStyle3Controller.opacity.value),
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          height: homeStyle3Controller.changeHeight.value < 0
                              ? 0
                              : homeStyle3Controller.changeHeight.value,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(QRScreen());
                                },
                                child: SvgPicture.asset(
                                  "assets/svg/qr-code-scan.svg",
                                  height: 25,
                                  width: 25,
                                  color: Colors.grey,
                                ),
                              ),
                              Spacer(),
                              if (homeStyle3Controller.changeHeight.value ==
                                  35.0)
                                InkWell(
                                  onTap: () {
                                    Get.to(() => MemberScreen());
                                  },
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          "xin chào!",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${dataAppCustomerController.infoCustomer.value!.name ?? "Khách"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.to(ChatCustomerScreen());
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/chat.svg",
                                  height: 28,
                                  width: 28,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SearchBarType4(
                        onSearch: () {
                          Get.to(() => SearchScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
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
            category: category,
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
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 0.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: 55,
                        width: 55,
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
                    style: TextStyle(fontWeight: FontWeight.w600),
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
