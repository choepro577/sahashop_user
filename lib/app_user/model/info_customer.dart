import 'dart:convert';

InfoCustomer infoCustomerFromJson(String str) =>
    InfoCustomer.fromJson(json.decode(str));

String infoCustomerToJson(InfoCustomer data) => json.encode(data.toJson());

class InfoCustomer {
  InfoCustomer({
    this.id,
    this.storeId,
    this.username,
    this.phoneNumber,
    this.phoneVerifiedAt,
    this.email,
    this.emailVerifiedAt,
    this.name,
    this.dateOfBirth,
    this.avatarImage,
    this.score,
    this.sex,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  dynamic username;
  String? phoneNumber;
  dynamic phoneVerifiedAt;
  String? email;
  dynamic emailVerifiedAt;
  dynamic name;
  dynamic dateOfBirth;
  dynamic avatarImage;
  int? score;
  dynamic sex;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory InfoCustomer.fromJson(Map<String, dynamic> json) => InfoCustomer(
        id: json["id"],
        storeId: json["store_id"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        phoneVerifiedAt: json["phone_verified_at"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        name: json["name"],
        dateOfBirth: json["date_of_birth"],
        avatarImage: json["avatar_image"],
        score: json["score"],
        sex: json["sex"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "avatar_image": avatarImage,
        "sex": sex,
      };
}
