import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.id,
    this.storeId,
    this.title,
    this.imageUrl,
    this.summary,
    this.content,
    this.published,
    this.countView,
    this.createdAt,
    this.updatedAt,
    this.categories,
  });

  int id;
  int storeId;
  String title;
  String imageUrl;
  String summary;
  String content;
  bool published;
  int countView;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> categories;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    storeId: json["store_id"],
    title: json["title"],
    imageUrl: json["image_url"],
    summary: json["summary"],
    content: json["content"],
    published: json["published"],
    countView: json["count_view"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "title": title,
    "image_url": imageUrl,
    "summary": summary,
    "content": content,
    "published": published,
    "count_view": countView,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "categories": List<dynamic>.from(categories.map((x) => x)),
  };
}
