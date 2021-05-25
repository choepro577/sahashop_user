import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_item_widget.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen_type/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/product_screen/controller/product_controller.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/screen/home/widget/section_title.dart';
import 'package:sahashop_user/utils/string_utils.dart';

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
  DataAppCustomerController dataAppCustomerController;
  ProductController productController;
  var discountProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      dataAppCustomerController = Get.find();
    } catch (e) {
      dataAppCustomerController = Get.put(DataAppCustomerController());
    }

    productController = Get.put(ProductController());

    product = dataAppCustomerController.productCurrent ?? LIST_PRODUCT_EXAMPLE;

    if (dataAppCustomerController.homeData?.discountProducts?.list != null) {
      dataAppCustomerController.homeData.discountProducts.list
          .forEach((listDiscount) {
        discountProducts.addAll(listDiscount.products);
      });
    }
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                        items: product.images
                            .map((item) => Container(
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            CachedNetworkImage(
                                              imageUrl: item.imageUrl,
                                              fit: BoxFit.cover,
                                              width: 1000.0,
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
                                                      Color.fromARGB(0, 0, 0, 0)
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ))
                            .toList()),
                    Obx(
                      () => Positioned(
                        width: Get.width,
                        bottom: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: product.images.map((url) {
                            int index = product.images.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: productController.currentImage.value ==
                                        index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
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
                                  .headline6
                                  .color,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${product.name}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SahaMoneyText(
                        price: product.price,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/star_around.svg"),
                              SizedBox(
                                width: 4,
                              ),
                              SvgPicture.asset("assets/icons/star_around.svg"),
                              SizedBox(
                                width: 4,
                              ),
                              SvgPicture.asset("assets/icons/star_around.svg"),
                              SizedBox(
                                width: 4,
                              ),
                              SvgPicture.asset("assets/icons/star_around.svg"),
                              SizedBox(width: 4),
                              SvgPicture.asset("assets/icons/star_around.svg"),
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
                                decoration: BoxDecoration(color: Colors.grey),
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
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
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
                      padding: const EdgeInsets.all(10.0),
                      child: ExpandableNotifier(
                        child: ScrollOnExpand(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Kho",
                                                style: TextStyle(
                                                    color: Colors.grey[700]),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "Thương hiệu",
                                                style: TextStyle(
                                                    color: Colors.grey[700]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: Get.width * 0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Kho",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "Thương hiệu",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Builder(
                                    builder: (context) {
                                      var controller = ExpandableController.of(
                                          context,
                                          required: true);
                                      return Container(
                                        width: Get.width * 0.9,
                                        child: TextButton(
                                          child: Text(
                                            controller.expanded
                                                ? "Thu gọn"
                                                : "Xem thêm",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button
                                                .copyWith(
                                                    color: Colors.deepPurple),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ĐÁNH GIÁ SẢN PHẨM",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
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
                                    style: TextStyle(color: Colors.grey[600]),
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
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  height: 10,
                                  width: 10,
                                  child: SvgPicture.asset(
                                    "assets/icons/right_arrow.svg",
                                    color: Theme.of(context).primaryColor,
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
                          padding: const EdgeInsets.only(left: 10, right: 10),
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
                              children: discountProducts
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
                                            productController.addOrder(
                                                product,
                                                productController
                                                    .quantity.value);
                                            productController.getListOrder();
                                            Get.to(() => CartScreen1());
                                          },
                                          child: Container(
                                            width: Get.width * 0.7,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
          Positioned(
            top: SahaAppBar().preferredSize.height,
            left: 20,
            right: 20,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios,
                        color: Theme.of(context).primaryColor)),
                Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset(
                        "assets/icons/cart_icon.svg",
                        color: true
                            ? Theme.of(context).primaryTextTheme.headline6.color
                            : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                    Container(
                      height: 25,
                      width: Get.width / 4 - 1,
                      child: SvgPicture.asset(
                        "assets/icons/chat.svg",
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    Container(
                      color: Colors.grey[700],
                      width: 1,
                      height: 30,
                    ),
                    Container(
                      height: 25,
                      width: Get.width / 4 - 1,
                      child: SvgPicture.asset(
                        "assets/icons/add_to_cart.svg",
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
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
                        height: Get.height / 2,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: CachedNetworkImage(
                                      imageUrl: product.images[0].imageUrl),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SahaMoneyText(
                                      price: product.price,
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
                            Divider(
                              height: 1,
                            ),
                            InkWell(
                              onTap: () {
                                // Get.back();
                                // Get.to(() => CreateMyVoucher(
                                //       voucherType: 1,
                                //     ));
                              },
                              child: Container(
                                height: 80,
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tạo Voucher sản phẩm",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Có thể áp dụng voucher này cho một số sản phẩm nhất định trong Shop của bạn",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                              color: Colors.grey[200],
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Thoát",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            )
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
                              .headline6
                              .color),
                    ))),
              ),
            ],
          )),
    );
  }
}
