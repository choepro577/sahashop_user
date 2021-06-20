import 'dart:convert';

import 'package:sahashop_user/model/info_address_customer.dart';

CreateUpdateAddressCustomerResponse updateAddressCustomerResponseFromJson(
        String str) =>
    CreateUpdateAddressCustomerResponse.fromJson(json.decode(str));

String createUpdateAddressCustomerResponse(
        CreateUpdateAddressCustomerResponse data) =>
    json.encode(data.toJson());

class CreateUpdateAddressCustomerResponse {
  CreateUpdateAddressCustomerResponse({
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
  InfoAddressCustomer? data;

  factory CreateUpdateAddressCustomerResponse.fromJson(
          Map<String, dynamic> json) =>
      CreateUpdateAddressCustomerResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: InfoAddressCustomer.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data!.toJson(),
      };
}
