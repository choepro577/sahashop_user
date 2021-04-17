import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sahashop_user/data/remote/response/category/create_category_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../handle_error.dart';

class CategoryRepository {
  Future<Category> createCategory(String name, File image) async {
    try {
      var res = await SahaServiceManager().service.createCategory(
        UserInfo().getCurrentstoreCode(),
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

  Future<List<Category>> getAllCategory() async {
    try {
      var res = await SahaServiceManager()
          .service
          .getAllCategory(UserInfo().getCurrentstoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
