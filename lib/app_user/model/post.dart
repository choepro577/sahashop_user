import 'package:sahashop_user/app_user/model/category_post.dart';

import 'category.dart';

class Post {
  int? id;
  int? storeId;
  String? title;
  String? imageUrl;
  String? summary;
  String? content;
  bool? published;
  int? countView;
  String? createdAt;
  String? updatedAt;
  List<CategoryPost>? category;

  Post(
      {this.id,
      this.storeId,
      this.title,
      this.imageUrl,
      this.summary,
      this.content,
      this.published,
      this.countView,
      this.createdAt,
      this.updatedAt,
      this.category});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    title = json['title'];
    imageUrl = json['image_url'];
    summary = json['summary'];
    content = json['content'];
    published = json['published'];
    countView = json['count_view'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['categories'] != null) {
      category = [];
      json['categories'].forEach((v) {
        category!.add(new CategoryPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['summary'] = this.summary;
    data['content'] = this.content;
    data['published'] = this.published;
    data['count_view'] = this.countView;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
