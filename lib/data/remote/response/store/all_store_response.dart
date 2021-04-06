import 'dart:convert';

AllStoreResponse allStoreResponseFromJson(String str) =>
    AllStoreResponse.fromJson(json.decode(str));

String allStoreResponseToJson(AllStoreResponse data) =>
    json.encode(data.toJson());

class AllStoreResponse {
  AllStoreResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  List<Store> data;

  factory AllStoreResponse.fromJson(Map<String, dynamic> json) =>
      AllStoreResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: List<Store>.from(json["data"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Store {
  Store({
    this.id,
    this.name,
    this.storeCode,
    this.address,
    this.userId,
    this.idTypeOfStore,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String storeCode;
  String address;
  int userId;
  int idTypeOfStore;
  DateTime createdAt;
  DateTime updatedAt;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        storeCode: json["store_code"],
        address: json["address"],
        userId: json["user_id"],
        idTypeOfStore: json["id_type_of_store"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "store_code": storeCode,
        "address": address,
        "user_id": userId,
        "id_type_of_store": idTypeOfStore,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
