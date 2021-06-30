import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/login/login_response.dart';
import '../../repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class LoginCustomerRepository {
  Future<LoginResponse?> loginAccount(
    String phone,
    String password,
  ) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .loginAccount(UserInfo().getCurrentStoreCode(), {
        "phone_number": phone,
        "password": password,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
