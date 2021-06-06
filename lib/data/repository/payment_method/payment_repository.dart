import 'package:sahashop_user/data/remote/response-request/payment_method/payment_method_response.dart';
import 'package:sahashop_user/data/remote/response-request/payment_method/update_payment_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/utils/user_info.dart';

class PaymentRepository {
  Future<PaymentMethodResponse> getPaymentMethod() async {
    try {
      var res = await SahaServiceManager()
          .service
          .getPaymentMethod(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdatePaymentResponse> upDatePaymentMethod(
      int idPaymentMethod, Map<String, dynamic> body) async {
    try {
      var res = await SahaServiceManager().service.upDatePaymentMethod(
          UserInfo().getCurrentStoreCode(), idPaymentMethod, body);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
