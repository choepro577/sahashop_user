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
import '../category_controller.dart';
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

  CategoryController categoryController2 = new CategoryController();

  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          categoryController2.isLoadingProductMore.value != true) {
        categoryController2.searchProduct(isLoadMore: true);
      }
    });
    categoryController2.init();
    print(categoryController2.categories.hashCode);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (widget.autoSearch) {
        onSearch();
      }
    });
  }

  void onSearch() {
    Get.to(SearchTextFiledScreen(
      onSubmit: (text, categoryId) {
        categoryController2.textEditingControllerSearch.text = text!;
        categoryController2.searchProduct(search: text);
      },
    ));
  }

  double height = AppBar().preferredSize.height;
  var index = 1;

  @override
  Widget build(BuildContext context) {
    ////  ////  ////  ////  ////  ////
    return Scaffold(
      backgroundColor: Colors.grey[300],
      key: _scaffoldKey,
      onEndDrawerChanged: (v) {
        if (v == false && index == 1) {
          categoryController2.searchProduct(
              sortBy: categoryController2.sortByCurrent);
          index++;
        }
      },
      endDrawer: Drawer(
        child: Container(
          width: Get.width / 2,
          height: Get.height,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: height,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Bộ lọc tìm kiếm",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    Text("Sản phẩm"),
                    Container(
                      height: 40,
                      margin: EdgeInsets.all(10),
                      child: Obx(
                        () => FilterChip(
                          label: Text(
                            "Giảm giá",
                            style: TextStyle(fontSize: 13),
                          ),
                          selected:
                              categoryController2.isChooseDiscountSort.value,
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(
                              side: BorderSide(color: Colors.grey[300]!)),
                          onSelected: (bool value) {
                            categoryController2.isChooseDiscountSort.value =
                                !categoryController2.isChooseDiscountSort.value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
                          categoryController2.textEditingControllerSearch,
                      enabled: false,
                    )),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
              index = 1;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 10.0),
              child: Icon(Icons.filter_alt_rounded),
            ),
          ),
        ],
        automaticallyImplyLeading: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Row(
              children: [
                categoryController2.isLoadingCategory.value
                    ? Container(
                        height: 60, child: Center(child: SahaLoadingWidget()))
                    : Expanded(
                        child: Container(
                          height: 60,
                          // width: Get.width,
                          color: Colors.white.withOpacity(0.8),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryController2.categories.length,
                              itemBuilder: (context, index) {
                                return buildItem(
                                    category:
                                        categoryController2.categories[index]);
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
        bool? selected = key == categoryController2.sortByShow.value;

        return InkWell(
          onTap: () {
            if (categoryController2.sortByShow.value == "price" &&
                key == "price") {
              categoryController2.searchProduct(
                  sortBy: key,
                  descending: !categoryController2.descendingShow.value);
              return;
            }
            categoryController2.searchProduct(sortBy: key);
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
                  child: Column(
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
                                    angle: (!categoryController2
                                                .descendingShow.value
                                            ? -90
                                            : 90) *
                                        math.pi /
                                        180,
                                    child: Icon(
                                      Icons.arrow_right_alt_outlined,
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                    ),
                                  ))
                                : Container()
                          ],
                        ),
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: selected
                            ? SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground()
                            : null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [],
                        ),
                      ),
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
      var isLoading = categoryController2.isLoadingProduct.value;
      var list = categoryController2.products;
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (categoryController2.isChooseDiscountSort.value)
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Obx(
                                () => FilterChip(
                                  label: Text(
                                    "Giảm giá",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  selected: categoryController2
                                      .isChooseDiscountSort.value,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(
                                      side:
                                          BorderSide(color: Colors.grey[300]!)),
                                  onSelected: (bool value) {
                                    categoryController2
                                            .isChooseDiscountSort.value =
                                        !categoryController2
                                            .isChooseDiscountSort.value;
                                    if (categoryController2
                                            .isChooseDiscountSort.value ==
                                        false) {
                                      categoryController2.searchProduct(
                                          sortBy: categoryController2
                                              .sortByCurrent);
                                    }
                                  },
                                ),
                              ),
                            ),
                          Expanded(
                            child: StaggeredGridView.countBuilder(
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
                          ),
                        ],
                      ),
                      categoryController2.isLoadingProductMore.value
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
            bottom: BorderSide(
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                width: categoryController2.categoryCurrent.value == category!.id
                    ? 4
                    : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController2.categoryCurrent.value == category.id
              ? Colors.white
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController2.setCategoryCurrent(category);

            categoryController2.searchProduct(idCategory: category.id);
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
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground(),
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
                    color: categoryController2.categoryCurrent.value == category
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
