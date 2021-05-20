import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

import '../../data_app_controller.dart';

class CategoryController extends GetxController {

  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var categories = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = Category().obs;

  CategoryController() {
    final DataAppCustomerController dataAppCustomerController = Get.find();
    if (dataAppCustomerController.categoryCurrent != null) {
      categoryCurrent(dataAppCustomerController.categoryCurrent);
    }
  }

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
          .searchProduct(idCategory: idCategory ?? "");
      products(res);
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

      if (categoryCurrent.value != null) {

        setCategoryCurrent(categoryCurrent.value);


      } else if (categories.length > 0) {
        getProductWithCategory(categories.toList()[0].id);
        setCategoryCurrent(categories.toList()[0]);
      }
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }
}
