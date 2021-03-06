import 'package:sahashop_user/model/category.dart';

class AllCategoryResponse {
  int code;
  bool success;
  String msgCode;
  List<Category> data;

  AllCategoryResponse({this.code, this.success, this.msgCode, this.data});

  AllCategoryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    if (json['data'] != null) {
      data = new List<Category>();
      json['data'].forEach((v) {
        data.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

