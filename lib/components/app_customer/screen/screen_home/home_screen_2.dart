import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_card.dart';
import 'package:sahashop_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/components/saha_user/special_card/special_offer_card_type1.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/model/button.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/screen/home/widget/section_title.dart';
import 'package:unicorndial/unicorndial.dart';

import '../data_app_controller.dart';
import '../data_widget_config.dart';

class HomeScreenStyle2 extends StatefulWidget {
  final List<Category> categories;
  final List<ButtonConfig> buttonConfigs;

  HomeScreenStyle2({
    Key key,
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
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
  ];

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var discountProducts = [];

    if (dataAppCustomerController.homeData?.discountProducts?.list != null) {
      dataAppCustomerController.homeData.discountProducts.list
          .forEach((listDiscount) {
        discountProducts.addAll(listDiscount.products);
      });
    }

    return Scaffold(
      floatingActionButton: configController.contactButton.isEmpty
          ? Container()
          : UnicornDialer(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
              parentButtonBackground: Theme.of(context).primaryColor,
              orientation: UnicornOrientation.VERTICAL,
              parentButton: Icon(Icons.phone),
              childButtons: configController.contactButton ??
                  UnicornButton(
                      hasLabel: true,
                      labelText:
                          configController.configApp.phoneNumberHotline ?? "",
                      currentButton: FloatingActionButton(
                        heroTag: "main",
                        backgroundColor: Colors.blue,
                        mini: true,
                        child: Icon(Icons.add),
                        onPressed: () {},
                      ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            LIST_WIDGET_SEARCH_BAR[configController.configApp.searchType],
            SizedBox(
              height: 10,
            ),
            dataAppCustomerController.getBanner(),
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
                    press: () {


                      Get.to(LIST_WIDGET_CATEGORY_PRODUCT[
                          configController.configApp.categoryPageType]);


                    },
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          dataAppCustomerController.homeData.allCategory.list
                              .map(
                                (category) => CategoryButton(
                                  category: category,
                                ),
                              )
                              .toList()),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(
                    title: "Ưu đãi cho bạn",
                    press: () {},
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children:
                          dataAppCustomerController.homeData.newProduct.list
                              .map(
                                (e) => SpecialOfferCard(
                                  image: "assets/images/Image Banner 2.png",
                                  category: "Smartphone",
                                  numOfBrands: 18,
                                  press: () {},
                                ),
                              )
                              .toList()),
                ),
              ],
            ),
            discountProducts.length == 0 ?Container():      Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                      SectionTitle(title: "Sản phẩm khuyến mãi", press: () {}),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 251,
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: discountProducts
                            .map((product) => ProductItem(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(title: "Sản phẩm bán chạy", press: () {}),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 251,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dataAppCustomerController
                            .homeData.bestSellProduct.list
                            .map((product) => ProductItem(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(title: "Sản phẩm mới", press: () {}),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 251,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            dataAppCustomerController.homeData.newProduct.list
                                .map((product) => ProductItem(
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
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key key, this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: category.imageUrl ?? "",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category?.name,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
