import 'dart:convert';

DeviceInit deviceInitFromJson(String str) => DeviceInit.fromJson(json.decode(str));

String deviceInitToJson(DeviceInit data) => json.encode(data.toJson());

class DeviceInit {
  DeviceInit({
    this.success,
    this.data,
    this.msg,
    this.errors,
    this.code,
  });

  bool success;
  DataDevice data;
  String msg;
  dynamic errors;
  int code;

  factory DeviceInit.fromJson(Map<String, dynamic> json) => DeviceInit(
    success: json["success"],
    data: DataDevice.fromJson(json["data"]),
    msg: json["msg"],
    errors: json["errors"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "msg": msg,
    "errors": errors,
    "code": code,
  };
}

class DataDevice {
  DataDevice({
    this.deviceCode,
    this.userId,
    this.agent,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  String deviceCode;
  dynamic userId;
  String agent;
  String id;
  DateTime updatedAt;
  DateTime createdAt;

  factory DataDevice.fromJson(Map<String, dynamic> json) => DataDevice(
    deviceCode: json["device_code"],
    userId: json["user_id"],
    agent: json["agent"],
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "device_code": deviceCode,
    "user_id": userId,
    "agent": agent,
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
