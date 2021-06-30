// To parse this JSON data, do
//
//     final createShopResponse = createShopResponseFromJson(jsonString);

import 'dart:convert';

CreateShopResponse createShopResponseFromJson(String str) => CreateShopResponse.fromJson(json.decode(str));

String createShopResponseToJson(CreateShopResponse data) => json.encode(data.toJson());

class CreateShopResponse {
  CreateShopResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  DataCreateShop? data;

  factory CreateShopResponse.fromJson(Map<String, dynamic> json) => CreateShopResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: DataCreateShop.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "data": data!.toJson(),
  };
}

class DataCreateShop {
  DataCreateShop({
    this.name,
    this.storeCode,
    this.address,
    this.idTypeOfStore,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? name;
  String? storeCode;
  String? address;
  String? idTypeOfStore;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory DataCreateShop.fromJson(Map<String, dynamic> json) => DataCreateShop(
    name: json["name"],
    storeCode: json["store_code"],
    address: json["address"],
    idTypeOfStore: json["id_type_of_store"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "store_code": storeCode,
    "address": address,
    "id_type_of_store": idTypeOfStore,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
  };
}
