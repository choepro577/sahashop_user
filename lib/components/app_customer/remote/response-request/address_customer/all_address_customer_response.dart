import 'dart:convert';

import 'package:sahashop_user/model/info_address_customer.dart';

AllIAddressCustomerResponse allIAddressCustomerResponseFromJson(String str) =>
    AllIAddressCustomerResponse.fromJson(json.decode(str));

String allIAddressCustomerResponseToJson(AllIAddressCustomerResponse data) =>
    json.encode(data.toJson());

class AllIAddressCustomerResponse {
  AllIAddressCustomerResponse({
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
  List<InfoAddressCustomer>? data;

  factory AllIAddressCustomerResponse.fromJson(Map<String, dynamic> json) =>
      AllIAddressCustomerResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: List<InfoAddressCustomer>.from(
            json["data"].map((x) => InfoAddressCustomer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
