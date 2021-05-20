import 'dart:convert';

ComboRequest comboRequestFromJson(String str) =>
    ComboRequest.fromJson(json.decode(str));

String comboRequestToJson(ComboRequest data) => json.encode(data.toJson());

class ComboRequest {
  ComboRequest({
    this.name,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.valueDiscount,
    this.setLimitAmount,
    this.amount,
    this.comboProducts,
  });

  String name;
  String description;
  String imageUrl;
  String startTime;
  String endTime;
  int discountType;
  int valueDiscount;
  bool setLimitAmount;
  int amount;
  List<ComboProduct> comboProducts;

  factory ComboRequest.fromJson(Map<String, dynamic> json) => ComboRequest(
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        discountType: json["discount_type"],
        valueDiscount: json["value_discount"],
        setLimitAmount: json["set_limit_amount"],
        amount: json["amount"],
        comboProducts: List<ComboProduct>.from(
            json["combo_products"].map((x) => ComboProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "combo_products":
            List<dynamic>.from(comboProducts.map((x) => x.toJson())),
      };
}

class ComboProduct {
  ComboProduct({
    this.productId,
    this.quantity,
  });

  int productId;
  int quantity;

  factory ComboProduct.fromJson(Map<String, dynamic> json) => ComboProduct(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
