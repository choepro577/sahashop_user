class CategoryPost {
  int? id;
  String? imageUrl;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  CategoryPost(
      {this.id,
        this.imageUrl,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt});

  CategoryPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}