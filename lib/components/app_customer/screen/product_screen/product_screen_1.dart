import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen_type/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/product_screen/controller/product_controller.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/product.dart';

class ProductScreen1 extends StatefulWidget {
  final double rating;
  final Product product;
  ProductScreen1({
    @required this.rating,
    @required this.product,
  });

  @override
  _ProductScreen1State createState() => _ProductScreen1State();
}

class _ProductScreen1State extends State<ProductScreen1> {
  int selectedImage = 0;
  Product product;
  int selectedColor = 2; // demo
  bool showShadow = false;
  double rating;
  DataAppCustomerController dataAppController;
  ProductController productController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      dataAppController = Get.find();
    } catch (e) {
      dataAppController = Get.put(DataAppCustomerController());
    }

    productController = Get.put(ProductController());

    product = dataAppController.productCurrent ?? LIST_PRODUCT_EXAMPLE;
    rating = widget.rating ?? 4.9;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.quantity.value = 1;
    productController.currentIndexListOrder.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 0.9,
                      child: Hero(
                        tag: product.id.toString(),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: product.images[selectedImage].imageUrl,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SahaAppBar().preferredSize.height,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.zero,
                              onPressed: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back_ios),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${rating}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset("assets/icons/star.svg"),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.width / 1.4,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(product.images.length,
                                (index) => buildSmallProductPreview(index)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              product.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: 64,
                              decoration: BoxDecoration(
                                color: true //product.isFavourite
                                    ? Color(0xFFFFE6E6)
                                    : Color(0xFFF5F6F9),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Heart Icon_2.svg",
                                color: true //product.isFavourite
                                    ? Color(0xFFFF4848)
                                    : Color(0xFFDBDEE4),
                                height: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 64,
                            ),
                            child: Text(
                              product.description,
                              maxLines: 3,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "Xem thêm chi tiết",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: SahaPrimaryColor),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: SahaPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F7F9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  // ...List.generate(
                                  //   product.colors.length,
                                  //   (index) => Container(
                                  //     margin: EdgeInsets.only(right: 2),
                                  //     padding: EdgeInsets.all(8),
                                  //     height: 40,
                                  //     width: 40,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.transparent,
                                  //       border: Border.all(
                                  //           color: index == selectedColor
                                  //               ? SahaPrimaryColor
                                  //               : Colors.transparent),
                                  //       shape: BoxShape.circle,
                                  //     ),
                                  //     child: DecoratedBox(
                                  //       decoration: BoxDecoration(
                                  //         color: product.colors[index],
                                  //         shape: BoxShape.circle,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  //Spacer(),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        if (showShadow)
                                          BoxShadow(
                                            offset: Offset(0, 6),
                                            blurRadius: 10,
                                            color: Color(0xFFB0B0B0)
                                                .withOpacity(0.2),
                                          ),
                                      ],
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      onPressed: () {
                                        productController.decreaseItem();
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Obx(() => Text(
                                        '${productController.quantity.value}',
                                        style: TextStyle(fontSize: 19),
                                      )),
                                  SizedBox(width: 20),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        if (showShadow)
                                          BoxShadow(
                                            offset: Offset(0, 6),
                                            blurRadius: 10,
                                            color: Color(0xFFB0B0B0)
                                                .withOpacity(0.2),
                                          ),
                                      ],
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      onPressed: () {
                                        productController.increaseItem();
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(top: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Get.width * 0.15,
                                    right: Get.width * 0.15,
                                    bottom: 40,
                                    top: 15,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: InkWell(
                                      onTap: () {
                                        productController.addOrder(product,
                                            productController.quantity.value);
                                        productController.getListOrder();
                                        Get.to(() => CartScreen1());
                                      },
                                      child: Container(
                                        width: Get.width * 0.7,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Center(
                                          child: Text(
                                            "Thêm vào dỏ hàng",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
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
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(2),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  SahaPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: product.images[index].imageUrl,
          ),
        ),
      ),
    );
  }
}
