import 'dart:convert';
import 'package:sahashop_user/app_user/model/product.dart';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Product? data;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: Product.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "data": data!.toJson(),
  };
}


