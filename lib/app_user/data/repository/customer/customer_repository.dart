import 'package:sahashop_user/app_user/data/remote/response-request/customer/all_customer_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class CustomerRepository {
  Future<AllCustomerResponse?> getAllInfoCustomer(int numberPage) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllInfoCustomer(UserInfo().getCurrentStoreCode()!, numberPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
