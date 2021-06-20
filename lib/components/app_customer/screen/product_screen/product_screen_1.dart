import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_item_widget.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen_type/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/chat_customer/chat_customer_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/combo_detail_screen/combo_detail_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/product_screen/controller/product_controller.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/screen/home/widget/section_title.dart';

class ProductScreen1 extends StatelessWidget {
  late ProductController productController;

  @override
  Widget build(BuildContext context) {
    productController = ProductController();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Obx(
              () => !productController.isLoadingProduct.value
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            CarouselSlider(
                                options: CarouselOptions(
                                    height: Get.height * 0.45,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: false,
                                    onPageChanged: (index, reason) {
                                      productController.changeIndexImage(index);
                                    }),
                                items: productController
                                    .productDetailRequest.value.images!
                                    .map((item) => Container(
                                          child: Stack(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl: item.imageUrl!,
                                                fit: BoxFit.cover,
                                                width: 1000.0,
                                                height: Get.height * 0.45,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/saha_loading.png"),
                                              ),
                                              Positioned(
                                                bottom: 0.0,
                                                left: 0.0,
                                                right: 0.0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            200, 0, 0, 0),
                                                        Color.fromARGB(
                                                            0, 0, 0, 0)
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList()),
                            Positioned(
                              width: Get.width,
                              bottom: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: productController
                                    .productDetailRequest.value.images!
                                    .map((url) {
                                  int index = productController
                                      .productDetailRequest.value.images!
                                      .indexOf(url);
                                  return Obx(
                                    () => Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: productController
                                                    .currentImage.value ==
                                                index
                                            ? Color.fromRGBO(0, 0, 0, 0.9)
                                            : Color.fromRGBO(0, 0, 0, 0.4),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  "Yêu thích",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${productController.productDetailRequest.value.name}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  SahaMoneyText(
                                    price: productController
                                        .productDetailRequest.value.price,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  productController.hasInCombo.value
                                      ? Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                productController
                                                            .discountComboType
                                                            .value ==
                                                        1
                                                    ? Text(
                                                        "Combo giảm ${productController.valueComboType.value}%",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    : Row(
                                                        children: [
                                                          Text(
                                                            "Combo giảm ",
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          SahaMoneyText(
                                                            sizeText: 12,
                                                            sizeVND: 10,
                                                            price: productController
                                                                .valueComboType
                                                                .value
                                                                .toDouble(),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ],
                                                      ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/star_around.svg"),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      SvgPicture.asset(
                                          "assets/icons/star_around.svg"),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      SvgPicture.asset(
                                          "assets/icons/star_around.svg"),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      SvgPicture.asset(
                                          "assets/icons/star_around.svg"),
                                      SizedBox(width: 4),
                                      SvgPicture.asset(
                                          "assets/icons/star_around.svg"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("69"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 1,
                                        height: 13,
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Top phổ biến"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        child: false
                                            ? SvgPicture.asset(
                                                "assets/icons/heart.svg",
                                                color: Colors.grey,
                                              )
                                            : SvgPicture.asset(
                                                "assets/icons/heart_fill.svg",
                                                color: Colors.red,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.chat_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 8,
                              color: Colors.grey[200],
                            ),
                            productController.hasInCombo.value
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15.0, right: 10.0, left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            productController.discountComboType
                                                        .value ==
                                                    1
                                                ? Text(
                                                    "Mua đủ Combo giảm ${productController.valueComboType.value}%",
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        "Mua đủ Combo giảm ",
                                                      ),
                                                      SahaMoneyText(
                                                        sizeText: 14,
                                                        sizeVND: 12,
                                                        price: productController
                                                            .valueComboType
                                                            .value
                                                            .toDouble(),
                                                      ),
                                                    ],
                                                  ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          ComboDetailScreen(
                                                            idProduct:
                                                                productController
                                                                    .productDetailRequest
                                                                    .value
                                                                    .id,
                                                          ));
                                                    },
                                                    child: Text("Xem tất cả")),
                                                Container(
                                                    height: 10,
                                                    width: 10,
                                                    child: SvgPicture.asset(
                                                      "assets/icons/right_arrow.svg",
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: Get.width / 3 - 10,
                                          width: Get.width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: productController
                                                        .listProductCombo
                                                        .length >
                                                    3
                                                ? 3
                                                : productController
                                                    .listProductCombo.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: CachedNetworkImage(
                                                  imageUrl: productController
                                                              .listProductCombo[
                                                                  index]
                                                              .product!
                                                              .images!
                                                              .length !=
                                                          0
                                                      ? productController
                                                          .listProductCombo[
                                                              index]
                                                          .product!
                                                          .images![0]
                                                          .imageUrl!
                                                      : "",
                                                  fit: BoxFit.cover,
                                                  width: Get.width / 3 - 10,
                                                  height: Get.width / 3 - 10,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "assets/saha_loading.png"),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            productController.hasInCombo.value
                                ? Container(
                                    height: 8,
                                    color: Colors.grey[200],
                                  )
                                : Container(),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10),
                              child: Text(
                                "Chi tiết sản phẩm",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 10.0, top: 10.0),
                              child: ExpandableNotifier(
                                child: ScrollOnExpand(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expandable(
                                        collapsed: Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: Get.width * 0.35,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Kho",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[700]),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "Thương hiệu",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[700]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: Get.width * 0.4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "175",
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "Gucci Real",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: Text(
                                                "💖 QUYỀN LỢI KHÁCH HÀNG: \n- Khách hàng cũ: Khách mua lần thứ 2 trở đi sẽ nhận được mã giảm giá của shop ➡️ inbox ngay cho shop nhé ⬅️ để nhận mã \- Miễn phí vận chuyển đối với mọi trường hợp đổi trả hàng do lỗi từ phía shop như: sản phẩm lỗi, không đúng hình, đóng gói, vận chuyển nhầm\n",
                                              ),
                                            ),
                                          ],
                                        ),
                                        expanded: IgnorePointer(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: Get.width * 0.35,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Kho",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700]),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            "Thương hiệu",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: Get.width * 0.4,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "175",
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            "Gucci Real",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Divider(
                                                  height: 1,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  child: Text(
                                                    "💖 QUYỀN LỢI KHÁCH HÀNG: \n- Khách hàng cũ: Khách mua lần thứ 2 trở đi sẽ nhận được mã giảm giá của shop ➡️ inbox ngay cho shop nhé ⬅️ để nhận mã \- Miễn phí vận chuyển đối với mọi trường hợp đổi trả hàng do lỗi từ phía shop như: sản phẩm lỗi, không đúng hình, đóng gói, vận chuyển nhầm\n\n- HÀNG CHUẨN 100% - GIÁ RẺ NHẤT THỊ TRƯỜNG \n- Gửi hàng ngay sau khi nhận được đơn\n- Giao hàng toàn quốc, thanh toán khi nhận hàng, Hỗ trợ đổi size thần tốc \n- Giải quyết mọi khiếu nại thắc mắc theo đúng quy định \n",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Builder(
                                            builder: (context) {
                                              var controller =
                                                  ExpandableController.of(
                                                      context,
                                                      required: true)!;
                                              return Container(
                                                width: Get.width * 0.9,
                                                child: TextButton(
                                                  child: Text(
                                                    controller.expanded
                                                        ? "Thu gọn"
                                                        : "Xem thêm",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button!
                                                        .copyWith(
                                                            color: Colors
                                                                .deepPurple),
                                                  ),
                                                  onPressed: () {
                                                    controller.toggle();
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.grey[200],
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ĐÁNH GIÁ SẢN PHẨM",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/star_around.svg"),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          SvgPicture.asset(
                                              "assets/icons/star_around.svg"),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          SvgPicture.asset(
                                              "assets/icons/star_around.svg"),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          SvgPicture.asset(
                                              "assets/icons/star_around.svg"),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          SvgPicture.asset(
                                              "assets/icons/star_around.svg"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "5/5",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "(69 Đánh giá)",
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Xem tất cả",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 10,
                                          width: 10,
                                          child: SvgPicture.asset(
                                            "assets/icons/right_arrow.svg",
                                            color:
                                                Theme.of(context).primaryColor,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Container(
                              color: Colors.grey[200],
                              height: 8,
                            ),
                            Column(
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: SectionTitle(
                                      title: "Sản phẩm tương tự",
                                      titleEnd: "Xem tất cả",
                                      pressTitleEnd: () {
                                        // dataAppCustomerController
                                        //     .toCategoryProductScreen();
                                      }),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 251,
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: productController
                                          .listProductsDiscount
                                          .map((product) => ProductItemWidget(
                                                width: 180,
                                                product: product,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(
                      width: Get.width,
                      height: Get.height,
                      child: Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: SahaAppBar().preferredSize.height,
            left: 20,
            right: 20,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Get.back();
                    }),
                Spacer(),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => CartScreen1());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor),
                        child: Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/cart_icon.svg",
                            color: true
                                ? Theme.of(context)
                                    .primaryTextTheme
                                    .headline6!
                                    .color
                                : Color(0xFFDBDEE4),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => productController
                                  .dataAppCustomerController.listOrder.length !=
                              0
                          ? Positioned(
                              top: -3,
                              right: 0,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF4848),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1.5, color: Colors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    "${productController.dataAppCustomerController.listOrder.length}",
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
              ],
            ),
          ),
          Obx(
            () => AnimatedPositioned(
                top: productController.animateAddCart.value
                    ? 45
                    : Get.height - SahaAppBar().preferredSize.height,
                left: productController.animateAddCart.value
                    ? Get.width - 25
                    : 10,
                height: productController.animateAddCart.value
                    ? 0
                    : Get.width * 0.5,
                width: productController.animateAddCart.value
                    ? 0
                    : Get.width * 0.5,
                child: productController.animateAddCart.value
                    ? CachedNetworkImage(
                        imageUrl: productController
                                    .productDetailRequest.value.images!.length !=
                                0
                            ? productController
                                .productDetailRequest.value.images![0].imageUrl!
                            : "",
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: Get.height * 0.45,
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/saha_loading.png"),
                      )
                    : Container(),
                duration: Duration(milliseconds: 500)),
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: 50,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: Get.width / 2,
                height: 50,
                color: Color(0xff09875e),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ChatCustomerScreen());
                      },
                      child: Container(
                        height: 25,
                        width: Get.width / 4 - 1,
                        child: SvgPicture.asset(
                          "assets/icons/chat.svg",
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[700],
                      width: 1,
                      height: 30,
                    ),
                    Obx(
                      () => !productController.animateAddCart.value
                          ? InkWell(
                              onTap: () {
                                // Get the position of the current widget when clicked, and pass in overlayEntry
                                productController.animatedAddCard();
                                productController.addItemCart();
                              },
                              child: Container(
                                height: 25,
                                width: Get.width / 4 - 1,
                                child: SvgPicture.asset(
                                  "assets/icons/add_to_cart.svg",
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                ),
                              ),
                            )
                          : IgnorePointer(
                              child: Container(
                                height: 25,
                                width: Get.width / 4 - 1,
                                child: SvgPicture.asset(
                                  "assets/icons/add_to_cart.svg",
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        child: CachedNetworkImage(
                                            imageUrl: productController
                                                        .productDetailRequest
                                                        .value
                                                        .images!
                                                        .length ==
                                                    0
                                                ? ""
                                                : productController
                                                    .productDetailRequest
                                                    .value
                                                    .images![0]
                                                    .imageUrl!,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/saha_loading.png")),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SahaMoneyText(
                                          price: productController
                                              .productDetailRequest.value.price,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("Kho: 69"),
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Get.back();
                                    }),
                              ],
                            ),
                            Divider(
                              height: 1,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Số lượng",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          productController.decreaseItem();
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 30,
                                          child: Icon(Icons.remove),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[300]!)),
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        width: 40,
                                        child: Center(
                                          child: Obx(() => Text(
                                                '${productController.quantity.value}',
                                                style: TextStyle(fontSize: 14),
                                              )),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[300]!)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          productController.increaseItem();
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 30,
                                          child: Icon(Icons.add),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[300]!)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SahaButtonFullParent(
                              text: "Mua ngay",
                              textColor: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                productController.addManyItemOrUpdate();
                                //productController.getListOrder();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    width: Get.width / 2,
                    height: 50,
                    color: Colors.deepOrange,
                    child: Center(
                        child: Text(
                      "Mua ngay",
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color),
                    ))),
              ),
            ],
          )),
    );
  }
}
