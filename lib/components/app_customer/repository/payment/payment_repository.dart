import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/payment_customer/payment_method_response.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/utils/user_info.dart';

class PaymentRepository {
  Future<PaymentMethodCustomerResponse> getPaymentMethod() async {
    try {
      var res = await CustomerServiceManager()
          .service
          .getPaymentMethod(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
