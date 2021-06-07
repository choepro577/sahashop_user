import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_item_widget.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen_type/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/combo_detail_screen/combo_detail_controller.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';

class ComboDetailScreen extends StatelessWidget {
  int idProduct;

  ComboDetailScreen({this.idProduct}) {
    comboDetailController = ComboDetailController(idProduct: idProduct);
  }

  ComboDetailController comboDetailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(
          () => Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios)),
              SizedBox(
                width: 3,
              ),
              comboDetailController.discountComboType.value == 1
                  ? Text(
                      "Combo giảm ${comboDetailController.valueComboType.value}%",
                      style: TextStyle(fontSize: 18),
                    )
                  : Row(
                      children: [
                        Text(
                          "Combo giảm ",
                          style: TextStyle(fontSize: 18),
                        ),
                        SahaMoneyText(
                          sizeText: 16,
                          sizeVND: 14,
                          price: comboDetailController.valueComboType.value
                              .toDouble(),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        actions: [
          Stack(
            overflow: Overflow.visible,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  onPressed: () {
                    Get.to(() => CartScreen1());
                  }),
              Obx(
                () => comboDetailController
                            .dataAppCustomerController.listOrder.length !=
                        0
                    ? Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF4848),
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.5, color: Colors.white),
                          ),
                          child: Center(
                            child: Text(
                              "${comboDetailController.dataAppCustomerController.listOrder.length}",
                              style: TextStyle(
                                fontSize: 10,
                                height: 1,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              )
            ],
          ),
          IconButton(icon: Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => comboDetailController.hadEnough.value
                    ? Container(
                        height: 50,
                        width: Get.width,
                        child:
                            comboDetailController.discountComboType.value == 1
                                ? Center(
                                    child: Text(
                                      "Bạn đã đủ điều kiện sử dụng Combo giảm ${comboDetailController.valueComboType.value}%",
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        "Bạn đã đủ điều kiện sử dụng Combo giảm ",
                                      ),
                                      SahaMoneyText(
                                        sizeText: 14,
                                        sizeVND: 12,
                                        price: comboDetailController
                                            .valueComboType.value
                                            .toDouble(),
                                      ),
                                    ],
                                  ))
                    : Column(
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
                            (index) => comboDetailController
                                        .listQuantityProductNeedBuy[index] ==
                                    0
                                ? Container()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.7,
                                        child: Text(comboDetailController
                                                .listProductCombo[index]
                                                .product
                                                .name ??
                                            ""),
                                      ),
                                      Spacer(),
                                      Text(
                                          "x ${comboDetailController.listQuantityProductNeedBuy[index] ?? ""}"),
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
