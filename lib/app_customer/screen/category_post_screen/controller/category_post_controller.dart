import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';

import 'package:sahashop_user/app_user/model/category_post.dart';
import 'package:sahashop_user/app_user/model/post.dart';

import '../../data_app_controller.dart';

class CategoryPostController extends GetxController {
  var isLoadingScreen = false.obs;
  var isLoadingCategoryPost = false.obs;
  var isLoadingPost = true.obs;
  var categories = RxList<CategoryPost>();
  var posts = RxList<Post>();
  var categoryCurrent = CategoryPost().obs;

  CategoryPostController() {
    final DataAppCustomerController dataAppCustomerController = Get.find();
    if (dataAppCustomerController.categoryCurrent != null) {
      categoryCurrent(dataAppCustomerController.categoryPostCurrent!);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategoryPost();
  }

  void setCategoryPostCurrent(CategoryPost category) {
    isLoadingPost.value = true;
    categoryCurrent.value = category;
    getPostWithCategoryPost(category.id);
  }

  Future<void> getPostWithCategoryPost(int? idCategoryPost) async {
    try {
      var res = await CustomerRepositoryManager.postCustomerRepository
          .searchPost(idCategory: "${idCategoryPost ?? ""}");
      posts(res!);
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingPost.value = false;
  }

  Future<void> getAllCategoryPost() async {
    isLoadingPost.value = true;
    isLoadingCategoryPost.value = true;
    try {
      var res = await CustomerRepositoryManager.postCustomerRepository
          .getAllCategoryPost();

      categories(res!);
      categories.insert(0, CategoryPost(id: null, title: "Tất cả"));

      if (categoryCurrent.value != null) {
        getPostWithCategoryPost(categoryCurrent.value.id);
      } else if (categories.length > 0) {
        setCategoryPostCurrent(categories.toList()[0]);
      }
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategoryPost.value = false;
  }
}
