// To parse this JSON data, do
//
//     final detailProductResponse = detailProductResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_user/model/product.dart';

DetailProductResponse detailProductResponseFromJson(String str) =>
    DetailProductResponse.fromJson(json.decode(str));

String detailProductResponseToJson(DetailProductResponse data) =>
    json.encode(data.toJson());

class DetailProductResponse {
  DetailProductResponse({
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
  Product data;

  factory DetailProductResponse.fromJson(Map<String, dynamic> json) =>
      DetailProductResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Product.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data.toJson(),
      };
}
