import 'package:get/get.dart';
import 'package:sahashop_user/components/data_app_customer/data/handle_error.dart';
import 'package:sahashop_user/components/data_app_customer/data/repository.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

class CategoryController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = false.obs;
  var categories = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = Category().obs;

  void setCategoryCurrent(Category category) {
    categoryCurrent.value = category;
  }

  Future<void> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var res = await CustomerRepositoryManager.categoryRepository.getAllCategory();
      categories.assignAll(res);
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }
}
