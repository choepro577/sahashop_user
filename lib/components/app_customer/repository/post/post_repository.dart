import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sahashop_user/components/app_customer/remote/customer_service.dart';
import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/utils/thread_data.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/category_post.dart';
import 'package:sahashop_user/model/post.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../handle_error.dart';

class PostCustomerRepository {


  Future<List<CategoryPost>?> getAllCategoryPost() async {
    try {
      var res = await CustomerServiceManager().service!
          .getAllCategoryPost(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }


  Future<List<Post>?> searchPost({String search="", String idCategory="",
    bool descending=false, String sortBy=""}) async {
    if (FlowData().isOnline()) {
      try {
        var res = await CustomerServiceManager().service!.searchPost(
            UserInfo().getCurrentStoreCode(),
            search,
            idCategory,
            descending,
            sortBy);
        return res.data!.data;
      } catch (err) {
        handleErrorCustomer(err);
      }
    } else {
      //return LIST_PRODUCT_EXAMPLE;
    }
  }
}
