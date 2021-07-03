class CheckInResponse {
  CheckInResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;

  factory CheckInResponse.fromJson(Map<String, dynamic> json) =>
      CheckInResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
      );
}
