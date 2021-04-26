import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class ProductController extends GetxController {
  var quantity = 1.obs;
  var listOrder = RxList<Order>().obs;

  void increaseItem() {
    quantity = quantity + 1;
  }

  void decreaseItem() {
    if (quantity > 1) {
      quantity = quantity - 1;
    } else {
      return;
    }
  }

  void addOrder(Product product, int quantity) {
    var order = Order(product: product, quantity: quantity);
    StorageOrder.addOrder(order);
  }

  void getListOrder() {
    var rsListOrder = StorageOrder.getOrder();
    listOrder.value.assignAll(rsListOrder);
  }
}
