import 'dart:convert';

import 'package:sahashop_user/model/review.dart';

ReviewResponse reviewResponseFromJson(String str) =>
    ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());

class ReviewResponse {
  ReviewResponse({
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
  Review? data;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Review.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}
