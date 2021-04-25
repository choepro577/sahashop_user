import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
import 'package:sahashop_user/components/app_customer/screen/search_screen/search_screen.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/screen/config_app/config_controller.dart';
import 'controller/category_controller.dart';

class CategoryProductStyle1 extends StatefulWidget {
  @override
  _CategoryProductStyle1State createState() => _CategoryProductStyle1State();
}

class _CategoryProductStyle1State extends State<CategoryProductStyle1> {
  CategoryController categoryController;
  ConfigController configController;
  DataAppCustomerController dataAppCustomerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController ??= CategoryController()..getAllCategory();
    configController = Get.find();
    try {
      dataAppCustomerController = Get.find();
    } catch (e) {
      dataAppCustomerController = Get.put(DataAppCustomerController());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dataAppCustomerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
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
              press: () {
                Get.to(() => LIST_WIDGET_CART_SCREEN[
                    configController.configApp.cartPageType]);
              },
            ),
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
      return SahaSimmer(
        isLoading: isLoading,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) => ProductCard(
              product: list[index],
              isLoading: isLoading,
              press: () {
                dataAppCustomerController.setCurrentProduct(list[index]);
                Get.to(() => LIST_WIDGET_PRODUCT_SCREEN[
                    configController.configApp.productPageType]);
              }),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
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
      ),
    );
  }
}
