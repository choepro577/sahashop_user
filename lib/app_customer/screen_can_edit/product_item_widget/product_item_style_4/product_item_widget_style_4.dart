import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

class ProductItemWidgetStyle4 extends StatelessWidget {
  ProductItemWidgetStyle4({
    Key? key,
    required this.product,
    this.width,
  }) : super(key: key);

  Product product;
  double? width;

  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(right: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey.withOpacity(0.3))),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(ProductScreen(
                        product: product,
                      ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                height: 180,
                                width: Get.width,
                                fit: BoxFit.cover,
                                imageUrl: product.images!.length == 0
                                    ? ""
                                    : product.images![0].imageUrl!,
                                placeholder: (context, url) =>
                                    SahaLoadingContainer(),
                                errorWidget: (context, url, error) =>
                                    SahaEmptyImage(),
                              ),
                            ),
                          ),
                        ), //product.images[0].imageUrl
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0),
                                    ),
                                  ),
                                  height: 35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              product.productDiscount == null
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 2, bottom: 2),
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: new LinearGradient(
                                            colors: [
                                              Theme.of(context).primaryColor,
                                              Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.5)
                                            ],
                                            begin: const FractionalOffset(
                                                0.0, 0.0),
                                            end: const FractionalOffset(
                                                1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: Text(
                                        "-${product.productDiscount!.value}%",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "nunito_bold",
                                            color: Colors.white),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0),
                                    child: Text(
                                      product.productDiscount == null
                                          ? "${SahaStringUtils().convertToMoney(product.price)} ₫"
                                          : "${SahaStringUtils().convertToMoney(product.productDiscount!.discountPrice)} ₫",
                                      style: TextStyle(
                                          color: SahaColorUtils()
                                              .colorTextWithPrimaryColor(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      maxLines: 1,
                                    ),
                                  ),
                                  product.productDiscount == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5.0),
                                          child: Text(
                                            "${SahaStringUtils().convertToMoney(product.price)}đ",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color:
                                                    product.productDiscount ==
                                                            null
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    product.productDiscount ==
                                                            null
                                                        ? 14
                                                        : 10),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 16,
            child: Stack(
              children: [
                Row(
                  children: [
                    product.isNew != true
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            height: 15,
                            width: 45,
                            child: Center(
                              child: Text(
                                "Mới",
                                style:
                                    TextStyle(fontSize: 9, color: Colors.white),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 2,
                    ),
                    product.isTopSale == true
                        ? Container(
                            decoration: BoxDecoration(

                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            height: 15,
                            width: 45,
                            child: Center(
                              child: Text(
                                "Bán chạy",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6!
                                        .color),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
