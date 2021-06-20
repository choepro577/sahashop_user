import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/model/config_app.dart';
import 'package:sahashop_user/utils/user_info.dart';

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
