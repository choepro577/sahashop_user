// To parse this JSON data, do
//
//     final shipment = shipmentFromJson(jsonString);

import 'dart:convert';

Shipment shipmentFromJson(String str) => Shipment.fromJson(json.decode(str));

String shipmentToJson(Shipment data) => json.encode(data.toJson());

class Shipment {
  Shipment({
    this.id,
    this.name,
    this.shipperConfig,
  });

  int? id;
  String? name;
  ShipperConfig? shipperConfig;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        name: json["name"],
        shipperConfig: ShipperConfig.fromJson(json["shipper_config"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shipper_config": shipperConfig!.toJson(),
      };
}

class ShipperConfig {
  ShipperConfig({
    this.partnerId,
    this.token,
    this.use,
    this.cod,
    this.createdAt,
    this.updatedAt,
  });

  int? partnerId;
  String? token;
  bool? use;
  bool? cod;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ShipperConfig.fromJson(Map<String, dynamic> json) => ShipperConfig(
        partnerId: json["partner_id"],
        token: json["token"],
        use: json["use"],
        cod: json["cod"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "use": use,
        "cod": cod,
      };
}
