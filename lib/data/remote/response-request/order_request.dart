import 'dart:convert';

import 'package:sahashop_user/model/info_address.dart';

OrderRequest orderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());

class OrderRequest {
  OrderRequest({
    this.infoReceiver,
    this.infoContact,
    this.lineItems,
  });

  InfoAddress infoReceiver;
  InfoAddress infoContact;
  List<LineItem> lineItems;

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        infoReceiver: InfoAddress.fromJson(json["info_receiver"]),
        infoContact: InfoAddress.fromJson(json["info_contact"]),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info_receiver": infoReceiver.toJson(),
        "info_contact": infoContact.toJson(),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
      };
}

class LineItem {
  LineItem({
    this.productId,
    this.quantity,
  });

  int productId;
  int quantity;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
