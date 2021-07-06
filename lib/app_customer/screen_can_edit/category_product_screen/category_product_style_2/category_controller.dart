import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import '../../../repository/handle_error.dart';
import '../../../repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/model/product.dart';


class CategoryController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var isLoadingProductMore = false.obs;
  var categories = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = Category().obs;
  var textSearch = "".obs;
  var sortByShow = "views".obs;
  var descendingShow = true.obs;
  var currentPage = 1;
  var canLoadMore = true;

  TextEditingController textEditingControllerSearch = TextEditingController();

  CategoryController() {
    final DataAppCustomerController dataAppCustomerController = Get.find();
    if (dataAppCustomerController.categoryCurrent != null) {
      categoryCurrent(dataAppCustomerController.categoryCurrent!);
    }

  }

  void init() {
    super.onInit();
    getAllCategory();
    searchProduct(search: textSearch.value,
        sortBy: sortByShow.value,
        descending: descendingShow.value,
      idCategory: categoryCurrent.value.id != null ? categoryCurrent.value.id : null
    );
  }

  Future<bool?> searchProduct(
      {String? search, bool? descending, String? sortBy, int? idCategory,bool isLoadMore = false}) async {

    if(isLoadMore == false) {
      currentPage = 1;
      canLoadMore = true;
      isLoadingProduct.value = true;
    }

    if(isLoadMore == true) {
      if(canLoadMore == false) return true;
      isLoadingProductMore.value = true;
    }

    var categoryId = "";
    categories.forEach((element) {
      if(idCategory != null && idCategory == element.id) {
        categoryCurrent(element);
        categoryId = idCategory.toString();
      }
    });
    if(search != null) {
      textSearch(search);
    }

    if(descending != null) {
      descendingShow(descending);
    }

    if(sortBy != null) {
      sortByShow(sortBy);
    }


    try {
      var list = (await CustomerRepositoryManager.productCustomerRepository
          .searchProduct(
              page: currentPage,
              search: textSearch.value,
              idCategory:categoryCurrent.value.id == null ? "": categoryCurrent.value.id.toString(),
              descending: sortBy == "price" ? descendingShow.value : true,
              sortBy: sortByShow.value))!;
   
      if(isLoadMore == false) {
        products(list);
      } else {
        products.addAll(list);
        products.refresh();
      }

      if(list.length < 20) {
        canLoadMore = false;
      } else {
        currentPage++;
      }

      isLoadingProduct.value = false;
      isLoadingProductMore.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
    isLoadingProductMore.value = false;
  }

  void setCategoryCurrent(Category category) {
    isLoadingProduct.value = true;
    categoryCurrent.value = category;
  }

  Future<void> getAllCategory() async {
    isLoadingProduct.value = true;
    isLoadingCategory.value = true;
    try {
      var res =
          await CustomerRepositoryManager.categoryRepository.getAllCategory();

      categories(res!);
      categories.insert(0, Category(name: "Tất cả", id: null));

    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategory.value = false;
  }
}
