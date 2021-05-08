class BannerItem {
  BannerItem({
    this.storeId,
    this.imageUrl,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  int storeId;
  String imageUrl;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
    storeId: json["store_id"],
    imageUrl: json["image_url"]?? "",
    title: json["title"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
    "title": title,
  };
}