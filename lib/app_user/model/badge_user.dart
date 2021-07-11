class BadgeUser {
  BadgeUser({
    this.ordersWaitingForProgressing,
    this.ordersPacking,
    this.ordersShipping,
    this.chatsUnread,
    this.voucherTotal,
    this.productsDiscount,
    this.reviewsNoProcess,
  });

  int? ordersWaitingForProgressing;
  int? ordersPacking;
  int? ordersShipping;
  int? chatsUnread;
  int? voucherTotal;
  int? productsDiscount;
  int? reviewsNoProcess;

  factory BadgeUser.fromJson(Map<String, dynamic> json) => BadgeUser(
        ordersWaitingForProgressing:
            json["orders_waitting_for_progressing"] == null
                ? null
                : json["orders_waitting_for_progressing"],
        ordersPacking:
            json["orders_packing"] == null ? null : json["orders_packing"],
        ordersShipping:
            json["orders_shipping"] == null ? null : json["orders_shipping"],
        chatsUnread: json["chats_unread"] == null ? null : json["chats_unread"],
        voucherTotal:
            json["voucher_total"] == null ? null : json["voucher_total"],
        productsDiscount: json["products_discount"] == null
            ? null
            : json["products_discount"],
        reviewsNoProcess: json["reviews_no_process"] == null
            ? null
            : json["reviews_no_process"],
      );

  Map<String, dynamic> toJson() => {
        "orders_waitting_for_progressing": ordersWaitingForProgressing == null
            ? null
            : ordersWaitingForProgressing,
        "orders_packing": ordersPacking == null ? null : ordersPacking,
        "orders_shipping": ordersShipping == null ? null : ordersShipping,
        "chats_unread": chatsUnread == null ? null : chatsUnread,
        "voucher_total": voucherTotal == null ? null : voucherTotal,
        "products_discount": productsDiscount == null ? null : productsDiscount,
        "reviews_no_process":
            reviewsNoProcess == null ? null : reviewsNoProcess,
      };
}
