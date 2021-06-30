import 'dart:convert';

TypeShopResponse typeShopResponseFromJson(String str) => TypeShopResponse.fromJson(json.decode(str));

String typeShopResponseToJson(TypeShopResponse data) => json.encode(data.toJson());

class TypeShopResponse {
  TypeShopResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<DataTypeShop>? data;

  factory TypeShopResponse.fromJson(Map<String, dynamic> json) => TypeShopResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: List<DataTypeShop>.from(json["data"].map((x) => DataTypeShop.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataTypeShop {
  DataTypeShop({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DataTypeShop.fromJson(Map<String, dynamic> json) => DataTypeShop(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
