import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/state_order.dart';

class OrderOfCustomerDetailController extends GetxController {
  Order? order;

  OrderOfCustomerDetailController({this.order}) {
    getStateHistoryOrder();
  }

  var listStateOrder = RxList<StateOrder>();

  Future<void> getStateHistoryOrder() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getStateHistoryOrder(order!.id);
      listStateOrder(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
