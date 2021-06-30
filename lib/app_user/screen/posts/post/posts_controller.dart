import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/post.dart';

class PostController extends GetxController {
  var loading = false.obs;
  var listPost = RxList<Post>();

  PostController() {
    getAllPost();
  }

  Future<bool?> getAllPost() async {
    loading.value = true;
    try {
      var list = await RepositoryManager.postRepository.getAllPost();
      listPost(list!);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
