import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

class ProductController extends GetxController {
  var loading = false.obs;
  var listProduct = RxList<Product>();

  ProductController() {
    getAllProduct();
  }

  Future<void> getAllProduct() async {
    loading.value = true;
    try {
     var list = await RepositoryManager.productRepository.getAllProduct();
      listProduct(list);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
