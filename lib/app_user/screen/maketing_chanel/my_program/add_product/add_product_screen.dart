import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:sahashop_user/app_user/const/const_image_logo.dart';
import 'package:sahashop_user/app_user/model/product.dart';

import 'add_product_controller.dart';

class AddProductToSaleScreen extends StatefulWidget {
  final Function? callback;
  final List<Product>? listProductInput;

  AddProductToSaleScreen({this.callback, this.listProductInput});

  @override
  _AddProductToSaleScreenState createState() => _AddProductToSaleScreenState();
}

class _AddProductToSaleScreenState extends State<AddProductToSaleScreen> {
  bool isSearch = false;

  AddProductToSaleController addProductToSaleController =
      AddProductToSaleController();
  RefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addProductToSaleController.listProductInput = widget.listProductInput;
    addProductToSaleController.getAllProduct(isRefresh: true);
    refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => addProductToSaleController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    addProductToSaleController.resetListProduct();
                    addProductToSaleController.textSearch = va;
                    print(addProductToSaleController.textSearch);
                    addProductToSaleController.getAllProduct(
                        textSearch: addProductToSaleController.textSearch!,
                        isRefresh: true);
                  },
                  onClose: () {
                    addProductToSaleController.textSearch = null;
                    addProductToSaleController.isSearch.value = false;
                  },
                )
              : Text("Tất cả sản phẩm"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                addProductToSaleController.isSearch.value = true;
              })
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus? mode,
          ) {
            Widget body = Container();
            if (mode == LoadStatus.idle) {
              body = Obx(() => addProductToSaleController.isLoadMore.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            return Container(
              height: 100,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController!,
        onRefresh: () async {
          addProductToSaleController.resetListProduct();
          await addProductToSaleController.getAllProduct(isRefresh: true);
          refreshController!.refreshCompleted();
        },
        onLoading: () async {
          await addProductToSaleController.getAllProduct(
              textSearch: addProductToSaleController.textSearch,
              isRefresh: false);
          refreshController!.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => addProductToSaleController.isLoadingProduct.value == true
                ? SahaLoadingWidget()
                : Column(
                    children: [
                      ...List.generate(
                        addProductToSaleController.listProduct.length,
                        (index) => addProductToSaleController
                                    .listIsSave.value[index] ==
                                true
                            ? IgnorePointer(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0.4,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                                value: addProductToSaleController
                                                    .listCheckSelectedProduct[
                                                        index]
                                                    .values
                                                    .first,
                                                onChanged: (v) {}),
                                            SizedBox(
                                              width: 88,
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF5F6F9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: addProductToSaleController
                                                                  .listProduct[
                                                                      index]
                                                                  .images!
                                                                  .length ==
                                                              0
                                                          ? ""
                                                          : addProductToSaleController
                                                              .listProduct[
                                                                  index]
                                                              .images![0]
                                                              .imageUrl!,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          height: 100,
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                logoSahaImage,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Container(
                                              width: Get.width * 0.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    addProductToSaleController
                                                            .listProduct[index]
                                                            .name ??
                                                        "Loi san pham",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "${addProductToSaleController.listProduct[index].price} đ"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: Get.width * 0.5,
                                        padding: EdgeInsets.all(2),
                                        child: Text(
                                          "Sản phẩm đã có chương trình giảm giá",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffff0004),
                                            fontSize: 12,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 10.0,
                                                color: Colors.black12,
                                              ),
                                              Shadow(
                                                  offset: Offset(0, 0),
                                                  blurRadius: 10.0,
                                                  color: Colors.grey[200]!),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: addProductToSaleController
                                            .listCheckSelectedProduct[index]
                                            .values
                                            .first,
                                        onChanged: (v) {
                                          setState(() {
                                            addProductToSaleController
                                                .listCheckSelectedProduct[index]
                                                .update(
                                                    addProductToSaleController
                                                        .listCheckSelectedProduct[
                                                            index]
                                                        .keys
                                                        .first,
                                                    (value) =>
                                                        !addProductToSaleController
                                                            .listCheckSelectedProduct[
                                                                index]
                                                            .values
                                                            .first);
                                            print(addProductToSaleController
                                                .listCheckSelectedProduct);
                                            addProductToSaleController
                                                .countProductSelected();
                                          });
                                          print(
                                              "check in setState ${addProductToSaleController.listIsSave}");
                                        }),
                                    SizedBox(
                                      width: 88,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF5F6F9),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: addProductToSaleController
                                                          .listProduct[index]
                                                          .images!
                                                          .length ==
                                                      0
                                                  ? ""
                                                  : addProductToSaleController
                                                      .listProduct[index]
                                                      .images![0]
                                                      .imageUrl!,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: 100,
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: logoSahaImage,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      width: Get.width * 0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addProductToSaleController
                                                    .listProduct[index].name ??
                                                "Loi san pham",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${addProductToSaleController.listProduct[index].price} đ"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    addProductToSaleController.quantityProductSelected.value
                        .toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Đã Chọn'),
                ],
              ),
              InkWell(
                onTap: () {
                  addProductToSaleController.checkTest();
                  //  addProductToSaleController.checkIsSaveProduct();
                  widget.callback!(
                      addProductToSaleController.listSelectedProduct);
                  Get.back();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: Text('Thêm'),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
