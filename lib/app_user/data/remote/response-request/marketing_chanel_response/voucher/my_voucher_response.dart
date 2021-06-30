import 'dart:convert';

import 'package:sahashop_user/app_user/model/voucher.dart';

MyVoucherResponse myVoucherResponseFromJson(String str) =>
    MyVoucherResponse.fromJson(json.decode(str));

String myVoucherResponseToJson(MyVoucherResponse data) =>
    json.encode(data.toJson());

class MyVoucherResponse {
  MyVoucherResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<Voucher>? data;

  factory MyVoucherResponse.fromJson(Map<String, dynamic> json) =>
      MyVoucherResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: List<Voucher>.from(json["data"].map((x) => Voucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
