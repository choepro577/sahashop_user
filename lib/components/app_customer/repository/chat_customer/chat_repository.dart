import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/all_message_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/send_message_customer_request.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/send_message_customer_response.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/utils/user_info.dart';

class ChatCustomerRepository {
  Future<AllMessageCustomerResponse> getAllMessageCustomer(
      int numberPage) async {
    try {
      var res = await CustomerServiceManager()
          .service
          .getAllMessageCustomer(UserInfo().getCurrentStoreCode(), numberPage);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<SendMessageCustomerResponse> sendMessageToUser(
      SendMessageCustomerRequest sendMessageCustomerRequest) async {
    try {
      var res = await CustomerServiceManager().service.sendMessageToUser(
          UserInfo().getCurrentStoreCode(),
          sendMessageCustomerRequest.toJson());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
