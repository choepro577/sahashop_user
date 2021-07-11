import 'dart:convert';

import 'package:sahashop_user/app_user/model/badge_user.dart';

BadgeUserResponse badgeUserResponseFromJson(String str) =>
    BadgeUserResponse.fromJson(json.decode(str));

String badgeUserResponseToJson(BadgeUserResponse data) =>
    json.encode(data.toJson());

class BadgeUserResponse {
  BadgeUserResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  BadgeUser? data;
  String? msgCode;
  String? msg;

  factory BadgeUserResponse.fromJson(Map<String, dynamic> json) =>
      BadgeUserResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : BadgeUser.fromJson(json["data"]),
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "data": data == null ? null : data!.toJson(),
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
      };
}
