// To parse this JSON data, do
//
//     final cartCustomerResponse = cartCustomerResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:sahashop_user/model/order.dart';

CartCustomerResponse cartCustomerResponseFromJson(String str) =>
    CartCustomerResponse.fromJson(json.decode(str));

String cartCustomerResponseToJson(CartCustomerResponse data) =>
    json.encode(data.toJson());

class CartCustomerResponse {
  CartCustomerResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  String msg;
  Data data;

  factory CartCustomerResponse.fromJson(Map<String, dynamic> json) =>
      CartCustomerResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.totalBeforeDiscount,
    this.comboDiscountAmount,
    this.productDiscountAmount,
    this.voucherDiscountAmount,
    this.totalAfterDiscount,
    this.lineItems,
  });

  double totalBeforeDiscount;
  double comboDiscountAmount;
  double productDiscountAmount;
  double voucherDiscountAmount;
  double totalAfterDiscount;
  List<Order> lineItems;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalBeforeDiscount:
            double.parse(json["total_before_discount"].toString()),
        comboDiscountAmount:
            double.parse(json["combo_discount_amount"].toString()),
        productDiscountAmount:
            double.parse(json["product_discount_amount"].toString()),
        voucherDiscountAmount:
            double.parse(json["voucher_discount_amount"].toString()),
        totalAfterDiscount:
            double.parse(json["total_after_discount"].toString()),
        lineItems:
            List<Order>.from(json["line_items"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_before_discount": totalBeforeDiscount,
        "combo_discount_amount": comboDiscountAmount,
        "product_discount_amount": productDiscountAmount,
        "voucher_discount_amount": voucherDiscountAmount,
        "total_after_discount": totalAfterDiscount,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
      };
}
