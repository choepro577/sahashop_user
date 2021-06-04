import 'dart:convert';

DeleteAddressCustomerResponse deleteAddressStoreResponseFromJson(String str) =>
    DeleteAddressCustomerResponse.fromJson(json.decode(str));

String deleteAddressStoreResponseToJson(DeleteAddressCustomerResponse data) =>
    json.encode(data.toJson());

class DeleteAddressCustomerResponse {
  DeleteAddressCustomerResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  String msg;
  Data data;

  factory DeleteAddressCustomerResponse.fromJson(Map<String, dynamic> json) =>
      DeleteAddressCustomerResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
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
