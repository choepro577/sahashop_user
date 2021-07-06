import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/product_item/post_item_widget.dart';
import '../../../screen_default/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/button.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/home/widget/section_title.dart';

class HomeScreenStyle2 extends StatefulWidget {
  final List<Category>? categories;
  final List<ButtonConfig>? buttonConfigs;

  HomeScreenStyle2({
    Key? key,
    this.categories,
    this.buttonConfigs,
  }) : super(key: key);

  @override
  _HomeScreenStyle2State createState() => _HomeScreenStyle2State();
}

class _HomeScreenStyle2State extends State<HomeScreenStyle2> {
  final List<Map<String, dynamic>> option = [
    {"icon": "assets/icons/bill_icon.svg", "text": "Ví"},
    {"icon": "assets/icons/gift_icon.svg", "text": "My Voucher"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Quét QR"},
    {"icon": "assets/icons/discover.svg", "text": "Tin Tức"},
  ];

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SearchBarType1(),
            SizedBox(
              height: 10,
            ),
            BannerWidget(),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
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
                  padding: EdgeInsets.all(20),
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
            discountProducts.length == 0
                ? Container()
                : Column(
                    children: [
                      SizedBox(height: 20),
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
            dataAppCustomerController.homeData?.bestSellProduct?.list == null ||
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
                    dataAppCustomerController.homeData!.newPost!.list!.length ==
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
    );
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
