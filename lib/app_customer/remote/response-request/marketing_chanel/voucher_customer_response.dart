// To parse this JSON data, do
//
//     final voucherCustomerResponse = voucherCustomerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_user/app_user/model/voucher.dart';

VoucherCustomerResponse voucherCustomerResponseFromJson(String str) =>
    VoucherCustomerResponse.fromJson(json.decode(str));

String voucherCustomerResponseToJson(VoucherCustomerResponse data) =>
    json.encode(data.toJson());

class VoucherCustomerResponse {
  VoucherCustomerResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  List<Voucher>? data;

  factory VoucherCustomerResponse.fromJson(Map<String, dynamic> json) =>
      VoucherCustomerResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: List<Voucher>.from(json["data"].map((x) => Voucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
