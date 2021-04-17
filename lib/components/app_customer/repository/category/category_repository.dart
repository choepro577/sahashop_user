import 'package:sahashop_user/components/app_customer/example/category.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/components/utils/thread_data.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/utils/user_info.dart';

class CategoryRepository {
  Future<List<Category>> getAllCategory() async {
    if (ThreadData().isOnline()) {
      try {
        var res = await SahaServiceManager()
            .service
            .getAllCategory(UserInfo().getCurrentStoreCode());
        return res.data;
      } catch (err) {
        handleErrorCustomer(err);
      }
    } else {
      return LIST_CATEGORY_EXAMPLE;
    }
  }
}
