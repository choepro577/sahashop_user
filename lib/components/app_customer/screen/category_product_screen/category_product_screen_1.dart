import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_card.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/app_customer/screen/product_screen/controller/product_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/search_screen/search_screen.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/model/category.dart';
import 'controller/category_controller.dart';

class CategoryProductStyle1 extends StatelessWidget {

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();
  CategoryController categoryController =Get.put(CategoryController());


  @override
  void dispose() {
    dataAppCustomerController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    categoryController.getAllCategory();

    ////  ////  ////  ////  ////  ////
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: SahaAppBar(
        titleChild: Row(
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
            // Obx(
            //   () => IconBtnWithCounter(
            //     svgSrc: "assets/icons/cart_icon.svg",
            //     numOfitem: productController.listOrder.value.length ?? 0,
            //     press: () {
            //       Get.to(() => LIST_WIDGET_CART_SCREEN[
            //           configController.configApp.cartPageType]);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      body: Obx(
        () => Row(
          children: [
            categoryController.isLoadingCategory.value
                ? SahaLoadingWidget()
                : Container(
                    width: 70,
                    color: Colors.grey[200],
                    child: ListView.builder(
                        itemCount: categoryController.categories.length,
                        itemBuilder: (context, index) {
                          return buildItem(
                              category: categoryController.categories[index]);
                        }),
                  ),
            Expanded(child: buildList()),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return Obx(() {
      var isLoading = categoryController.isLoadingProduct.value;
      var list = isLoading ? LIST_PRODUCT_EXAMPLE : categoryController.products;
      return Padding(
        padding: const EdgeInsets.all(2.5),
        child: SahaSimmer(
          isLoading: isLoading,
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) => ProductItem(
                product: list[index],
                isLoading: isLoading,
                ),
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
        ),
      );
    });
  }

  Widget buildItem({Category category}) {
    return Obx(
      () => Container(
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
                height: 5,
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: CachedNetworkImage(
                  imageUrl: category.imageUrl ?? "",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                category.name,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 13,
                    color: categoryController.categoryCurrent.value == category
                        ? Theme.of(Get.context).primaryColor
                        : Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
