import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/register/register_response.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/utils/user_info.dart';

class RegisterCustomerRepository {
  Future<RegisterResponse> registerAccount(
    String phone,
    String password,
  ) async {
    try {
      var res = await CustomerServiceManager()
          .service
          .registerAccount(UserInfo().getCurrentStoreCode(), {
        "phone_number": phone,
        "password": password,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
