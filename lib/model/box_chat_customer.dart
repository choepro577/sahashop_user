// To parse this JSON data, do
//
//     final boxChatCustomer = boxChatCustomerFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_user/model/message.dart';

import 'info_customer.dart';

BoxChatCustomer boxChatCustomerFromJson(String str) =>
    BoxChatCustomer.fromJson(json.decode(str));

String boxChatCustomerToJson(BoxChatCustomer data) =>
    json.encode(data.toJson());

class BoxChatCustomer {
  BoxChatCustomer({
    this.id,
    this.storeId,
    this.customerId,
    this.messagesId,
    this.userUnread,
    this.customerUnread,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.customer,
  });

  int? id;
  int? storeId;
  int? customerId;
  int? messagesId;
  int? userUnread;
  int? customerUnread;
  DateTime? createdAt;
  DateTime? updatedAt;
  Message? lastMessage;
  InfoCustomer? customer;

  factory BoxChatCustomer.fromJson(Map<String, dynamic> json) =>
      BoxChatCustomer(
        id: json["id"],
        storeId: json["store_id"],
        customerId: json["customer_id"],
        messagesId: json["messages_id"],
        userUnread: json["user_unread"],
        customerUnread: json["customer_unread"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lastMessage: Message.fromJson(json["last_message"]),
        customer: InfoCustomer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "customer_id": customerId,
        "messages_id": messagesId,
        "user_unread": userUnread,
        "customer_unread": customerUnread,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "last_message": lastMessage!.toJson(),
        "customer": customer!.toJson(),
      };
}
