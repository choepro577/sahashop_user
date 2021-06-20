import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/category_post.dart';
import 'package:sahashop_user/model/post.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../handle_error.dart';

class PostRepository {
  Future<CategoryPost?> createCategoryPost(
      {String? title,
      File? image,
      String? description,}) async {
    try {
      var res = await SahaServiceManager().service!.createCategoryPost(
        UserInfo().getCurrentStoreCode(),
        {
          "title": title,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
          "description": description,
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<CategoryPost>?> getAllCategoryPost() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCategoryPost(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Post?> createPost(
      {String? title,
        File? image,
        String? summary,
        String? content,
        bool? published,
        int? categoryId}) async {
    try {
      var res = await SahaServiceManager().service!.createPost(
        UserInfo().getCurrentStoreCode(),
        {
          "title": title,
          "image":
          image == null ? null : await MultipartFile.fromFile(image.path),
          "summary": summary,
          "content": content,
          "published": published,
          "category_id": categoryId
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Post>?> getAllPost() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllPost(UserInfo().getCurrentStoreCode());
      return res.data!.data;
    } catch (err) {
      handleError(err);
    }
  }
}
