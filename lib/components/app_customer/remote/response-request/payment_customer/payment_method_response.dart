import 'dart:convert';

PaymentMethodCustomerResponse paymentMethodResponseFromJson(String str) =>
    PaymentMethodCustomerResponse.fromJson(json.decode(str));

String paymentMethodResponseToJson(PaymentMethodCustomerResponse data) =>
    json.encode(data.toJson());

class PaymentMethodCustomerResponse {
  PaymentMethodCustomerResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int code;
  bool success;
  List<Map> data;
  String msgCode;
  String msg;

  factory PaymentMethodCustomerResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodCustomerResponse(
        code: json["code"],
        success: json["success"],
        data: List<Map>.from(json["data"].map((x) => x)),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x)),
        "msg_code": msgCode,
        "msg": msg,
      };
}
