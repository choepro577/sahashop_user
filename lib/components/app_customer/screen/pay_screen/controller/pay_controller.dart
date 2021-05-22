import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/info_address.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/data/remote/response-request/order_request.dart';

class PayController extends GetxController {
  var listOrder = RxList<Order>().obs;
  var listItem = RxList<LineItem>();
  var totalMoney = 0.obs;
  var infoAddress = InfoAddress().obs;
  var isLoadingOrder = false.obs;

  void getListOrder() {
    var rsListOrder = StorageOrder.getOrder();
    infoAddress.value = null;
    listOrder.value.assignAll(rsListOrder);
    listOrder.value.forEach((e) {
      totalMoney = totalMoney + (e.product.price * e.quantity);
      listItem.add(LineItem(productId: e.product.id, quantity: e.quantity));
    });
  }

  Future<void> createOrders() async {
    if (infoAddress.value == null) {
      SahaAlert.showError(message: "Chưa chọn địa chỉ nhận ");
    } else {
      isLoadingOrder.value = true;
      var orderRequest = OrderRequest(
          infoContact: infoAddress.value,
          infoReceiver: infoAddress.value,
          lineItems: listItem);
      try {
        var resultOrder = await CustomerRepositoryManager
            .createOrderCustomerRepository
            .createOrder(orderRequest);
        isLoadingOrder.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isLoadingOrder.value = false;
    }
  }
}
