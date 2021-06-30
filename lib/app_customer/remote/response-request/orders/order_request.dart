class OrderRequest {
  OrderRequest({
    this.paymentMethodId,
    this.partnerShipperId,
    this.shipperType,
    this.totalShippingFee,
    this.customerAddressId,
    this.customerNote,
  });

  int? paymentMethodId;
  int? partnerShipperId;
  int? shipperType;
  int? totalShippingFee;
  int? customerAddressId;
  String? customerNote;

  Map<String, dynamic> toJson() => {
        "payment_method_id": paymentMethodId,
        "partner_shipper_id": partnerShipperId,
        "shipper_type": shipperType,
        "total_shipping_fee": totalShippingFee,
        "customer_address_id": customerAddressId,
        "customer_note": customerNote,
      };
}
