import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'input_model_post.dart';

class PostController extends GetxController {
  InputModelPost? inputModelPost;
  Post? postInput;
  var postShow = Post().obs;
  var isLoadingPost = false.obs;

  DataAppCustomerController dataAppCustomerController = Get.find();
  CartController cartController = Get.find();

  PostController(this.inputModelPost) {
    isLoadingPost.value = true;
    if (inputModelPost == null ||
        (inputModelPost!.post == null && inputModelPost!.postId == null)) {
    } else {
      if (inputModelPost!.post != null) {
        postInput = inputModelPost!.post!;
      } else {
        postInput = Post(id: inputModelPost!.postId);
      }
      getDetailPost();
    }
  }

  Future<void> getDetailPost() async {
    isLoadingPost.value = true;
    try {
      var res = await CustomerRepositoryManager.postCustomerRepository
          .getDetailPost(postInput!.id ?? 0);
      postShow.value = res ?? postInput!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingPost.value = false;
  }
}
