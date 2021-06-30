import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/category/create_category_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';
import '../handle_error.dart';

class CategoryRepository {

  Future<Category?> createCategory(String? name, File? image) async {
    try {
      var res = await SahaServiceManager().service!.createCategory(
        UserInfo().getCurrentStoreCode(),
        {
          "name": name,
          "image":
          image == null ? null : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Category?> updateCategory(String? name,int? categoryId, String? imageUrl, File? image) async {
    try {
      var res = await SahaServiceManager().service!.updateCategory(
        UserInfo().getCurrentStoreCode(),
        categoryId,
        {
          "name": name,
          "image_url": imageUrl,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Category>?> getAllCategory() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCategory(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool> deleteCategory(int productId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteCategory(UserInfo().getCurrentStoreCode(), productId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }
}
