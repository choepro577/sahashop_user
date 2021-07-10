import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'package:sahashop_user/app_user/screen/inventory/products/add_product/add_product_screen.dart';
import 'package:sahashop_user/app_user/screen/inventory/products/widget/product_page/speed_edit.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

import 'product_page_controller.dart';

enum TYPE_PAGE { STOCKING, OUT_OF_STOCK, HIDE }

class ProductPage extends StatefulWidget {
  final TYPE_PAGE? typePage;
  final Function? updateTotal;
  final Function? onReturnController;

  ProductPageController productController = new ProductPageController();

  ProductPage(
      {Key? key, this.typePage, this.updateTotal, this.onReturnController})
      : super(key: key) {
    onReturnController!(productController
      ..typePage = typePage
      ..updateTotal = updateTotal);
  }

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late ProductPageController productController;
  RefreshController _refreshController = RefreshController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    productController = widget.productController;
    // productController.updateTotal = widget.updateTotal;
    // productController.typePage = widget.typePage;

    // widget.onReturnController!(productController);
    productController.getAllProduct();
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {

    widget.onReturnController!(productController);
    return Obx(
      () => productController.loading.value
          ? SahaLoadingFullScreen()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      var list =
                          productController.listProduct.toList().toList();
                      if (list == null || list.length == 0) {
                        return SahaEmptyWidget(
                          tile: "Không có sản phẩm nào",
                        );
                      }
                      return SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: () async {
                          await productController.getAllProduct(
                              isRefresh: true);
                          _refreshController.refreshCompleted();
                        },
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                             return Container();
                            } else if (mode == LoadStatus.loading) {
                              body = CupertinoActivityIndicator();
                            }
                            return Container(
                              height: 0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        onLoading: () async {
                          await productController.getAllProduct(
                              isLoadMore: true);
                          _refreshController.loadComplete();
                        },
                        controller: _refreshController,
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return ItemProductWidget(
                                product: list[index],
                                productController: productController,
                              );
                            }),
                      );
                    }),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: SahaButtonFullParent(
                      onPressed: () {
                        Get.to(AddProductScreen())!.then((value) {
                          if (value == "added") {
                            productController.getAllProduct();
                          }

                          if (value is Map && value['update'] is Product) {
                            productController
                                .updateSuccessProduct(value['update']);
                          }
                        });
                      },
                      text: "Thêm sản phẩm mới",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
    );
  }
}

class ItemProductWidget extends StatelessWidget {
  final Product? product;
  final ProductPageController? productController;

  ItemProductWidget({Key? key, this.product, this.productController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: CachedNetworkImage(
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              imageUrl: product!.images != null && product!.images!.length > 0
                  ? product!.images![0].imageUrl!
                  : "",
              placeholder: (context, url) => new SahaLoadingWidget(
                size: 30,
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            title: Text(product!.name ?? ""),
            trailing: Text(
              SahaStringUtils().convertToMoney(product!.price) + "đ",
              style: TextStyle(color: SahaPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/inventory.svg",
                        height: 15,
                        width: 15,
                        color: Colors.grey,
                      ),
                      Text(
                        " Kho hàng ${(product!.quantityInStock ?? -1) < 0 ? "vô hạn" : product!.quantityInStock}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/sold.svg",
                        height: 15,
                        width: 15,
                        color: Colors.grey,
                      ),
                      Text(
                        " Đã bán ${product!.sold ?? 0}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/heart.svg",
                        height: 15,
                        width: 15,
                        color: Colors.grey,
                      ),
                      Text(
                        " Thích ${product!.likes ?? 0}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/view.svg",
                        height: 15,
                        width: 15,
                        color: Colors.grey,
                      ),
                      Text(
                        " Lượt xem ${product!.view ?? 0}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: buildItemOption(
                      title: product!.status == 0 ? "Ẩn" : "Hiển thị",
                      onTap: () {
                        if (product!.status == 0) {
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn muốn ẩn sản phẩm này?",
                              onOK: () {
                                productController!
                                    .showHideProduct(true, product!);
                              });
                        } else {
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn muốn hiển thị sản phẩm này?",
                              onOK: () {
                                productController!
                                    .showHideProduct(false, product!);
                              });
                        }
                      })),
              Expanded(
                  child: buildItemOption(
                      title: "Sửa",
                      onTap: () {
                        Get.to(AddProductScreen(
                          product: product!,
                        ))!
                            .then((value) {
                          if (value is Map && value['update'] is Product) {
                            productController!
                                .updateSuccessProduct(value['update']);
                          }
                        });
                      })),
              Expanded(
                child: PopupMenuButton(
                  initialValue: 0,
                  onSelected: (index) {
                    if (index == 2) {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn muốn xóa sản phẩm này?",
                          onOK: () {
                            productController!.deleteProduct(product!.id!);
                          });
                    }

                    if (index == 1) {
                      Get.to(SpeedEdit(
                        product: product,
                      ))!
                          .then((value) {
                        if (value is Map && value['update'] is Product) {
                          productController!
                              .updateSuccessProduct(value['update']);
                        }
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding:
                        EdgeInsets.only(right: 8, left: 8, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Thêm'),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 17,
                        )
                      ],
                    )),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Text('Giá và tồn kho'),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text('Xóa'),
                      ),
                    ];
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildItemOption({required String title, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(right: 8, left: 8, bottom: 5, top: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [Text(title)],
            )
          ],
        ),
      ),
    );
  }
}
