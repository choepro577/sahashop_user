import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/empty/empty_widget.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/string_utils.dart';

import 'add_product/add_product_screen.dart';
import 'product_controller.dart';


class ProductScreen extends StatelessWidget {
  ProductController productController = new ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
         titleText: "Tất cả sản phẩm",
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
                    var list = productController.listProduct.toList().toList();
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
                SizedBox(
                  width: Get.width,
                  child: SahaButtonFullParent(
                    onPressed: () {
                      Get.to(AddProductScreen())!.then((value) {
                        if (value == "added") {
                          productController.getAllProduct();
                        }
                      });
                    },
                    text: "Thêm sản phẩm mới",
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}

class ItemProductWidget extends StatelessWidget {
  final Product? product;

  const ItemProductWidget({Key? key, this.product}) : super(key: key);
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
              imageUrl: product!.images != null && product!.images!.length >0 ?product!.images![0].imageUrl!: "",
              placeholder: (context, url) => new SahaLoadingWidget(size: 30,),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            title: Text(product!.name??""),
            trailing: Text(SahaStringUtils().convertToMoney(product!.price),

              style: TextStyle(
                color: SahaPrimaryColor
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: buildItemOption(title: "Hiển thị")),
              Expanded(child: buildItemOption(title: "Sửa")),
              Expanded(child: buildItemOption(title: "Xóa")),
            ],
          )
        ],
      ),
    );
  }

  Widget buildItemOption({required String title, Function? onTap}) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(3))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Column(
          children: [
            Text(title)
          ],
        )],
      ),
    );
  }
}
