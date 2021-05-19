// To parse this JSON data, do
//
//     final deleteDiscountResponse = deleteDiscountResponseFromJson(jsonString);

import 'dart:convert';

DeleteDisCountVoucherResponse deleteDiscountResponseFromJson(String str) =>
    DeleteDisCountVoucherResponse.fromJson(json.decode(str));

String deleteDiscountResponseToJson(DeleteDisCountVoucherResponse data) =>
    json.encode(data.toJson());

class DeleteDisCountVoucherResponse {
  DeleteDisCountVoucherResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  Data data;

  factory DeleteDisCountVoucherResponse.fromJson(Map<String, dynamic> json) =>
      DeleteDisCountVoucherResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.idDeleted,
  });

  int idDeleted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idDeleted: json["idDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "idDeleted": idDeleted,
      };
}
