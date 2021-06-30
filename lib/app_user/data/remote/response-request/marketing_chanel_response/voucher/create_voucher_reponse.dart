import 'dart:convert';

import 'package:sahashop_user/app_user/model/product.dart';

CreateVoucherResponse createVoucherResponseFromJson(String str) =>
    CreateVoucherResponse.fromJson(json.decode(str));

String createVoucherResponseToJson(CreateVoucherResponse data) =>
    json.encode(data.toJson());

class CreateVoucherResponse {
  CreateVoucherResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Data? data;

  factory CreateVoucherResponse.fromJson(Map<String, dynamic> json) =>
      CreateVoucherResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.storeId,
    this.isEnd,
    this.voucherType,
    this.name,
    this.code,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.valueDiscount,
    this.setLimitValueDiscount,
    this.maxValueDiscount,
    this.setLimitTotal,
    this.valueLimitTotal,
    this.isShowVoucher,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int? id;
  int? storeId;
  bool? isEnd;
  int? voucherType;
  String? name;
  String? code;
  String? description;
  String? imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  int? discountType;
  int? valueDiscount;
  bool? setLimitValueDiscount;
  int? maxValueDiscount;
  bool? setLimitTotal;
  int? valueLimitTotal;
  bool? isShowVoucher;
  bool? setLimitAmount;
  dynamic amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        storeId: json["store_id"],
        isEnd: json["is_end"],
        voucherType: json["voucher_type"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        discountType: json["discount_type"],
        valueDiscount: json["value_discount"],
        setLimitValueDiscount: json["set_limit_value_discount"],
        maxValueDiscount: json["max_value_discount"],
        setLimitTotal: json["set_limit_total"],
        valueLimitTotal: json["value_limit_total"],
        isShowVoucher: json["is_show_voucher"],
        setLimitAmount: json["set_limit_amount"],
        amount: json["amount"],
        used: json["used"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "is_end": isEnd,
        "voucher_type": voucherType,
        "name": name,
        "code": code,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime!.toIso8601String(),
        "end_time": endTime!.toIso8601String(),
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_value_discount": setLimitValueDiscount,
        "max_value_discount": maxValueDiscount,
        "set_limit_total": setLimitTotal,
        "value_limit_total": valueLimitTotal,
        "is_show_voucher": isShowVoucher,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "used": used,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "products": List<Product>.from(products!.map((x) => x)),
      };
}
