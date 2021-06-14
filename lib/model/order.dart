import 'dart:convert';

import 'package:sahashop_user/model/combo.dart';
import 'package:sahashop_user/model/info_address_customer.dart';
import 'package:sahashop_user/model/info_customer.dart';
import 'package:sahashop_user/model/product.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

const WAITING_FOR_PROGRESSING = "WAITING_FOR_PROGRESSING";
const PACKING = "PACKING";
const OUT_OF_STOCK = "OUT_OF_STOCK";
const USER_CANCELLED = "USER_CANCELLED";
const CUSTOMER_CANCELLED = "CUSTOMER_CANCELLED";
const SHIPPING = "SHIPPING";
const DELIVERY_ERROR = "DELIVERY_ERROR";
const COMPLETED = "COMPLETED";
const CUSTOMER_RETURNING = "CUSTOMER_RETURNING";
const CUSTOMER_HAS_RETURNS = "CUSTOMER_HAS_RETURNS";

/// status payment
const UNPAID = "UNPAID";
const PAID = "PAID";
const PARTIALLY_PAID = "PARTIALLY_PAID";
const CANCELLED = "CANCELLED";
const REFUNDS = "REFUNDS";

Map<String, String> ORDER_STATUS_DEFINE = {
  WAITING_FOR_PROGRESSING: "Chờ xử lý",
  PACKING: "Đang chuẩn bị hàng",
  OUT_OF_STOCK: "Hết hàng",
  USER_CANCELLED: "Shop huỷ",
  CUSTOMER_CANCELLED: "Khách đã hủy",
  SHIPPING: "Đang giao hàng",
  DELIVERY_ERROR: "Lỗi giao hàng",
  COMPLETED: "Đã hoàn thành",
  CUSTOMER_RETURNING: "Chờ trả hàng",
  CUSTOMER_HAS_RETURNS: "Đã trả hàng",
};

Map<String, String> ORDER_PAYMENT_DEFINE = {
  WAITING_FOR_PROGRESSING: "Chờ xử lý",
  UNPAID: "Chưa thanh toán",
  PAID: "Đã thanh toán",
  PARTIALLY_PAID: "Đã thanh toán một phần",
  CANCELLED: "Đã hủy",
  REFUNDS: "Đã hoàn tiền",
};

class Order {
  Order({
    this.id,
    this.customerId,
    this.orderCode,
    this.orderStatus,
    this.paymentStatus,
    this.paymentMethodId,
    this.partnerShipperId,
    this.shipperType,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.comboDiscountAmount,
    this.productDiscountAmount,
    this.voucherDiscountAmount,
    this.totalAfterDiscount,
    this.totalFinal,
    this.customerNote,
    this.createdAt,
    this.updatedAt,
    this.paymentStatusCode,
    this.paymentStatusName,
    this.orderStatusCode,
    this.orderStatusName,
    this.paymentMethodName,
    this.lineItems,
    this.shipperName,
    this.customerAddress,
    this.customerUsedDiscount,
    this.customerUsedCombos,
    this.customerUsedVoucher,
    this.lineItemsAtTime,
    this.infoCustomer,
  });

  int id;
  int customerId;
  String orderCode;
  int orderStatus;
  int paymentStatus;
  int paymentMethodId;
  int partnerShipperId;
  int shipperType;
  double totalShippingFee;
  double totalBeforeDiscount;
  double comboDiscountAmount;
  double productDiscountAmount;
  double voucherDiscountAmount;
  double totalAfterDiscount;
  double totalFinal;
  dynamic customerNote;
  DateTime createdAt;
  DateTime updatedAt;
  String paymentStatusCode;
  String paymentStatusName;
  String orderStatusCode;
  String orderStatusName;
  List<LineItem> lineItems;
  String paymentMethodName;
  String shipperName;
  InfoAddressCustomer customerAddress;
  List<CustomerUsedDiscount> customerUsedDiscount;
  List<CustomerUsedCombo> customerUsedCombos;
  dynamic customerUsedVoucher;
  List<LineItemsAtTime> lineItemsAtTime;
  InfoCustomer infoCustomer;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        customerId: json["customer_id"],
        orderCode: json["order_code"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        paymentMethodId: json["payment_method_id"],
        partnerShipperId: json["partner_shipper_id"],
        shipperType: json["shipper_type"],
        totalShippingFee: json["total_shipping_fee"].toDouble(),
        totalBeforeDiscount: json["total_before_discount"].toDouble(),
        comboDiscountAmount: json["combo_discount_amount"].toDouble(),
        productDiscountAmount: json["product_discount_amount"].toDouble(),
        voucherDiscountAmount: json["voucher_discount_amount"].toDouble(),
        totalAfterDiscount: json["total_after_discount"].toDouble(),
        totalFinal: json["total_final"].toDouble(),
        customerNote: json["customer_note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        paymentStatusCode: json["payment_status_code"],
        paymentStatusName: json["payment_status_name"],
        orderStatusCode: json["order_status_code"],
        orderStatusName: json["order_status_name"],
        lineItems: json["line_items"] == null
            ? null
            : List<LineItem>.from(
                json["line_items"].map((x) => LineItem.fromJson(x))),
        paymentMethodName: json["payment_method_name"],
        shipperName: json["shipper_name"],
        customerAddress: json["customer_address"] == null
            ? null
            : InfoAddressCustomer.fromJson(json["customer_address"]),
        customerUsedDiscount: json["customer_used_discount"] == null
            ? null
            : List<CustomerUsedDiscount>.from(json["customer_used_discount"]
                .map((x) => CustomerUsedDiscount.fromJson(x))),
        customerUsedCombos: json["customer_used_combos"] == null
            ? null
            : List<CustomerUsedCombo>.from(json["customer_used_combos"]
                .map((x) => CustomerUsedCombo.fromJson(x))),
        customerUsedVoucher: json["customer_used_voucher"],
        lineItemsAtTime: json["line_items_at_time"] == null
            ? null
            : List<LineItemsAtTime>.from(json["line_items_at_time"]
                .map((x) => LineItemsAtTime.fromJson(x))),
        infoCustomer: InfoCustomer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "order_code": orderCode,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "payment_method_id": paymentMethodId,
        "partner_shipper_id": partnerShipperId,
        "shipper_type": shipperType,
        "total_shipping_fee": totalShippingFee,
        "total_before_discount": totalBeforeDiscount,
        "combo_discount_amount": comboDiscountAmount,
        "product_discount_amount": productDiscountAmount,
        "voucher_discount_amount": voucherDiscountAmount,
        "total_after_discount": totalAfterDiscount,
        "total_final": totalFinal,
        "customer_note": customerNote,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "payment_method_name": paymentMethodName,
        "shipper_name": shipperName,
        "customer_address": customerAddress.toJson(),
        "customer_used_discount":
            List<dynamic>.from(customerUsedDiscount.map((x) => x.toJson())),
        "customer_used_combos":
            List<dynamic>.from(customerUsedCombos.map((x) => x.toJson())),
        "customer_used_voucher": customerUsedVoucher,
        "line_items_at_time":
            List<dynamic>.from(lineItemsAtTime.map((x) => x.toJson())),
      };
}

class CustomerUsedCombo {
  CustomerUsedCombo({
    this.combo,
    this.quantity,
  });

  Combo combo;
  int quantity;

  factory CustomerUsedCombo.fromJson(Map<String, dynamic> json) =>
      CustomerUsedCombo(
        combo: Combo.fromJson(json["combo"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "combo": combo.toJson(),
        "quantity": quantity,
      };
}

class CustomerUsedDiscount {
  CustomerUsedDiscount({
    this.id,
    this.quantity,
    this.name,
    this.beforePrice,
    this.afterDiscount,
  });

  int id;
  int quantity;
  String name;
  double beforePrice;
  double afterDiscount;

  factory CustomerUsedDiscount.fromJson(Map<String, dynamic> json) =>
      CustomerUsedDiscount(
        id: json["id"],
        quantity: json["quantity"],
        name: json["name"],
        beforePrice: json["before_price"].toDouble(),
        afterDiscount: json["after_discount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "name": name,
        "before_price": beforePrice,
        "after_discount": afterDiscount,
      };
}

class LineItem {
  LineItem({
    this.id,
    this.quantity,
    this.product,
  });

  int id;
  int quantity;
  Product product;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product.toJson(),
      };
}

class LineItemsAtTime {
  LineItemsAtTime({
    this.id,
    this.quantity,
    this.name,
    this.imageUrl,
    this.beforePrice,
    this.afterDiscount,
  });

  int id;
  int quantity;
  String name;
  String imageUrl;
  int beforePrice;
  int afterDiscount;

  factory LineItemsAtTime.fromJson(Map<String, dynamic> json) =>
      LineItemsAtTime(
        id: json["id"],
        quantity: json["quantity"],
        name: json["name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        beforePrice: json["before_price"],
        afterDiscount: json["after_discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "name": name,
        "image_url": imageUrl == null ? null : imageUrl,
        "before_price": beforePrice,
        "after_discount": afterDiscount,
      };
}
