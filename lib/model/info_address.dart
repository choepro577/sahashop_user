import 'dart:convert';

InfoAddress infoAddressFromJson(String str) =>
    InfoAddress.fromJson(json.decode(str));

String infoAddressToJson(InfoAddress data) => json.encode(data.toJson());

class InfoAddress {
  InfoAddress({
    this.id,
    this.storeId,
    this.name,
    this.addressDetail,
    this.country,
    this.city,
    this.district,
    this.wards,
    this.village,
    this.postcode,
    this.email,
    this.phone,
  });

  int id;
  int storeId;
  String name;
  String addressDetail;
  String country;
  String city;
  String district;
  String wards;
  String village;
  String postcode;
  String email;
  String phone;

  factory InfoAddress.fromJson(Map<String, dynamic> json) => InfoAddress(
        id: json["id"],
        storeId: json["store_id"],
        name: json["name"],
        addressDetail: json["address_detail"],
        country: json["country"],
        city: json["city"],
        district: json["district"],
        wards: json["wards"],
        village: json["village"],
        postcode: json["postcode"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "name": name,
        "address_detail": addressDetail,
        "country": country,
        "city": city,
        "district": district,
        "wards": wards,
        "village": village,
        "postcode": postcode,
        "email": email,
        "phone": phone,
      };
}
