import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import '../../screen_default/choose_voucher/choose_voucher_customer_screen.dart';
import '../../screen_default/combo_detail_screen/combo_detail_screen.dart';
import '../../screen_default/confirm_screen/confirm_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

import 'widget/item_product.dart';

// ignore: must_be_immutable
class CartScreen1 extends StatefulWidget {
  CartScreen1({Key? key}) : super(key: key);

  @override
  _CartScreen1State createState() => _CartScreen1State();
}

class _CartScreen1State extends State<CartScreen1> {
  CartController cartController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    cartController.checkLoginToCartScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Giỏ hàng",
              style: TextStyle(fontSize: 18),
            ),
            Obx(
              () => Text(
                "${cartController.listOrder.length} sản phẩm",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            ...List.generate(
              cartController.listCombo.length,
              (index) => InkWell(
                onTap: () {
                  Get.to(() => ComboDetailScreen(
                      idProduct: cartController
                          .listCombo[index].productsCombo![0].product!.id));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(2)),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "Combo ${cartController.listCombo[index].name}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      cartController.enoughCondition[index] == true
                          ? Row(
                              children: [
                                Text(
                                  "Đã giảm ",
                                  style: TextStyle(fontSize: 13),
                                ),
                                cartController.listCombo[index].discountType ==
                                        0
                                    ? SahaMoneyText(
                                        price: cartController
                                            .listCombo[index].valueDiscount!
                                            .toDouble(),
                                        sizeText: 12,
                                        sizeVND: 10,
                                      )
                                    : Text(
                                        "${cartController.listCombo[index].valueDiscount!.toDouble()}%",
                                        style: TextStyle(fontSize: 12),
                                      )
                              ],
                            )
                          : Text(
                              "Mua thêm để giảm giá !",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                      Spacer(),
                      Text(
                        "Mua thêm",
                        style: TextStyle(fontSize: 12),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    itemCount: cartController.listOrder.length,
                    itemBuilder: (context, index) => ItemProductInCartWidget(
                          lineItem: cartController.listOrder[index],
                          onDismissed: () {
                            cartController.updateItemCart(
                                cartController.listOrder[index].product!.id,
                                0, []);
                            dataAppCustomerController.getBadge();
                          },
                          onDecreaseItem: () {
                            cartController.decreaseItem(index);
                          },
                          onIncreaseItem: () {
                            cartController.increaseItem(index);
                          },
                          onUpdateProduct: (quantity, distributesSelected) {
                            cartController.updateItemCart(
                                cartController.listOrder[index].product!.id,
                                quantity,
                                distributesSelected);
                          },
                          quantity: cartController.listQuantityProduct[index],
                        )),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
              InkWell(
                onTap: () {
                  Get.to(() => ChooseVoucherCustomerScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          "assets/icons/receipt.svg",
                          color: SahaColorUtils().colorTextWithPrimaryColor(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Voucher"),
                      Spacer(),
                      Obx(
                        () => cartController.voucherCodeChoose.value == ""
                            ? Text("Chọn hoặc nhập mã")
                            : Text(
                                "Mã: ${cartController.voucherCodeChoose.value} - đ${SahaStringUtils().convertToMoney(cartController.voucherDiscountAmount.value)}",
                                style: TextStyle(fontSize: 13),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: SahaColorUtils().colorTextWithPrimaryColor(),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/money.svg",
                        color: SahaColorUtils().colorTextWithPrimaryColor(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Dùng 5000 xu ",
                      style: TextStyle(fontSize: 13),
                    ),
                    Spacer(),
                    CustomSwitch(
                      value: true,
                      onChanged: (v) {},
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: SahaColorUtils().colorTextWithPrimaryColor(),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Container(
                                    height: 450,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Chi tiết đơn hàng",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Tạm tính"),
                                              Text(
                                                  "${SahaStringUtils().convertToMoney(cartController.totalBeforeDiscount.value)} đ"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Giảm giá Sản phẩm"),
                                              Text(
                                                  "- ${SahaStringUtils().convertToMoney(cartController.productDiscountAmount.value)} đ"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Giảm giá Voucher"),
                                              Text(
                                                  "- ${SahaStringUtils().convertToMoney(cartController.voucherDiscountAmount.value)} đ"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Giảm giá Combo"),
                                              Text(
                                                  "- ${SahaStringUtils().convertToMoney(cartController.comboDiscountAmount.value)} đ"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Tổng giảm"),
                                              Text(
                                                  "- ${SahaStringUtils().convertToMoney(cartController.productDiscountAmount.value + cartController.voucherDiscountAmount.value + cartController.comboDiscountAmount.value)} đ"),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Tổng tiền"),
                                              Text(
                                                  "${SahaStringUtils().convertToMoney(cartController.totalMoneyAfterDiscount.value)} đ"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 8,
                                          color: Colors.grey[200],
                                        ),
                                        SahaButtonFullParent(
                                          text: "Đóng",
                                          textColor: Theme.of(context)
                                              .primaryTextTheme
                                              .headline6!
                                              .color,
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        Container(
                                          height: 8,
                                          color: Colors.grey[200],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      height: 45,
                                      width: 45,
                                      top: 10,
                                      right: 10,
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ))
                                ],
                              );
                            });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Tổng cộng: ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Obx(
                                () => Text(
                                  "${SahaStringUtils().convertToMoney(cartController.totalMoneyAfterDiscount.value)} đ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Container(
                              padding: EdgeInsets.all(3),
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                children: [
                                  Text(
                                    "Khuyến mãi: ${SahaStringUtils().convertToMoney(cartController.totalBeforeDiscount.value - cartController.totalMoneyAfterDiscount.value)} đ",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 16,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => cartController.listOrder.length != 0
                          ? InkWell(
                              onTap: () {
                                if (cartController.listOrder.length != 0) {
                                  Get.to(() => ConfirmScreen());
                                }
                              },
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Đặt hàng ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .headline6!
                                              .color,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(
                                      () => Text(
                                        "(${cartController.listOrder.length})",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .headline6!
                                              .color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Đặt hàng ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Obx(
                                    () => Text(
                                      "(${cartController.listOrder.length})",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
