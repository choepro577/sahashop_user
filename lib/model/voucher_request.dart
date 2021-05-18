class VoucherRequest {
  VoucherRequest({
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
    this.products,
    this.isEnd,
  });

  int voucherType;
  String name;
  String code;
  String description;
  String imageUrl;
  String startTime;
  String endTime;
  int discountType;
  int valueDiscount;
  bool setLimitValueDiscount;
  int maxValueDiscount;
  bool setLimitTotal;
  int valueLimitTotal;
  bool isShowVoucher;
  bool setLimitAmount;
  int amount;
  String products;
  bool isEnd;

  Map<String, dynamic> toJson() => {
        "is_end": isEnd,
        "voucher_type": voucherType,
        "name": name,
        "code": code,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_value_discount": setLimitValueDiscount,
        "max_value_discount": maxValueDiscount,
        "set_limit_total": setLimitTotal,
        "value_limit_total": valueLimitTotal,
        "is_show_voucher": isShowVoucher,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "product_ids": products,
      };
}
