import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: SahaSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) => print(value),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            uiDataCategoryProduct[indexSelected].name,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Wrap(
                    //   children: [ProductCard(product: product, press: () {})],
                    // )
                  ],
                ),
              ),
            )
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
