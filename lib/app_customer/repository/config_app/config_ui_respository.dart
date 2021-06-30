import '../../remote/customer_service_manager.dart';
import '../../repository/handle_error.dart';
import 'package:sahashop_user/app_user/model/config_app.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class ConfigUICustomerRepository {
  Future<ConfigApp?> getAppTheme() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAppTheme(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
