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
  var categoryCurrent = (-1).obs;

  CategoryPostController() {
    final DataAppCustomerController dataAppCustomerController = Get.find();
    if (dataAppCustomerController.inputModelPosts != null &&
        dataAppCustomerController.inputModelPosts!.categoryPostId != -1) {
      categoryCurrent(
          dataAppCustomerController.inputModelPosts!.categoryPostId);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategoryPost();
  }

  void setCategoryPostCurrent(CategoryPost category) {
    isLoadingPost.value = true;
    categoryCurrent.value = category.id ?? -1;
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

      getPostWithCategoryPost(
          categoryCurrent.value == -1 ? null : categoryCurrent.value);
    } catch (err) {
      print(err);
      handleErrorCustomer(err);
    }
    isLoadingCategoryPost.value = false;
  }
}
