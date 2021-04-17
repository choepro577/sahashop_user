import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

class CategoryController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = false.obs;
  var idCategory = 1.obs;
  var categories = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = Category().obs;

  void setCategoryCurrent(Category category) {
    categoryCurrent.value = category;
    idCategory.value = categoryCurrent.value.id;
    print(categoryCurrent.value.id);
    getProductWithCategory(idCategory.value);
  }

  Future<void> getProductWithCategory(int idCategory) async {
    isLoadingCategory.value = true;
    try {
      var res = await CustomerRepositoryManager.productCustomerRepository
          .getProductWithCategory(idCategory);
      products.value = res;
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }

  Future<void> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var res =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();
      categories.assignAll(res);
      setCategoryCurrent(categories.value[0]);
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }
}
