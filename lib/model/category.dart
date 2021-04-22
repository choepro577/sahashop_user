import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 5)
class Category {
  Category({
    this.id,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  dynamic imageUrl;
  @HiveField(3)
  DateTime createdAt;
  @HiveField(4)
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
