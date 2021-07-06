import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/home/widget/section_title.dart';

class HomeScreenStyle5 extends StatefulWidget {
  const HomeScreenStyle5({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle5State createState() => _HomeScreenStyle5State();
}

class _HomeScreenStyle5State extends State<HomeScreenStyle5> {
  final ScrollController _scrollController = ScrollController();
  double _opacity = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 100) {
          setState(() {
            _opacity = 1;
          });
        } else {
          _opacity = _scrollController.offset / 100;
        }
      });
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
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 248,
                child: BannerWidget(),
              ),
              Column(
                children: [
                  discountProducts.length == 0
                      ? Container()
                      : Column(
                          children: [
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
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        option.length,
                        (index) => SahaBoxButton(
                          icon: option[index]["icon"],
                          text: option[index]["text"],
                          colorText: Colors.black,
                          numOfitem: option[index]["numOfitem"],
                          press: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: SectionTitle(
                      title: "Danh mục cửa hàng",
                      titleEnd: "Tất cả",
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
                        SizedBox(height: 10),
                        Container(
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
        AnimatedContainer(
          duration: const Duration(microseconds: 250),
          height: 100,
          width: double.infinity,
          color: Colors.white.withOpacity(_opacity),
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
          child: SearchBarType1(),
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
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
