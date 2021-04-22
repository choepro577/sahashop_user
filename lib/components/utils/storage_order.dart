import 'package:hive/hive.dart';
import 'package:sahashop_user/const/const_database_hive.dart';
import 'package:sahashop_user/model/order.dart';

class StorageOrder {
  static Future<void> addOrder(Order order) async {
    final box = Hive.box(CART);
    box.add(order);
    print(order);
  }

  static List<Order> getOrder() {
    final box = Hive.box(CART);
    var result = box.toMap();
    List<Order> listOrder = [];
    result.forEach((key, value) {
      print("key : $key");
      var order = value as Order;
      listOrder.add(order);
    });
    return listOrder;

    print("-------$result");
    var ordesr = box.getAt(0) as Order;
    print(ordesr.product.name);
    print(ordesr.quantity);
    //box.clear();
    var ordessr = box.toMap();
    print(ordessr);
  }

  static void removeProductInCart(int index) {
    final box = Hive.box(CART);
    box.deleteAt(index);
  }

  static void removeCart() {
    final box = Hive.box(CART);
  }
}
