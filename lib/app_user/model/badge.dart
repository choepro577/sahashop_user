class Badge {
  Badge({
    this.ordersWaitingForProgressing = 0,
    this.ordersPacking = 0,
    this.ordersShipping = 0,
    this.ordersNoReviews = 0,
    this.chatsUnread = 0,
    this.cartQuantity = 0,
    this.favoriteProducts = 0,
    this.customerScore = 0,
    this.voucherTotal = 0,
    this.productsDiscount = 0,
    this.totalBoughtAmount = 0,
  });

  int? ordersWaitingForProgressing;
  int? ordersPacking;
  int? ordersShipping;
  int? ordersNoReviews;
  int? chatsUnread;
  int? cartQuantity;
  int? favoriteProducts;
  int? customerScore;
  int? voucherTotal;
  int? productsDiscount;
  double? totalBoughtAmount;

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        ordersWaitingForProgressing:
            json["orders_waitting_for_progressing"] == null
                ? null
                : json["orders_waitting_for_progressing"],
        ordersPacking:
            json["orders_packing"] == null ? null : json["orders_packing"],
        ordersShipping:
            json["orders_shipping"] == null ? null : json["orders_shipping"],
        ordersNoReviews: json["orders_no_reviews"] == null
            ? null
            : json["orders_no_reviews"],
        chatsUnread: json["chats_unread"] == null ? null : json["chats_unread"],
        cartQuantity:
            json["cart_quantity"] == null ? null : json["cart_quantity"],
        favoriteProducts: json["favorite_products"] == null
            ? null
            : json["favorite_products"],
        customerScore:
            json["customer_score"] == null ? null : json["customer_score"],
        voucherTotal:
            json["voucher_total"] == null ? null : json["voucher_total"],
        productsDiscount: json["products_discount"] == null
            ? null
            : json["products_discount"],
        totalBoughtAmount: json["total_bought_amount"] == null
            ? null
            : json["total_bought_amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "orders_waitting_for_progressing": ordersWaitingForProgressing == null
            ? null
            : ordersWaitingForProgressing,
        "orders_packing": ordersPacking == null ? null : ordersPacking,
        "orders_shipping": ordersShipping == null ? null : ordersShipping,
        "orders_no_reviews": ordersNoReviews == null ? null : ordersNoReviews,
        "chats_unread": chatsUnread == null ? null : chatsUnread,
        "cart_quantity": cartQuantity == null ? null : cartQuantity,
        "favorite_products": favoriteProducts == null ? null : favoriteProducts,
        "customer_score": customerScore == null ? null : customerScore,
        "voucher_total": voucherTotal == null ? null : voucherTotal,
        "products_discount": productsDiscount == null ? null : productsDiscount,
        "total_bought_amount":
            totalBoughtAmount == null ? null : totalBoughtAmount,
      };
}
