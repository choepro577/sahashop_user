import 'dart:convert';

SendMessageCustomerRequest sendMessageRequestFromJson(String str) =>
    SendMessageCustomerRequest.fromJson(json.decode(str));

String sendMessageRequestToJson(SendMessageCustomerRequest data) =>
    json.encode(data.toJson());

class SendMessageCustomerRequest {
  SendMessageCustomerRequest({
    this.content,
    this.linkImages,
    this.productId,
  });

  String? content;
  String? linkImages;
  int? productId;

  factory SendMessageCustomerRequest.fromJson(Map<String, dynamic> json) =>
      SendMessageCustomerRequest(
        content: json["content"],
        linkImages: json["link_images"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "link_images": linkImages,
        "product_id": productId,
      };
}
