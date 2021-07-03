import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/register/register_response.dart';
import '../../repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class RegisterCustomerRepository {
  Future<RegisterResponse?> registerAccount({
    String? phone,
    String? password,
      String? email,
      String? name}
  ) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .registerAccount(UserInfo().getCurrentStoreCode(), {
        "phone_number": phone,
        "password": password,
        "name":name,
        "email":email
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
