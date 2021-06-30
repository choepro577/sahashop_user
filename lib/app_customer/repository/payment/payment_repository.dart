import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/payment_customer/payment_method_response.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class PaymentRepository {
  Future<PaymentMethodCustomerResponse?> getPaymentMethod() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getPaymentMethod(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
