import 'package:sahashop_user/components/data_app_customer/data/example/category.dart';
import 'package:sahashop_user/components/utils/thread_data.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/utils/user_info.dart';

import '../handle_error.dart';

class CategoryRepository {
  Future<List<Category>> getAllCategory() async {
    if (ThreadData().isOnline()) {
      try {
        var res = await SahaServiceManager()
            .service
            .getAllCategory(UserInfo().getCurrentIdStore());
        return res.data;
      } catch (err) {
        handleErrorCustomer(err);
      }
    } else {
      return LIST_CATEGORY_EXAMPLE;
    }
  }
}
