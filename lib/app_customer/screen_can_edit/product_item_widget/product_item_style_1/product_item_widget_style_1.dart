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

class ProductItemWidgetStyle1 extends StatelessWidget {
  ProductItemWidgetStyle1({
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
        children: [
          Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[100]!)),
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
                          child: CachedNetworkImage(
                            height: 180,
                            width: Get.width,
                            fit: BoxFit.cover,
                            imageUrl: product.images!.length == 0
                                ? ""
                                : product.images![0].imageUrl!,
                            placeholder: (context, url) => SahaLoadingContainer(),
                            errorWidget: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                        ), //product.images[0].imageUrl
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 35,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  product.productDiscount == null
                                      ? Container()
                                      : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0),
                                    child: Text(
                                      "${SahaStringUtils().convertToMoney(product.price)}đ",
                                      style: TextStyle(
                                          decoration: TextDecoration
                                              .lineThrough,
                                          color:
                                          product.productDiscount ==
                                              null
                                              ? Theme.of(
                                              context)
                                              .primaryColor
                                              : Colors.grey,
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize:
                                          product.productDiscount ==
                                              null
                                              ? 14
                                              : 10),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0),
                                    child: Text(
                                      product.productDiscount == null
                                          ? "${SahaStringUtils().convertToMoney(product.price)}đ"
                                          : "${SahaStringUtils().convertToMoney(product.productDiscount!.discountPrice)}đ",
                                      style: TextStyle(
                                          color: SahaColorUtils()
                                              .colorTextWithPrimaryColor(),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                                child: InkWell(
                                  onTap: () {
                                    cartController.addItemCart(product.id);
                                    dataAppCustomerController.getBadge();
                                  },
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    child: SvgPicture.asset(
                                      "assets/icons/cart_icon.svg",
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  product.productDiscount == null
                      ? Container()
                      : Positioned(
                          top: -4,
                          right: -9.75,
                          child: Stack(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: SvgPicture.asset(
                                  "assets/icons/tag_ribbon.svg",
                                  color: Color(0xfffdd100),
                                ),
                              ),
                              Positioned(
                                top: 23,
                                right: 10.5,
                                child: Text(
                                  "GIẢM",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Positioned(
                                top: 7,
                                right: 11,
                                child: Text(
                                  "${product.productDiscount!.value} %",
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
            ),
          ),
          product.isNew == true
              ? Positioned(
                  top: -5,
                  left: -13,
                  child: Stack(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SvgPicture.asset(
                            "assets/icons/rectangle.svg",
                            color: Color(0xffd70c10),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 5,
                        child: Text(
                          "New",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: "nunito_bold",
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Positioned(
            top: 25,
            left: 0,
            child: Stack(
              children: [
                Container(
                  height: 5,
                  width: 4,
                  child: SvgPicture.asset(
                    "assets/icons/levels.svg",
                    color: Color(0xffd70c10),
                  ),
                ),
                Positioned(
                  top: 18,
                  right: 9,
                  child: Text(
                    "Mall",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .headline6!
                            .color),
                  ),
                ),
              ],
            ),
          ),
          product.isTopSale == true
              ? Positioned(
                  bottom: 80,
                  right: 10,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[600]!.withOpacity(0.5),
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
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
