import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_item_widget.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/screen/combo_detail_screen/combo_detail_controller.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';

class ComboDetailScreen extends StatelessWidget {
  ComboDetailController comboDetailController;

  @override
  Widget build(BuildContext context) {
    comboDetailController = ComboDetailController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Combo giảm 69 %"),
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart_outlined), onPressed: () {}),
          IconButton(icon: Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: 10,
                    ),
                    Text(
                      "Mua thêm các sản phẩm sau để được sử dụng combo:",
                      maxLines: 2,
                    ),
                    ...List.generate(
                      comboDetailController.listProductCombo.length,
                      (index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text(comboDetailController
                                    .listProductCombo[index].product.name ??
                                ""),
                          ),
                          Spacer(),
                          Text(
                              "x ${comboDetailController.listProductCombo[index].quantity ?? ""}"),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: Get.width,
              height: 10,
              color: Colors.grey[200],
            ),
            Obx(
              () => Container(
                height: Get.height,
                width: Get.width,
                child: SahaSimmer(
                  isLoading: false,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: comboDetailController.listProductCombo.length ??
                        LIST_PRODUCT_EXAMPLE.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductItemWidget(
                      product: comboDetailController
                              .listProductCombo[index].product ??
                          LIST_PRODUCT_EXAMPLE[index],
                      isLoading: false,
                    ),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
