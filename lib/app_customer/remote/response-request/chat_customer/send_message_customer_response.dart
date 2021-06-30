import 'dart:convert';

SendMessageCustomerResponse sendMessageResponseFromJson(String str) =>
    SendMessageCustomerResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageCustomerResponse data) =>
    json.encode(data.toJson());

class SendMessageCustomerResponse {
  SendMessageCustomerResponse({
    this.code,
    this.msgCode,
    this.msg,
    this.success,
  });

  int? code;
  String? msgCode;
  String? msg;
  bool? success;

  factory SendMessageCustomerResponse.fromJson(Map<String, dynamic> json) =>
      SendMessageCustomerResponse(
        code: json["code"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg_code": msgCode,
        "msg": msg,
        "success": success,
      };
}
