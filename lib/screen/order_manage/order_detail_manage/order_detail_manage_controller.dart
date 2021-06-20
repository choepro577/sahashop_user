import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/state_order.dart';

class OrderDetailController extends GetxController {
  Order order = new Order();

  var orderResponse = Order().obs;
  var isLoadingOrder = false.obs;

  OrderDetailController({order}) {
    getOneOrder();
    getStateHistoryOrder();
  }

  var listStateOrder = RxList<StateOrder>();

  Future<void> getOneOrder() async {
    isLoadingOrder.value = true;
    try {
      var res =
          await RepositoryManager.orderRepository.getOneOrder(order.orderCode!);
      orderResponse(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingOrder.value = false;
  }

  Future<void> getStateHistoryOrder() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getStateHistoryOrder(order.id);
      listStateOrder(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changeOrderStatus(String orderStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changeOrderStatus(order.orderCode, orderStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
