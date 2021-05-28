import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.id,
    this.customerId,
    this.content,
    this.linkImages,
    this.isUser,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  int id;
  int customerId;
  String content;
  String linkImages;
  bool isUser;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic product;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        customerId: json["customer_id"],
        content: json["content"],
        linkImages: json["link_images"],
        isUser: json["is_user"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "content": content,
        "link_images": linkImages,
        "is_user": isUser,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product,
      };
}
