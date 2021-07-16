import 'package:sahashop_user/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import '../../repository/handle_error.dart';
import 'package:sahashop_user/app_user/model/config_app.dart';

class ConfigUICustomerRepository {
  Future<ConfigApp?> getAppTheme() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAppTheme(StoreInfo().getCustomerStoreCode());
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
