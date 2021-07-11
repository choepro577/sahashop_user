import '../../remote/customer_service_manager.dart';
import '../../utils/thread_data.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/model/category_post.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';
import '../handle_error.dart';

class PostCustomerRepository {


  Future<List<CategoryPost>?> getAllCategoryPost() async {
    try {
      var res = await CustomerServiceManager().service!
          .getAllCategoryPost(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }


  Future<List<Post>?> searchPost({String search="", String idCategory="",
    bool descending=false, String sortBy=""}) async {
    if (FlowData().isOnline()) {
      try {
        var res = await CustomerServiceManager().service!.searchPost(
            UserInfo().getCurrentStoreCode(),
            search,
            idCategory,
            descending,
            sortBy);
        return res.data!.data;
      } catch (err) {
        handleErrorCustomer(err);
      }
    } else {
      //return EXAMPLE_LIST_PRODUCT;
    }
  }

  Future<Post?> getDetailPost(int? idPost) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getDetailPost(UserInfo().getCurrentStoreCode(), idPost);
      return res.data;
    } catch (err) {
      // SahaAlert.showError(message: err.toString());
    }
  }
}
