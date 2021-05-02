import 'dart:convert';

import 'package:sahashop_user/model/info_address.dart';
import 'package:sahashop_user/model/product.dart';

OrdersResponse ordersFromJson(String str) =>
    OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  OrdersResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  DataOrderResponse data;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: DataOrderResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data.toJson(),
      };
}

class DataOrderResponse {
  DataOrderResponse({
    this.id,
    this.storeId,
    this.status,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.note,
    this.infoReceiver,
    this.infoContact,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.lineItems,
  });

  int id;
  int storeId;
  dynamic status;
  dynamic paymentMethod;
  dynamic paymentMethodTitle;
  dynamic note;
  InfoAddress infoReceiver;
  InfoAddress infoContact;
  DateTime createdAt;
  DateTime updatedAt;
  String code;
  List<LineItem> lineItems;

  factory DataOrderResponse.fromJson(Map<String, dynamic> json) =>
      DataOrderResponse(
        id: json["id"],
        storeId: json["store_id"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        note: json["note"],
        infoReceiver: InfoAddress.fromJson(json["info_receiver"]),
        infoContact: InfoAddress.fromJson(json["info_contact"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        code: json["code"],
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "status": status,
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "note": note,
        "info_receiver": infoReceiver.toJson(),
        "info_contact": infoContact.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "code": code,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
      };
}

class LineItem {
  LineItem({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.product,
  });

  int id;
  int orderId;
  int productId;
  int quantity;
  Product product;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "product": product.toJson(),
      };
}
