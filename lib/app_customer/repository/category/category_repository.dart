import 'package:sahashop_user/app_user/data/example/category.dart';
import '../../remote/customer_service_manager.dart';
import '../../repository/handle_error.dart';
import '../../utils/thread_data.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class CategoryRepository {
  Future<List<Category>?> getAllCategory() async {
    if (FlowData().isOnline()) {
      try {
        var res = await CustomerServiceManager()
            .service!
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
