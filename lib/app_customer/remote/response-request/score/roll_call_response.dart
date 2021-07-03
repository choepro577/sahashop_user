import 'package:sahashop_user/app_user/model/roll_call.dart';

class RollCallsResponse {
  RollCallsResponse({
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

  factory RollCallsResponse.fromJson(Map<String, dynamic> json) =>
      RollCallsResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
      );
}

class Data {
  Data({
    this.scoreInDay,
    this.listRollCall,
  });

  int? scoreInDay;
  List<RollCall>? listRollCall;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        scoreInDay: json["score_in_day"] == null ? null : json["score_in_day"],
        listRollCall: json["list_roll_call"] == null
            ? null
            : List<RollCall>.from(
                json["list_roll_call"].map((x) => RollCall.fromJson(x))),
      );
}
