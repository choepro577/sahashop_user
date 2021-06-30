import 'dart:convert';

import 'package:sahashop_user/app_user/model/home_data.dart';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  HomeData? data;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: HomeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "data": data!.toJson(),
  };
}

