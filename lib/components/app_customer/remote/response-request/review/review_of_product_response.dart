import 'dart:convert';

import 'package:sahashop_user/model/review.dart';

ReviewOfProResponse reviewOfProResponseFromJson(String str) =>
    ReviewOfProResponse.fromJson(json.decode(str));

String reviewOfProResponseToJson(ReviewOfProResponse data) =>
    json.encode(data.toJson());

class ReviewOfProResponse {
  ReviewOfProResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;

  factory ReviewOfProResponse.fromJson(Map<String, dynamic> json) =>
      ReviewOfProResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.averagedStars,
    this.totalReviews,
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  double? averagedStars;
  int? totalReviews;
  int? currentPage;
  List<Review>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        averagedStars: json["averaged_stars"] == null
            ? null
            : json["averaged_stars"].toDouble(),
        totalReviews:
            json["total_reviews"] == null ? null : json["total_reviews"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Review>.from(json["data"].map((x) => Review.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
      );

  Map<String, dynamic> toJson() => {
        "averaged_stars": averagedStars == null ? null : averagedStars,
        "total_reviews": totalReviews == null ? null : totalReviews,
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<Review>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
      };
}
