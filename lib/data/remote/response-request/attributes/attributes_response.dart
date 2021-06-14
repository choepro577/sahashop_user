import 'package:sahashop_user/model/attributes.dart';

class AttributesResponse {
  int code;
  bool success;
  String msgCode;
  String msg;
  List<Attribute> data;

  AttributesResponse(
      {this.code, this.success, this.msgCode, this.msg, this.data});

  AttributesResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Attribute>();
      json['data'].forEach((v) {
        data.add(new Attribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

