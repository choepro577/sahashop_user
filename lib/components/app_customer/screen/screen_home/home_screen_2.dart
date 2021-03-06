import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card_exam.dart';
import 'package:sahashop_user/components/saha_user/special_card/special_offer_card_type1.dart';
import 'package:sahashop_user/model/button.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product2222.dart';
import 'package:sahashop_user/screen/config_app/config_controller.dart';
import 'package:sahashop_user/screen/home/widget/section_title.dart';
import 'package:unicorndial/unicorndial.dart';

import '../data_widget_config.dart';

class HomeScreenStyle2 extends StatefulWidget {
  final List<Category> categories;
  final List<ButtonConfig> buttonConfigs;
  final Function(Product) onPressedProduct;
  final Function(Product) onPressedCategories;
  final Function(Product) onPressedButtonConfig;

  HomeScreenStyle2(
      {Key key,
      this.categories,
      this.buttonConfigs,
      this.onPressedProduct,
      this.onPressedCategories,
      this.onPressedButtonConfig})
      : super(key: key);

  @override
  _HomeScreenStyle2State createState() => _HomeScreenStyle2State();
}

class _HomeScreenStyle2State extends State<HomeScreenStyle2> {
  final List<Map<String, dynamic>> sahaBoxButtons = [
    {"icon": "assets/icons/bill_icon.svg", "text": "Bill"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Game"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
  ];

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

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: configController.contactButton.isEmpty
          ? Container()
          : UnicornDialer(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
              parentButtonBackground: Colors.redAccent,
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
            LIST_WIDGET_BANNER[configController.configApp.carouselType],
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
                    children: List.generate(
                      sahaBoxButtons.length,
                      (index) => SahaBoxButton(
                        icon: sahaBoxButtons[index]["icon"],
                        text: sahaBoxButtons[index]["text"],
                        numOfitem: sahaBoxButtons[index]["numOfitem"],
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
                    children: [
                      SpecialOfferCard(
                        image: "assets/images/Image Banner 2.png",
                        category: "Smartphone",
                        numOfBrands: 18,
                        press: () {},
                      ),
                      SpecialOfferCard(
                        image: "assets/images/Image Banner 3.png",
                        category: "Fashion",
                        numOfBrands: 24,
                        press: () {},
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(title: "Sản phẩm bán chạy", press: () {}),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        demoProducts.length,
                        (index) {
                          if (demoProducts[index].isPopular)
                            return ProductCardExam(
                                product: demoProducts[index]);
                          return SizedBox
                              .shrink(); // here by default width and height is 0
                        },
                      ),
                      SizedBox(width: 20),
                    ],
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
