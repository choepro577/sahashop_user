import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/model/state_order.dart';

class OrderDetailController extends GetxController {
  Order? inputOrder;

  var orderResponse = Order().obs;
  var isLoadingOrder = false.obs;

  OrderDetailController({this.inputOrder}) {
    getOneOrder();
    getStateHistoryOrder();
  }

  var listStateOrder = RxList<StateOrder>();

  Future<void> getOneOrder() async {
    isLoadingOrder.value = true;
    try {
      var res = await RepositoryManager.orderRepository
          .getOneOrder(inputOrder!.orderCode!);
      orderResponse(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingOrder.value = false;
  }

  Future<void> getStateHistoryOrder() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getStateHistoryOrder(inputOrder!.id);
      listStateOrder(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changeOrderStatus(String orderStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changeOrderStatus(inputOrder!.orderCode, orderStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changePaymentStatus(String paymentStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changePaymentStatus(inputOrder!.orderCode, paymentStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
