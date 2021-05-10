import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/category_post.dart';

class CategoryPostController extends GetxController {
  var loading = false.obs;
  var listCategoryPost = RxList<CategoryPost>();

  CategoryPostController() {
    getAllCategoryPost();
  }

  Future<void> getAllCategoryPost() async {
    loading.value = true;
    try {
      var list = await RepositoryManager.postRepository.getAllCategoryPost();
      listCategoryPost(list);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
