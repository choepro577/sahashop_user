import 'dart:convert';

import 'package:sahashop_user/model/product.dart';

AllProductResponse queryProductResponseFromJson(String str) =>
    AllProductResponse.fromJson(json.decode(str));

String queryProductResponseToJson(AllProductResponse data) =>
    json.encode(data.toJson());

class AllProductResponse {
  AllProductResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  DataPageProduct? data;

  factory AllProductResponse.fromJson(Map<String, dynamic> json) =>
      AllProductResponse(
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

class DataPageProduct {
  DataPageProduct({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  factory DataPageProduct.fromJson(Map<String, dynamic> json) =>
      DataPageProduct(
        currentPage: json["current_page"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
  };
}
