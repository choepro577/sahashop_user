import 'dart:convert';

import 'package:sahashop_user/model/combo.dart';
import 'package:sahashop_user/model/product.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int code;
  bool success;
  String msgCode;
  String msg;
  Data data;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.totalBeforeDiscount,
    this.productDiscountAmount,
    this.usedDiscount,
    this.comboDiscountAmount,
    this.usedCombos,
    this.voucherDiscountAmount,
    this.usedVoucher,
    this.totalAfterDiscount,
    this.lineItems,
  });

  double totalBeforeDiscount;
  double productDiscountAmount;
  List<UsedDiscount> usedDiscount;
  double comboDiscountAmount;
  List<UsedCombo> usedCombos;
  double voucherDiscountAmount;
  UsedVoucher usedVoucher;
  double totalAfterDiscount;
  List<LineItem> lineItems;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalBeforeDiscount: json["total_before_discount"].toDouble(),
        productDiscountAmount: json["product_discount_amount"].toDouble(),
        usedDiscount: List<UsedDiscount>.from(
            json["used_discount"].map((x) => UsedDiscount.fromJson(x))),
        comboDiscountAmount: json["combo_discount_amount"].toDouble(),
        usedCombos: List<UsedCombo>.from(
            json["used_combos"].map((x) => UsedCombo.fromJson(x))),
        voucherDiscountAmount: json["voucher_discount_amount"].toDouble(),
        usedVoucher: json["used_voucher"] == null
            ? null
            : UsedVoucher.fromJson(json["used_voucher"]),
        totalAfterDiscount: json["total_after_discount"].toDouble(),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_before_discount": totalBeforeDiscount,
        "product_discount_amount": productDiscountAmount,
        "used_discount":
            List<dynamic>.from(usedDiscount.map((x) => x.toJson())),
        "combo_discount_amount": comboDiscountAmount,
        "used_combos": List<dynamic>.from(usedCombos.map((x) => x.toJson())),
        "voucher_discount_amount": voucherDiscountAmount,
        "used_voucher": usedVoucher.toJson(),
        "total_after_discount": totalAfterDiscount,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
      };
}

class LineItem {
  LineItem({
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

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
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

class UsedCombo {
  UsedCombo({
    this.combo,
    this.quantity,
  });

  Combo combo;
  int quantity;

  factory UsedCombo.fromJson(Map<String, dynamic> json) => UsedCombo(
        combo: Combo.fromJson(json["combo"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "combo": combo.toJson(),
        "quantity": quantity,
      };
}

class UsedDiscount {
  UsedDiscount({
    this.name,
    this.beforePrice,
    this.afterDiscount,
  });

  String name;
  double beforePrice;
  double afterDiscount;

  factory UsedDiscount.fromJson(Map<String, dynamic> json) => UsedDiscount(
        name: json["name"],
        beforePrice: json["before_price"].toDouble(),
        afterDiscount: json["after_discount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "before_price": beforePrice,
        "after_discount": afterDiscount,
      };
}

class UsedVoucher {
  UsedVoucher({
    this.id,
    this.storeId,
    this.isEnd,
    this.voucherType,
    this.name,
    this.code,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.valueDiscount,
    this.setLimitValueDiscount,
    this.maxValueDiscount,
    this.setLimitTotal,
    this.valueLimitTotal,
    this.isShowVoucher,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int id;
  int storeId;
  bool isEnd;
  int voucherType;
  String name;
  String code;
  dynamic description;
  dynamic imageUrl;
  DateTime startTime;
  DateTime endTime;
  int discountType;
  double valueDiscount;
  bool setLimitValueDiscount;
  double maxValueDiscount;
  bool setLimitTotal;
  double valueLimitTotal;
  bool isShowVoucher;
  bool setLimitAmount;
  int amount;
  int used;
  DateTime createdAt;
  DateTime updatedAt;
  List<Product> products;

  factory UsedVoucher.fromJson(Map<String, dynamic> json) => UsedVoucher(
        id: json["id"],
        storeId: json["store_id"],
        isEnd: json["is_end"],
        voucherType: json["voucher_type"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        discountType: json["discount_type"],
        valueDiscount: json["value_discount"].toDouble(),
        setLimitValueDiscount: json["set_limit_value_discount"],
        maxValueDiscount: json["max_value_discount"].toDouble(),
        setLimitTotal: json["set_limit_total"],
        valueLimitTotal: json["value_limit_total"].toDouble(),
        isShowVoucher: json["is_show_voucher"],
        setLimitAmount: json["set_limit_amount"],
        amount: json["amount"],
        used: json["used"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "is_end": isEnd,
        "voucher_type": voucherType,
        "name": name,
        "code": code,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_value_discount": setLimitValueDiscount,
        "max_value_discount": maxValueDiscount,
        "set_limit_total": setLimitTotal,
        "value_limit_total": valueLimitTotal,
        "is_show_voucher": isShowVoucher,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "used": used,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
