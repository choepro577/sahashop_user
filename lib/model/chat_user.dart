import 'dart:convert';

ChatUser ChatUserFromJson(String str) => ChatUser.fromJson(json.decode(str));

String ChatUserToJson(ChatUser data) => json.encode(data.toJson());

class ChatUser {
  ChatUser({
    this.customerId,
    this.content,
    this.name,
    this.avatarImage,
    this.phoneNumber,
    this.id,
    this.createdAt,
  });

  int customerId;
  String content;
  String name;
  String avatarImage;
  String phoneNumber;
  int id;
  DateTime createdAt;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        customerId: json["customer_id"],
        content: json["content"],
        name: json["name"],
        avatarImage: json["avatar_image"],
        phoneNumber: json["phone_number"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "content": content,
        "name": name,
        "avatar_image": avatarImage,
        "phone_number": phoneNumber,
        "id": id,
        "created_at": createdAt.toIso8601String(),
      };
}
