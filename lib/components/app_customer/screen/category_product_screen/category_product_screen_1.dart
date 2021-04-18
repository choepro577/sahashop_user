import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/search_screen/search_screen.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card_exam.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/category.dart';
import 'controller/category_controller.dart';
import 'ui_data_category_product_screen.dart';

class CategoryProductStyle1 extends StatefulWidget {
  @override
  _CategoryProductStyle1State createState() => _CategoryProductStyle1State();
}

class _CategoryProductStyle1State extends State<CategoryProductStyle1> {
  var indexSelected = 0;

  final categoryController = Get.put(CategoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryTextTheme.headline1.color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) => Get.to(() => SearchScreen(
                        searchText: value,
                      )),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search product",
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconBtnWithCounter(
              svgSrc: "assets/icons/cart_icon.svg",
              numOfitem: 1,
              press: () {},
            ),
          ],
        ),
      ),
      body: Obx(
        () => Row(
          children: [
            Container(
              width: 70,
              color: Colors.grey[200],
              child: categoryController.isLoadingCategory.value
                  ? SahaLoadingWidget()
                  : ListView.builder(
                      itemCount: categoryController.categories.value.length,
                      itemBuilder: (context, index) {
                        return buildItem(
                            category:
                                categoryController.categories.value[index]);
                      }),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => categoryController.isLoadingCategory.value
                        ? SahaLoadingWidget()
                        : Column(
                            children: [
                              Text(
                                categoryController.categoryCurrent.value.name,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              // StaggeredGridView.countBuilder(
                              //   crossAxisCount: 2,
                              //   itemCount: categoryController.products.length,
                              //   itemBuilder: (BuildContext context,
                              //           int index) =>
                              //       ProductCard(
                              //           product:
                              //               categoryController.products[index],
                              //           press: () {}),
                              //   mainAxisSpacing: 4.0,
                              //   crossAxisSpacing: 4.0,
                              // )
                              GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: (itemWidth / itemHeight),
                                scrollDirection: Axis.vertical,
                                children: [
                                  ...List.generate(
                                      categoryController.products.length,
                                      (index) => ProductCard(
                                          product: categoryController
                                              .products[index],
                                          press: () {}))
                                ],
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem({Category category}) {
    return Container(
      color: categoryController.categoryCurrent.value == category
          ? Colors.white
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          categoryController.setCategoryCurrent(category);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: CachedNetworkImage(
                imageUrl: category.imageUrl ?? "",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              category.name,
              style: TextStyle(
                  fontSize: 14,
                  color: categoryController.categoryCurrent.value == category
                      ? bmColors
                      : Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
