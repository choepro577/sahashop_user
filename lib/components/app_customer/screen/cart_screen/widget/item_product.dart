import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/components/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_user/const/const_image_logo.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class ItemProductInCartWidget extends StatelessWidget {
  final LineItem lineItem;
  final int? quantity;
  final Function? onDismissed;
  final Function? onDecreaseItem;
  final Function? onIncreaseItem;
  final Function(int quantity, List<DistributesSelected> distributesSelected)?
      onUpdateProduct;

  ItemProductInCartWidget(
      {Key? key,
      required this.lineItem,
      this.onDismissed,
      this.onDecreaseItem,
      this.onIncreaseItem,
      this.quantity,
      this.onUpdateProduct})
      : super(key: key);

  bool canDecrease = true;
  bool canIncrease = true;

  void checkCanCrease() {
    var product = lineItem.product!;

    var max = product.quantityInStock == null || product.quantityInStock! < 0
        ? -1
        : product.quantityInStock;

    if (quantity == 1)
      canDecrease = false;
    else
      canDecrease = true;

    if (quantity! + 1 > max! && max != -1)
      canIncrease = false;
    else
      canIncrease = true;
  }

  @override
  Widget build(BuildContext context) {
    var product = lineItem.product!;

    checkCanCrease();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              onDismissed!();
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/trash.svg"),
                ],
              ),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 88,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: product.images!.length == 0
                                  ? ""
                                  : product.images![0].imageUrl!,
                              errorWidget: (context, url, error) =>
                                  SahaEmptyImage(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    product.productDiscount == null
                        ? Container()
                        : Positioned(
                            top: -10,
                            left: 2,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(
                                    "assets/icons/ribbon.svg",
                                    color: Color(0xfffdd100),
                                  ),
                                ),
                                Positioned(
                                  top: 13,
                                  left: 3,
                                  child: Text(
                                    "-${product.productDiscount!.value} %",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfffd5800)),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ],
                ),
                SizedBox(width: 20),
                Container(
                  width: Get.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? "Không tên",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        maxLines: 2,
                      ),
                      lineItem.distributesSelected == null ||
                              lineItem.distributesSelected!.length == 0
                          ? Container()
                          : InkWell(
                              onTap: () {
                                ModalBottomOptionBuyProduct.showModelOption(
                                    product: lineItem.product!,
                                    distributesSelectedParam:
                                        lineItem.distributesSelected,
                                    quantity: lineItem.quantity,
                                    onSubmit: (int quantity,
                                        Product product,
                                        List<DistributesSelected>
                                            distributesSelected) {
                                      onUpdateProduct!(
                                          quantity, distributesSelected);
                                      Get.back();
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 5),
                                color: Colors.grey[200],
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minWidth: 10,
                                        maxWidth: Get.width * 0.5,
                                      ),
                                      child: Text(
                                        "Phân loại: " +
                                            lineItem.distributesSelected!
                                                .map((e) => e.value)
                                                .toList()
                                                .toString()
                                                .replaceAll("[", "")
                                                .replaceAll("]", ""),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12),
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.grey[600],
                                      size: 12,
                                    )
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: product.productDiscount == null
                                  ? "đ${SahaStringUtils().convertToMoney(product.price)}"
                                  : "đ${SahaStringUtils().convertToMoney(product.productDiscount!.discountPrice)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: SahaPrimaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            product.productDiscount == null
                                ? ""
                                : "đ${SahaStringUtils().convertToMoney(product.price)}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                            onTap: !canDecrease
                                ? null
                                : () {
                                    onDecreaseItem!();
                                  },
                            child: Container(
                              height: 25,
                              width: 30,
                              child: Icon(
                                Icons.remove,
                                size: 13,
                                color: canDecrease ? Colors.black : Colors.grey,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ModalBottomOptionBuyProduct.showModelOption(
                                  product: lineItem.product!,
                                  distributesSelectedParam:
                                      lineItem.distributesSelected,
                                  quantity: lineItem.quantity,
                                  onSubmit: (int quantity,
                                      Product product,
                                      List<DistributesSelected>
                                          distributesSelected) {
                                    onUpdateProduct!(
                                        quantity, distributesSelected);
                                    Get.back();
                                  });
                            },
                            child: Container(
                              height: 25,
                              width: 40,
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: !canIncrease
                                ? null
                                : () {
                                    onIncreaseItem!();
                                  },
                            child: Container(
                              height: 25,
                              width: 30,
                              child: Icon(
                                Icons.add,
                                size: 13,
                                color: canIncrease ? Colors.black : Colors.grey,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
