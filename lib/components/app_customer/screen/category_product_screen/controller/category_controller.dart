import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class CategoryController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var categories = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = Category().obs;

  @override
  void onInit() {
    super.onInit();
    getAllCategory();

  }

  void setCategoryCurrent(Category category) {
    isLoadingProduct.value = true;
    categoryCurrent.value = category;
    getProductWithCategory(category.id);
  }

  Future<void> getProductWithCategory(int idCategory) async {
    try {
      var res = await CustomerRepositoryManager.productCustomerRepository
          .getProductWithCategory(idCategory);
      products.value = res;
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingProduct.value = false;
  }

  Future<void> getAllCategory() async {
    isLoadingProduct.value = true;
    isLoadingCategory.value = true;
    try {
      var res =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();

      categories(res);

      setCategoryCurrent(categories.value[0]);
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }
}
