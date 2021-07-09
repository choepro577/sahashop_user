import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/empty/saha_empty_products_widget.dart';
import '../../../components/product_item/product_item_loading_widget.dart';
import '../../../screen_default/data_app_controller.dart';
import 'dart:math' as math;
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'category_controller.dart';
import 'search_text_field_screen/search_text_field_screen.dart';

class CategoryProductStyle2 extends StatefulWidget {
  bool autoSearch;

  CategoryProductStyle2({Key? key, this.autoSearch = false}) : super(key: key);

  @override
  _CategoryProductStyle2State createState() => _CategoryProductStyle2State();
}

class _CategoryProductStyle2State extends State<CategoryProductStyle2> {
  final ConfigController configController = Get.find();

  final DataAppCustomerController dataAppCustomerController = Get.find();

  final CategoryController categoryController = CategoryController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          categoryController.isLoadingProductMore.value != true) {
        categoryController.searchProduct(isLoadMore: true);
      }
    });
    categoryController.init();

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (widget.autoSearch) {
        onSearch();
      }
    });
  }

  void onSearch() {
    Get.to(SearchTextFiledScreen(
      onSubmit: (text, categoryId) {
        categoryController.textEditingControllerSearch.text = text!;
        categoryController.searchProduct(search: text);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    ////  ////  ////  ////  ////  ////
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryTextTheme.headline1!.color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                    onTap: () {
                      onSearch();
                    },
                    child: SahaTextFieldSearch(
                      textEditingController:
                          categoryController.textEditingControllerSearch,
                      enabled: false,
                    )),
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
        automaticallyImplyLeading: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Row(
              children: [
                categoryController.isLoadingCategory.value
                    ? Container(
                        height: 60, child: Center(child: SahaLoadingWidget()))
                    : Expanded(
                        child: Container(
                          height: 60,
                          // width: Get.width,
                          color: Colors.white.withOpacity(0.8),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryController.categories.length,
                              itemBuilder: (context, index) {
                                return buildItem(
                                    category:
                                        categoryController.categories[index]);
                              }),
                        ),
                      ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: buildItemOrderBy(
                                title: "Phổ biến", key: "views")),
                        Divider(
                          height: 1,
                        ),
                        Expanded(
                            child: buildItemOrderBy(
                                title: "Mới nhất", key: "created_at")),
                        Divider(
                          height: 1,
                        ),
                        Expanded(
                            child: buildItemOrderBy(
                                title: "Bán chạy", key: "sales")),
                        Divider(
                          height: 1,
                        ),
                        Expanded(
                            child:
                                buildItemOrderBy(title: "Giá", key: "price")),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: buildList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemOrderBy({String? title, String? key, Function? onTap}) {
    return Obx(
      () {
        bool? selected = key == categoryController.sortByShow.value;

        return InkWell(
          onTap: () {
            if (categoryController.sortByShow.value == "price" &&
                key == "price") {
              categoryController.searchProduct(
                  sortBy: key,
                  descending: !categoryController.descendingShow.value);
              return;
            }
            categoryController.searchProduct(sortBy: key);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selected
                  ? VerticalDivider(
                      color: Colors.grey,
                      width: 1,
                    )
                  : Container(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title ?? "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            key == "price" && selected
                                ? (Transform.rotate(
                                    angle: (!categoryController
                                                .descendingShow.value
                                            ? -90
                                            : 90) *
                                        math.pi /
                                        180,
                                    child: Icon(
                                      Icons.arrow_right_alt_outlined,
                                      color: SahaColorUtils()
                                          .colorTextWithPrimaryColor(),
                                    ),
                                  ))
                                : Container()
                          ],
                        ),
                      ),
                      Container(
                        width: 2,
                        height: double.infinity,
                        color: selected
                            ? SahaColorUtils().colorTextWithPrimaryColor()
                            : null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              selected
                  ? VerticalDivider(
                      color: Colors.grey,
                      width: 1,
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Widget buildList() {
    return Obx(() {
      var isLoading = categoryController.isLoadingProduct.value;
      var list = categoryController.products;
      return Padding(
        padding: const EdgeInsets.all(2.5),
        child: isLoading
            ? StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) =>
                    ProductItemLoadingWidget(),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              )
            : list.length == 0
                ? SahaEmptyProducts()
                : Stack(
                    children: [
                      StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: list.length,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) =>
                            ProductItemWidget(
                          product: list[index],
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(1),
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                      ),
                      categoryController.isLoadingProductMore.value
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: CupertinoActivityIndicator(),
                            )
                          : Container()
                    ],
                  ),
      );
    });
  }

  Widget buildItem({Category? category}) {
    return Obx(
      () => Container(
        width: 80,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                color: SahaColorUtils().colorTextWithPrimaryColor(),
                width:
                    categoryController.categoryCurrent.value.id == category!.id
                        ? 4
                        : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController.categoryCurrent.value.id == category.id
              ? Colors.white
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController.setCategoryCurrent(category);

            categoryController.searchProduct(idCategory: category.id);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: category.id == null
                    ? Center(
                        child: SvgPicture.asset(
                          "assets/svg/all.svg",
                          color: SahaColorUtils().colorTextWithPrimaryColor(),
                          width: 20.0,
                          height: 20.0,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: category.imageUrl ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                category.name!,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 13,
                    color: categoryController.categoryCurrent.value == category
                        ? SahaColorUtils().colorTextWithPrimaryColor()
                        : Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
