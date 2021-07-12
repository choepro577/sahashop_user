import 'dart:convert';

import 'package:sahashop_user/app_user/model/post.dart';

PostResponse postResponseFromJson(String str) => PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  PostResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Post? data;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: Post.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "data": data!.toJson(),
  };
}


