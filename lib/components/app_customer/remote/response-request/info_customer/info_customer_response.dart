// To parse this JSON data, do
//
//     final infoCustomerResponse = infoCustomerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_user/model/info_customer.dart';

InfoCustomerResponse infoCustomerResponseFromJson(String str) =>
    InfoCustomerResponse.fromJson(json.decode(str));

String infoCustomerResponseToJson(InfoCustomerResponse data) =>
    json.encode(data.toJson());

class InfoCustomerResponse {
  InfoCustomerResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int code;
  bool success;
  InfoCustomer data;
  String msgCode;
  String msg;

  factory InfoCustomerResponse.fromJson(Map<String, dynamic> json) =>
      InfoCustomerResponse(
        code: json["code"],
        success: json["success"],
        data: InfoCustomer.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data.toJson(),
        "msg_code": msgCode,
        "msg": msg,
      };
}
