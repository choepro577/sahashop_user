import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/utils/money.dart';
import '../../components/empty/saha_empty_image.dart';
import '../../screen_default/address_screen/choose_address_receiver/receiver_address_screen.dart';
import '../../screen_default/choose_voucher/choose_voucher_customer_screen.dart';
import '../../screen_default/confirm_screen/confirm_controller.dart';
import '../../screen_default/confirm_screen/widget/widget_animate_check.dart';
import '../../screen_default/payment_method/payment_method_customer_screen.dart';
import '../../screen_default/shipment_screen/shipment_customer_screen.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/model/info_address_customer.dart';
import 'package:sahashop_user/app_user/model/shipment_method.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

// ignore: must_be_immutable
class ConfirmScreen extends StatelessWidget {
  ConfirmController confirmController = Get.put(ConfirmController());
  DataAppCustomerController dataAppCustomerController = Get.find();
  final dataKey = new GlobalKey();
  final dataKeyPayment = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Xác nhận đơn hàng"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                key: dataKey,
                height: 5,
              ),
              Obx(
                () => Column(
                  children: [
                    confirmController.infoAddressCustomer.value?.id != 0
                        ? Card(
                            child: InkWell(
                              onTap: () {
                                Get.to(() => ReceiverAddressCustomerScreen(
                                          infoAddressCustomers:
                                              confirmController
                                                  .infoAddressCustomer.value,
                                          callback: (InfoAddressCustomer
                                              infoAddressCustomer) {
                                            confirmController
                                                .infoAddressCustomer
                                                .value = infoAddressCustomer;
                                          },
                                        ))!
                                    .then((value) => {
                                          confirmController.chargeShipmentFee(
                                              confirmController
                                                  .infoAddressCustomer
                                                  .value!
                                                  .id),
                                        });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF5F6F9),
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/icons/location.svg",
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Địa chỉ nhận hàng :"),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${confirmController.infoAddressCustomer.value!.name ?? "Chưa có tên"}  | ${confirmController.infoAddressCustomer.value!.phone ?? "Chưa có số điện thoại"}",
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${confirmController.infoAddressCustomer.value!.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${confirmController.infoAddressCustomer.value!.districtName ?? "Chưa có Quận/Huyện"}, ${confirmController.infoAddressCustomer.value!.wardsName ?? "Chưa có Phường/Xã"}, ${confirmController.infoAddressCustomer.value!.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 13),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Obx(
                            () => AnimateCheck(
                              opacity: confirmController.opacityCurrent.value,
                              color:
                                  confirmController.colorAnimateAddress.value,
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => ReceiverAddressCustomerScreen(
                                              infoAddressCustomers:
                                                  confirmController
                                                      .infoAddressCustomer
                                                      .value,
                                              callback: (InfoAddressCustomer
                                                  infoAddressCustomer) {
                                                confirmController
                                                        .infoAddressCustomer
                                                        .value =
                                                    infoAddressCustomer;
                                              },
                                            ))!
                                        .then((value) => {
                                              confirmController
                                                  .chargeShipmentFee(
                                                      confirmController
                                                          .infoAddressCustomer
                                                          .value!
                                                          .id)
                                            });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(6),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF5F6F9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/icons/location.svg",
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Địa chỉ nhận hàng :"),
                                                Container(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    "Chưa chọn địa chỉ nhận hàng (nhấn để chọn)",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 14,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/cart_icon.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Các mặt hàng đã đặt :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                confirmController.cartController.listOrder.length,
                (index) => Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 88,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: confirmController
                                            .cartController
                                            .listOrder[index]
                                            .product!
                                            .images!
                                            .length ==
                                        0
                                    ? ""
                                    : confirmController
                                        .cartController
                                        .listOrder[index]
                                        .product!
                                        .images![0]
                                        .imageUrl!,
                                errorWidget: (context, url, error) =>
                                    SahaEmptyImage(),
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
                              confirmController.cartController.listOrder[index]
                                      .product!.name ??
                                  "Loi san pham",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                            SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text:
                                    "\$${FormatMoney.toVND(confirmController.cartController.listOrder[index].product!.price)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: SahaPrimaryColor),
                                children: [
                                  TextSpan(
                                      text:
                                          " x ${confirmController.cartController.listOrder[index].quantity}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Obx(
                () => confirmController.shipmentMethodCurrent.value.fee == 0
                    ? Container()
                    : InkWell(
                        onTap: () {
                          if (confirmController.infoAddressCustomer.value?.id !=
                              0) {
                            Get.to(() => ShipmentCustomerScreen(
                                  infoAddressCustomer: confirmController
                                      .infoAddressCustomer.value,
                                  callback: (ShipmentMethod shipmentMethod) {
                                    confirmController.shipmentMethodCurrent
                                        .value = shipmentMethod;
                                  },
                                  shipmentMethodCurrent: confirmController
                                      .shipmentMethodCurrent.value,
                                ));
                          } else {
                            Get.to(() => ReceiverAddressCustomerScreen(
                                      infoAddressCustomers: confirmController
                                          .infoAddressCustomer.value,
                                      callback: (InfoAddressCustomer
                                          infoAddressCustomer) {
                                        confirmController.infoAddressCustomer
                                            .value = infoAddressCustomer;
                                      },
                                    ))!
                                .then((value) => {
                                      confirmController.chargeShipmentFee(
                                          confirmController
                                              .infoAddressCustomer.value!.id)
                                    });
                          }
                        },
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Đơn vị vận chuyển ( Nhấn để chọn )',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.green),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        confirmController.shipmentMethodCurrent
                                                    .value.shipType ==
                                                0
                                            ? Text(
                                                'Vận chuyển nhanh',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                'Vận chuyển siêu tốc',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "${confirmController.shipmentMethodCurrent.value.name ?? "Chưa chọn đơn vị vẩn chuyển"}"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Nhận hàng sau 1 - 2 ngày nội thành",
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            '${SahaStringUtils().convertToMoney(confirmController.shipmentMethodCurrent.value.fee)}đ'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 13,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Tin nhắn : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TextField(
                        controller:
                            confirmController.noteCustomerEditingController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Lưu ý cho người bán ...",
                        ),
                        style: TextStyle(fontSize: 14),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng số tiền (${confirmController.cartController.listOrder.length} sản phẩm) : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                          "${FormatMoney.toVND(confirmController.cartController.totalMoneyAfterDiscount.value + confirmController.shipmentMethodCurrent.value.fee!)}"),
                    )
                  ],
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseVoucherCustomerScreen());
                },
                child: Container(
                  key: dataKeyPayment,
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/receipt.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Shop Voucher : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(
                        () => confirmController
                                    .cartController.voucherCodeChoose.value ==
                                ""
                            ? Text("Chọn hoặc nhập mã")
                            : Text(
                                "Mã: ${confirmController.cartController.voucherCodeChoose.value} - đ${SahaStringUtils().convertToMoney(confirmController.cartController.voucherDiscountAmount.value)}",
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
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              confirmController.paymentMethodName.value != ""
                  ? Container(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => PaymentMethodCustomerScreen(
                                idPaymentCurrent:
                                    confirmController.idPaymentCurrent.value,
                                callback: (String paymentMethodName,
                                    int idPaymentCurrent) {
                                  confirmController.paymentMethodName.value =
                                      paymentMethodName;
                                  confirmController.idPaymentCurrent.value =
                                      idPaymentCurrent;
                                },
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Phương thức thanh toán',
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            Spacer(),
                            Obx(
                              () => Container(
                                  width: 120,
                                  child: confirmController
                                              .paymentMethodName.value ==
                                          ""
                                      ? Text(
                                          "Chọn phương thức thanh toán",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )
                                      : Text(
                                          "${confirmController.paymentMethodName.value}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    )
                  : Obx(
                      () => AnimateCheck(
                        opacity: confirmController.opacityPaymentCurrent.value,
                        color: confirmController.colorAnimatePayment.value,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => PaymentMethodCustomerScreen(
                                  idPaymentCurrent:
                                      confirmController.idPaymentCurrent.value,
                                  callback: (String paymentMethodName,
                                      int idPaymentCurrent) {
                                    confirmController.paymentMethodName.value =
                                        paymentMethodName;
                                    confirmController.idPaymentCurrent.value =
                                        idPaymentCurrent;
                                  },
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                    'Phương thức thanh toán',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Obx(
                                () => Container(
                                    width: 120,
                                    child: confirmController
                                                .paymentMethodName.value ==
                                            ""
                                        ? Text(
                                            "Chọn phương thức thanh toán",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )
                                        : Text(
                                            "${confirmController.paymentMethodName.value}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              Obx(
                () => Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tạm tính :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "${SahaStringUtils().convertToMoney(confirmController.cartController.totalBeforeDiscount.value)} đ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      confirmController
                                  .cartController.productDiscountAmount.value ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá sản phẩm :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(confirmController.cartController.productDiscountAmount.value)} đ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      confirmController
                                  .cartController.comboDiscountAmount.value ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá combo :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(confirmController.cartController.comboDiscountAmount.value)} đ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      confirmController
                                  .cartController.voucherDiscountAmount.value ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá voucher :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(confirmController.cartController.voucherDiscountAmount.value)} đ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền hàng :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "${SahaStringUtils().convertToMoney(confirmController.cartController.totalMoneyAfterDiscount.value)} đ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền vận chuyển :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "+ ${SahaStringUtils().convertToMoney(confirmController.shipmentMethodCurrent.value.fee!.toDouble())} đ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng thanh toán :',
                            ),
                            Text(
                                "${SahaStringUtils().convertToMoney(confirmController.cartController.totalMoneyAfterDiscount.value + confirmController.shipmentMethodCurrent.value.fee!.toDouble())} đ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
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
                            "assets/icons/doc.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "Nhấn 'Đặt hàng' đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản SahaShop "),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(0, 0.1), // Shadow position
              ),
            ]),
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
                    Text(
                      "${FormatMoney.toVND(confirmController.cartController.totalMoneyAfterDiscount.value + confirmController.shipmentMethodCurrent.value.fee!.toDouble())}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (confirmController.infoAddressCustomer.value?.id == 0) {
                      Scrollable.ensureVisible(dataKey.currentContext!,
                          duration: Duration(milliseconds: 500));
                      confirmController.colorAnimateAddress.value = Colors.red;
                      confirmController.opacityCurrent.value = 0;
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        confirmController.opacityCurrent.value = 1;
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          confirmController.opacityCurrent.value = 0;
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            confirmController.opacityCurrent.value = 1;
                          });
                        });
                      });
                    } else {
                      if (confirmController.paymentMethodName.value == "") {
                        Scrollable.ensureVisible(dataKeyPayment.currentContext!,
                            duration: Duration(milliseconds: 500));
                        confirmController.colorAnimatePayment.value =
                            Colors.red;
                        confirmController.opacityPaymentCurrent.value = 0;
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          confirmController.opacityPaymentCurrent.value = 1;
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            confirmController.opacityPaymentCurrent.value = 0;
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              confirmController.opacityPaymentCurrent.value = 1;
                            });
                          });
                        });
                      } else {
                        await confirmController.createOrders();
                        dataAppCustomerController.getBadge();
                      }
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Đặt hàng",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
