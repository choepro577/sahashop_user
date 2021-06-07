import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/choose_voucher/choose_voucher_customer_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/combo_detail_screen/combo_detail_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/confirm_screen/confirm_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/saha_user/switch_button/switch_button.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/components/utils/money.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class CartScreen1 extends StatelessWidget {
  DataAppCustomerController dataAppCustomerController;

  @override
  Widget build(BuildContext context) {
    dataAppCustomerController = Get.find();
    dataAppCustomerController.checkLoginToCartScreen();
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
                "${dataAppCustomerController.listOrder.length} sản phẩm",
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
              dataAppCustomerController.listCombo.length,
              (index) => InkWell(
                onTap: () {
                  Get.to(() => ComboDetailScreen(
                      idProduct: dataAppCustomerController
                          .listCombo[index].productsCombo[0].product.id));
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
                                "Combo ${dataAppCustomerController.listCombo[index].name}",
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
                      dataAppCustomerController.enoughCondition[index] == true
                          ? Row(
                              children: [
                                Text(
                                  "Đã giảm ",
                                  style: TextStyle(fontSize: 13),
                                ),
                                dataAppCustomerController
                                            .listCombo[index].discountType ==
                                        0
                                    ? SahaMoneyText(
                                        price: dataAppCustomerController
                                            .listCombo[index].valueDiscount
                                            .toDouble(),
                                        sizeText: 12,
                                        sizeVND: 10,
                                      )
                                    : Text(
                                        "${dataAppCustomerController.listCombo[index].valueDiscount.toDouble()}%",
                                        style: TextStyle(fontSize: 12),
                                      )
                              ],
                            )
                          : Text(
                              "Mua thêm để giảm giá",
                              style: TextStyle(fontSize: 13),
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
                  itemCount: dataAppCustomerController.listOrder.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            /// remove item product in cart on sever
                            dataAppCustomerController.updateItemCart(
                                dataAppCustomerController
                                    .listOrder[index].product.id,
                                0);
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: dataAppCustomerController
                                                  .listOrder[index]
                                                  .product
                                                  .images
                                                  .length ==
                                              0
                                          ? ""
                                          : dataAppCustomerController
                                              .listOrder[index]
                                              .product
                                              .images[0]
                                              .imageUrl,
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
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
                              SizedBox(width: 20),
                              Container(
                                width: Get.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataAppCustomerController
                                              .listOrder[index].product.name ??
                                          "Loi san pham",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 10),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            "\đ${SahaStringUtils().convertToMoney(dataAppCustomerController.listOrder[index].product.price)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: SahaPrimaryColor),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            dataAppCustomerController
                                                .decreaseItem(index);
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 30,
                                            child: Icon(
                                              Icons.remove,
                                              size: 13,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[200]),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 40,
                                          child: Center(
                                            child: Obx(
                                              () => dataAppCustomerController
                                                          .listQuantityProduct
                                                          .length ==
                                                      0
                                                  ? Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      child:
                                                          CupertinoActivityIndicator(),
                                                    )
                                                  : Text(
                                                      '${dataAppCustomerController.listQuantityProduct[index]}',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200]),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            dataAppCustomerController
                                                .increaseItem(index);
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 30,
                                            child: Icon(
                                              Icons.add,
                                              size: 13,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[200]),
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
                  ),
                ),
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
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Voucher"),
                      Spacer(),
                      Obx(
                        () =>
                            dataAppCustomerController.voucherCodeChoose.value ==
                                    ""
                                ? Text("Chọn hoặc nhập mã")
                                : Text(
                                    "Mã: ${dataAppCustomerController.voucherCodeChoose.value} - đ${SahaStringUtils().convertToMoney(dataAppCustomerController.voucherDiscountAmount.value)}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).primaryColor,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Tổng thanh toán"),
                        Obx(
                          () => Text(
                            "đ${SahaStringUtils().convertToMoney(dataAppCustomerController.totalMoney.value)}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ConfirmScreen());
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
                                      .headline6
                                      .color,
                                  fontWeight: FontWeight.bold),
                            ),
                            Obx(
                              () => Text(
                                "(${dataAppCustomerController.listOrder.length})",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6
                                      .color,
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
