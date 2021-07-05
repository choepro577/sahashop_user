import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_default/chat_customer/chat_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/choose_voucher/choose_voucher_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/member/member_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/qr_screen/qr_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/home/widget/section_title.dart';

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
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: 270,
                    child: BannerWidget(),
                  ),
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
                            dataAppCustomerController.infoCustomer.value == null
                                ? Container()
                                : Container(
                                    child: Text(
                                      "${dataAppCustomerController.infoCustomer.value!.name ?? "Xin chào"}",
                                      style: TextStyle(color: Colors.black87),
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
                                      width: 100,
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
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                                        style: TextStyle(color: Colors.grey),
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
                  )
                ],
              ),
              Wrap(
                  children: dataAppCustomerController.homeData!.allCategory ==
                          null
                      ? []
                      : [
                          SahaBoxButton(
                            icon: "assets/icons/gift_icon.svg",
                            text: "Voucher",
                            numOfitem: dataAppCustomerController
                                .badge.value.voucherTotal,
                            press: () {
                              Get.to(ChooseVoucherCustomerScreen());
                            },
                          ),
                          SahaBoxButton(
                            icon: "assets/icons/chat.svg",
                            text: "Chat với shop",
                            numOfitem: dataAppCustomerController
                                .badge.value.chatsUnread,
                            press: () {
                              Get.to(() => ChatCustomerScreen())!
                                  .then((value) => {
                                        {dataAppCustomerController.getBadge()}
                                      });
                            },
                          ),
                          ...dataAppCustomerController
                              .homeData!.allCategory!.list!
                              .map(
                                (category) => CategoryButton(
                                  category: category,
                                ),
                              )
                              .toList()
                        ]),
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
        ()=> AnimatedContainer(
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
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      minWidth: 35.0,
                      maxWidth: 60.0,
                    ),
                    child: Container(
                      height: 50,
                      width: 50,
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
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    category!.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
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
