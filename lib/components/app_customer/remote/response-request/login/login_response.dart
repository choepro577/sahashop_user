import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  Data? data;
  String? msgCode;
  String? msg;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data!.toJson(),
        "msg_code": msgCode,
        "msg": msg,
      };
}

class Data {
  Data({
    this.id,
    this.token,
    this.refreshToken,
    this.tokenExpried,
    this.refreshTokenExpried,
    this.customerId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? token;
  String? refreshToken;
  DateTime? tokenExpried;
  DateTime? refreshTokenExpried;
  int? customerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        token: json["token"],
        refreshToken: json["refresh_token"],
        tokenExpried: DateTime.parse(json["token_expried"]),
        refreshTokenExpried: DateTime.parse(json["refresh_token_expried"]),
        customerId: json["customer_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "refresh_token": refreshToken,
        "token_expried": tokenExpried!.toIso8601String(),
        "refresh_token_expried": refreshTokenExpried!.toIso8601String(),
        "customer_id": customerId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
