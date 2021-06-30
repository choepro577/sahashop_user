import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/model/state_order.dart';

class OrderHistoryDetailController extends GetxController {
  Order? order;
  var listChoose = RxList<bool>([false, false, false, false, false, false]);
  var reason = "";

  OrderHistoryDetailController({this.order}) {
    getStateHistoryCustomerOrder();
  }

  var listStateOrder = RxList<StateOrder>();

  Future<void> getStateHistoryCustomerOrder() async {
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getStateHistoryCustomerOrder(order!.id);
      listStateOrder(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> cancelOrder() async {
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .cancelOrder(order!.orderCode, reason);
      Get.back(result: "CANCELLED");
    } catch (err) {
      handleError(err);
    }
  }

  void checkChooseReason(bool value, int index) {
    listChoose([false, false, false, false, false, false]);
    if (value == false) {
      listChoose[index] = true;
    }
  }
}
