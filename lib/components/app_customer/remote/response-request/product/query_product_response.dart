import 'dart:convert';

import 'package:sahashop_user/data/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_user/model/product.dart';

QueryProductResponse queryProductResponseFromJson(String str) =>
    QueryProductResponse.fromJson(json.decode(str));

String queryProductResponseToJson(QueryProductResponse data) =>
    json.encode(data.toJson());

class QueryProductResponse {
  QueryProductResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  DataPageProduct? data;

  factory QueryProductResponse.fromJson(Map<String, dynamic> json) =>
      QueryProductResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: DataPageProduct.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}

