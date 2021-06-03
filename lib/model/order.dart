import 'package:sahashop_user/model/product.dart';

class Order {
  Order({
    this.id,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  int id;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
      };
}
