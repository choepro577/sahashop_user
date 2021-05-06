import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/utils/money.dart';
import 'package:sahashop_user/model/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    @required this.product,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final Product product;
  final bool isLoading;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: width,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      DataAppCustomerController dataAppCustomerController = Get.find();
                      dataAppCustomerController.toProductScreen(product);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isLoading
                            ? Container(
                                height: 180,
                                color: Colors.black,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                    )
                                  ],
                                ),
                              )
                            : Expanded(
                                child: CachedNetworkImage(
                                  height: 180,
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                  imageUrl: product.images.length == 0
                                      ? ""
                                      : product.images[0].imageUrl,
                                  errorWidget: (context, url, error) =>
                                      CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                                  ),
                                ),
                              ), //product.images[0].imageUrl
                        SizedBox(height: 5),
                        isLoading
                            ? Container(
                                width: 40,
                                height: 10,
                              )
                            : Padding(
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
                                              product.name,
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
                                  ],
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isLoading
                                ? Container(
                                    height: 10,
                                    width: 20,
                                    color: Colors.black87,
                                  )
                                : Row(
                                    children: [
                                      product.productDiscount == null
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Text(
                                                "${FormatMoney.toVND(product.price)}",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color:
                                                        product.productDiscount ==
                                                                null
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        product.productDiscount ==
                                                                null
                                                            ? 16
                                                            : 13),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: Text(
                                          product.productDiscount == null
                                              ? "${FormatMoney.toVND(product.price)}"
                                              : "${FormatMoney.toVND(product.productDiscount.discountPrice)}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5.0, bottom: 5.0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: SvgPicture.asset(
                                    "assets/icons/gift_icon.svg",
                                    color: true
                                        ? Theme.of(context).primaryColor
                                        : Color(0xFFDBDEE4),
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
                          right: -6.75,
                          child: Stack(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                child: SvgPicture.asset(
                                  "assets/icons/flag.svg",
                                  color: Color(0xfffdd100),
                                ),
                              ),
                              Positioned(
                                top: 23,
                                right: 8,
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
                                right: 8,
                                child: Text(
                                  "${product.productDiscount.value} %",
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
          Positioned(
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
                    "Mall",
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
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[600].withOpacity(0.5),
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
                              .headline6
                              .color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
