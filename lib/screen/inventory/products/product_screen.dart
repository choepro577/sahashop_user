import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/empty/empty_widget.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/product.dart';

import 'add_product/add_product_screen.dart';
import 'product_controller.dart';


class ProductScreen extends StatelessWidget {
  ProductController productController = new ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tất cả sản phẩm"),
        ),
        body: Obx(
              () => productController.loading.value
              ? SahaLoadingFullScreen()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    var list = productController.listProduct?.toList().reversed.toList();
                    if (list == null || list.length == 0) {
                      return SahaEmptyWidget(
                        tile: "Không có sản phẩm nào",
                      );
                    }
                    return ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ItemProductWidget(
                            product: list[index],
                          );
                        });
                  }),
                ),
                SahaButtonFullParent(
                  onPressed: () {
                    Get.to(AddProductScreen()).then((value) {
                      if (value == "added") {
                        productController.getAllProduct();
                      }
                    });
                  },
                  text: "Thêm sản phẩm mới",
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}

class ItemProductWidget extends StatelessWidget {
  final Product product;

  const ItemProductWidget({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        // leading: CachedNetworkImage(
        //   height: 60,
        //   width: 60,
        //   fit: BoxFit.cover,
        //   imageUrl: product.imageUrl ?? "",
        //   placeholder: (context, url) => new SahaLoadingWidget(size: 30,),
        //   errorWidget: (context, url, error) => new Icon(Icons.error),
        // ),
        title: Text(product.name??""),
      ),
    );
  }
}
