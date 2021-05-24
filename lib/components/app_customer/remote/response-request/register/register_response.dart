import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
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

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
    this.phoneNumber,
    this.email,
    this.name,
    this.storeId,
    this.sex,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String phoneNumber;
  String email;
  String name;
  int storeId;
  int sex;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phoneNumber: json["phone_number"],
        email: json["email"],
        name: json["name"],
        storeId: json["store_id"],
        sex: json["sex"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "email": email,
        "name": name,
        "store_id": storeId,
        "sex": sex,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
