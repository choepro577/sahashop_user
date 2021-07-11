import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:sahashop_user/app_user/const/const_image_logo.dart';
import 'package:sahashop_user/app_user/model/product.dart';

import 'product_picker_controller.dart';

class ProductPickerScreen extends StatefulWidget {
  final Function? callback;
  final List<Product>? listProductInput;

  ProductPickerScreen({this.callback, this.listProductInput});

  @override
  _ProductPickerScreenState createState() => _ProductPickerScreenState();
}

class _ProductPickerScreenState extends State<ProductPickerScreen> {
  bool isSearch = false;

  ProductPickerController productPickerController = ProductPickerController();
  RefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productPickerController.listProductInput = widget.listProductInput;
    productPickerController.getAllProduct(isRefresh: true);
    refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => productPickerController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    productPickerController.resetListProduct();
                    productPickerController.textSearch = va;
                    print(productPickerController.textSearch);
                    productPickerController.getAllProduct(
                        textSearch: productPickerController.textSearch!,
                        isRefresh: true);
                  },
                  onClose: () {
                    productPickerController.textSearch = null;
                    productPickerController.isSearch.value = false;
                  },
                )
              : Text("Tất cả sản phẩm"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                productPickerController.isSearch.value = true;
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
              body = Obx(() => productPickerController.isLoadMore.value
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
          productPickerController.resetListProduct();
          await productPickerController.getAllProduct(isRefresh: true);
          refreshController!.refreshCompleted();
        },
        onLoading: () async {
          await productPickerController.getAllProduct(
              textSearch: productPickerController.textSearch, isRefresh: false);
          refreshController!.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => productPickerController.isLoadingProduct.value == true
                ? SahaLoadingWidget()
                : Column(
                    children: [
                      ...List.generate(
                        productPickerController.listProduct.length,
                        (index) => InkWell(
                          onTap: () {
                            onChange(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: productPickerController
                                        .listCheckSelectedProduct[index]
                                        .values
                                        .first,
                                    onChanged: (v) {
                                      onChange(index);
                                    }),
                                SizedBox(
                                  width: 88,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: productPickerController
                                                      .listProduct[index]
                                                      .images!
                                                      .length ==
                                                  0
                                              ? ""
                                              : productPickerController
                                                  .listProduct[index]
                                                  .images![0]
                                                  .imageUrl!,
                                          errorWidget: (context, url, error) =>
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
                                        productPickerController
                                                .listProduct[index].name ??
                                            "Loi san pham",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "${productPickerController.listProduct[index].price} đ"),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                    productPickerController.quantityProductSelected.value
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
                  widget.callback!(productPickerController
                      .listCheckSelectedProduct
                      .where((e) => e.values.first == true)
                      .map((element) => element.keys.first)
                      .toList());
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

  void onChange(index) {
    setState(() {
      productPickerController.listCheckSelectedProduct[index].update(
          productPickerController.listCheckSelectedProduct[index].keys.first,
          (value) => !productPickerController
              .listCheckSelectedProduct[index].values.first);
      print(productPickerController.listCheckSelectedProduct);
      productPickerController.countProductSelected();
    });
  }
}