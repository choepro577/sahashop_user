import 'package:sahashop_user/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/chat_customer/all_message_response.dart';
import '../../remote/response-request/chat_customer/send_message_customer_request.dart';
import '../../remote/response-request/chat_customer/send_message_customer_response.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';

class ChatCustomerRepository {
  Future<AllMessageCustomerResponse?> getAllMessageCustomer(
      int numberPage) async {
    try {
      var res = await CustomerServiceManager().service!.getAllMessageCustomer(
          StoreInfo().getCustomerStoreCode(), numberPage);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<SendMessageCustomerResponse?> sendMessageToUser(
      SendMessageCustomerRequest sendMessageCustomerRequest) async {
    try {
      var res = await CustomerServiceManager().service!.sendMessageToUser(
          StoreInfo().getCustomerStoreCode(),
          sendMessageCustomerRequest.toJson());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
