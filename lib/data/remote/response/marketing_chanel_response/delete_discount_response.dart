// To parse this JSON data, do
//
//     final deleteDiscountResponse = deleteDiscountResponseFromJson(jsonString);

import 'dart:convert';

DeleteDiscountResponse deleteDiscountResponseFromJson(String str) =>
    DeleteDiscountResponse.fromJson(json.decode(str));

String deleteDiscountResponseToJson(DeleteDiscountResponse data) =>
    json.encode(data.toJson());

class DeleteDiscountResponse {
  DeleteDiscountResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  Data data;

  factory DeleteDiscountResponse.fromJson(Map<String, dynamic> json) =>
      DeleteDiscountResponse(
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
