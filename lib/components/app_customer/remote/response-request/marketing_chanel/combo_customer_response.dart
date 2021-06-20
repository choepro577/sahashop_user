// To parse this JSON data, do
//
//     final customerComboResponse = customerComboResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_user/model/combo.dart';

CustomerComboResponse customerComboResponseFromJson(String str) =>
    CustomerComboResponse.fromJson(json.decode(str));

String customerComboResponseToJson(CustomerComboResponse data) =>
    json.encode(data.toJson());

class CustomerComboResponse {
  CustomerComboResponse({
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
  List<Combo>? data;

  factory CustomerComboResponse.fromJson(Map<String, dynamic> json) =>
      CustomerComboResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: List<Combo>.from(json["data"].map((x) => Combo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
