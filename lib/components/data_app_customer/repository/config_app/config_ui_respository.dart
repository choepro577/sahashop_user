import 'package:sahashop_user/components/data_app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/data_app_customer/repository/handle_error.dart';
import 'package:sahashop_user/components/model_app_customer/config_app_customer.dart';

class ConfigUICustomerRepository {
  Future<ConfigAppCustomer> getAppTheme() async {
    try {
      var res = await CustomerServiceManager().service.getAppTheme(10);
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
