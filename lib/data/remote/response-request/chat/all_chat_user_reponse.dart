import 'dart:convert';

import 'package:sahashop_user/model/chat_user.dart';

AllChatUserResponse AllChatUserResponseFromJson(String str) =>
    AllChatUserResponse.fromJson(json.decode(str));

String AllChatUserResponseToJson(AllChatUserResponse data) =>
    json.encode(data.toJson());

class AllChatUserResponse {
  AllChatUserResponse({
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

  factory AllChatUserResponse.fromJson(Map<String, dynamic> json) =>
      AllChatUserResponse(
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
    this.currentPage,
    this.data,
    this.perPage,
  });

  int currentPage;
  List<ChatUser> data;
  int perPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data:
            List<ChatUser>.from(json["data"].map((x) => ChatUser.fromJson(x))),
        perPage: json["per_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "per_page": perPage,
      };
}
