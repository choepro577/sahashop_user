import 'dart:convert';

ShipmentMethod shipmentMethodFromJson(String str) =>
    ShipmentMethod.fromJson(json.decode(str));

String shipmentMethodToJson(ShipmentMethod data) => json.encode(data.toJson());

class ShipmentMethod {
  ShipmentMethod({
    this.partnerId,
    this.fee,
    this.name,
    this.shipType,
  });

  int partnerId;
  int fee;
  String name;
  int shipType;

  factory ShipmentMethod.fromJson(Map<String, dynamic> json) => ShipmentMethod(
        partnerId: json["partner_id"],
        fee: json["fee"],
        name: json["name"],
        shipType: json["ship_type"],
      );

  Map<String, dynamic> toJson() => {
        "partner_id": partnerId,
        "fee": fee,
        "name": name,
        "ship_type": shipType,
      };
}
