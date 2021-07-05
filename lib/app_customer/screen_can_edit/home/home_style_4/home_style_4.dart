import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/home/home_style_4/home_style_4_controller.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_default/chat_customer/chat_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/qr_screen/qr_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/search_bar_type5.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/home/widget/section_title.dart';

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
                  height: 880,
                  width: 880,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.85),
                          Theme.of(context).primaryColor.withOpacity(0.5),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 0.5],
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
                    height: 250,
                    child: BannerWidget(),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10),
                        child: SectionTitle(
                          title: "Danh mục cửa hàng",
                          titleEnd: "Tất cả",
                          colorTextTitle: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color,
                          colorTextMore: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color,
                          pressTitleEnd: () {
                            Get.to(CategoryProductScreen());
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dataAppCustomerController
                                          .homeData!.allCategory ==
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
                    ],
                  ),
                  discountProducts.length == 0
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SectionTitle(
                                  title: "Sản phẩm khuyến mãi",
                                  titleEnd: "Xem thêm",
                                  colorTextTitle: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                  colorTextMore: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
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
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SectionTitle(
                                  title: "Sản phẩm bán chạy",
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
                            SizedBox(height: 10),
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
                            SizedBox(height: 10),
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
            ],
          ),
        ),
        Container(
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
              Text(
                "Chào bạn Nguyễn Đức Hiếu !",
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.headline6!.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
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
                  color: Theme.of(context).primaryTextTheme.headline6!.color,
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
                  color: Theme.of(context).primaryTextTheme.headline6!.color,
                ),
              ),
            ],
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
            child: SearchBarType5(),
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
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .headline6!
                            .color),
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
