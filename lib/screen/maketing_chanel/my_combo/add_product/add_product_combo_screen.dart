import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:sahashop_user/const/const_image_logo.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_combo/add_product/add_product_combo_controller.dart';

class AddProductComboScreen extends StatefulWidget {
  final Function? callback;
  final List<Product>? listProductInput;

  AddProductComboScreen({this.callback, this.listProductInput});

  @override
  _AddProductComboScreenState createState() => _AddProductComboScreenState();
}

class _AddProductComboScreenState extends State<AddProductComboScreen> {
  bool isSearch = false;

  AddProductComboController addProductComboController =
      AddProductComboController();
  RefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addProductComboController.listProductInput = widget.listProductInput;
    addProductComboController.getAllProduct(isRefresh: true);
    refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => addProductComboController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    addProductComboController.resetListProduct();
                    addProductComboController.textSearch = va;
                    print(addProductComboController.textSearch);
                    addProductComboController.getAllProduct(
                        textSearch: addProductComboController.textSearch!,
                        isRefresh: true);
                  },
                  onClose: () {
                    addProductComboController.textSearch = null;
                    addProductComboController.isSearch.value = false;
                  },
                )
              : Text("Tất cả sản phẩm"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                addProductComboController.isSearch.value = true;
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
              body = Obx(() => addProductComboController.isLoadMore.value
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
          addProductComboController.resetListProduct();
          await addProductComboController.getAllProduct(isRefresh: true);
          refreshController!.refreshCompleted();
        },
        onLoading: () async {
          await addProductComboController.getAllProduct(
              textSearch: addProductComboController.textSearch,
              isRefresh: false);
          refreshController!.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => addProductComboController.isLoadingProduct.value == true
                ? SahaLoadingWidget()
                : Column(
                    children: [
                      ...List.generate(
                        addProductComboController.listProduct.length,
                        (index) => addProductComboController
                                    .listIsSave[index] ==
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
                                                value: addProductComboController
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
                                                      imageUrl: addProductComboController
                                                                  .listProduct[
                                                                      index]
                                                                  .images!
                                                                  .length ==
                                                              0
                                                          ? ""
                                                          : addProductComboController
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
                                                    addProductComboController
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
                                                      "${addProductComboController.listProduct[index].price} đ"),
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
                                          "Sản phẩm đã có Combo giảm giá",
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
                                        value: addProductComboController
                                            .listCheckSelectedProduct[index]
                                            .values
                                            .first,
                                        onChanged: (v) {
                                          setState(() {
                                            addProductComboController
                                                .listCheckSelectedProduct[index]
                                                .update(
                                                    addProductComboController
                                                        .listCheckSelectedProduct[
                                                            index]
                                                        .keys
                                                        .first,
                                                    (value) =>
                                                        !addProductComboController
                                                            .listCheckSelectedProduct[
                                                                index]
                                                            .values
                                                            .first);
                                            print(addProductComboController
                                                .listCheckSelectedProduct);
                                            addProductComboController
                                                .countProductSelected();
                                          });
                                          print(
                                              "check in setState ${addProductComboController.listIsSave}");
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
                                              imageUrl: addProductComboController
                                                          .listProduct[index]
                                                          .images!
                                                          .length ==
                                                      0
                                                  ? ""
                                                  : addProductComboController
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
                                            addProductComboController
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
                                              "${addProductComboController.listProduct[index].price} đ"),
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
                    addProductComboController.quantityProductSelected.value
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
                  addProductComboController.checkTest();
                  //  addProductComboController.checkIsSaveProduct();
                  widget
                      .callback!(addProductComboController.listSelectedProduct);
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
