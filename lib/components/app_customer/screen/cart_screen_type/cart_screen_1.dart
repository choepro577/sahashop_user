import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen_type/controller/cart_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/pay_screen_type/pay_screen_type1.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/cart.dart';
import 'package:sahashop_user/model/order.dart';

class CartScreen1 extends StatefulWidget {
  @override
  _CartScreen1State createState() => _CartScreen1State();
}

class _CartScreen1State extends State<CartScreen1> {
  CartController cartController;
  List<Order> listOrder;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      cartController = Get.find();
    } catch (e) {
      cartController = Get.put(CartController());
    }
    cartController.getListOrder();
    // listOrder = cartController.listOrder.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cartController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SahaAppBar(
        title: Column(
          children: [
            Text(
              "Your Cart",
            ),
            Obx(
              () => Text(
                "${cartController.listOrder.value.length} items",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: cartController.listOrder.value.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  cartController.listOrder.value.removeAt(index);
                  cartController.removeProduct(index);
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
                    SizedBox(
                      width: 88,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: cartController.listOrder.value[index]
                                  .product.images[0].imageUrl,
                              errorWidget: (context, url, error) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 100,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartController.listOrder.value[index].product.name ??
                              "Loi san pham",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text:
                                "\$${cartController.listOrder.value[index].product.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: SahaPrimaryColor),
                            children: [
                              TextSpan(
                                  text:
                                      " x${cartController.listOrder.value[index].quantity}",
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("Add voucher code"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: SahaPrimaryColor,
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "${cartController.totalMoney.value}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: SahaPrimaryColor,
                        onPressed: () {
                          Get.to(() => PayScreen1());
                        },
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
