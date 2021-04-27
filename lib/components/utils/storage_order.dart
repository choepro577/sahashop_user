import 'package:hive/hive.dart';
import 'package:sahashop_user/const/const_database_hive.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/utils/user_info.dart';

class StorageOrder {
  static Future<void> addOrder(Order order) async {
    final box = Hive.box(CART + '${UserInfo().getCurrentStoreCode()}');
    box.add(order);
    print(order);
  }

  static Future<void> updateOrder(Order order, int indexOrder) async {
    final box = Hive.box(CART + '${UserInfo().getCurrentStoreCode()}');
    box.putAt(indexOrder, order);
    print(order);
  }

  static List<Order> getOrder() {
    final box = Hive.box(CART + '${UserInfo().getCurrentStoreCode()}');
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
    final box = Hive.box(CART + '${UserInfo().getCurrentStoreCode()}');
    box.deleteAt(index);
  }

  static void removeCart() {
    final box = Hive.box(CART + '${UserInfo().getCurrentStoreCode()}');
  }
}
