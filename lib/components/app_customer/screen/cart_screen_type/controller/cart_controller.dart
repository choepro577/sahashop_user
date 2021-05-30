import 'package:get/get.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/order.dart';

class CartController extends GetxController {
  var listOrder = RxList<Order>().obs;
  var totalMoney = 0.0.obs;

  void getListOrder() {
    var rsListOrder = StorageOrder.getOrder();
    listOrder.value.assignAll(rsListOrder);
    listOrder.value.forEach((e) {
      totalMoney = totalMoney + (e.product.price * e.quantity);
    });
  }

  void removeProduct(int index) {
    StorageOrder.removeProductInCart(index);
    totalMoney.value = 0;
  }
}
