import 'package:get/get.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class ProductController extends GetxController {
  var quantity = 1.obs;
  var listOrder = RxList<Order>().obs;
  var currentIndexListOrder = 0.obs;
  var currentImage = 0.obs;
  var isSeeMore = false.obs;

  void changeIndexImage(int value) {
    currentImage.value = value;
  }

  void onchangeSeeMore() {
    isSeeMore.value = !isSeeMore.value;
  }

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

    for (int i = 0; i <= listOrder.value.length; i++) {
      try {
        if (product.id == listOrder.value[i].product.id) {
          currentIndexListOrder.value = i;
        }
      } catch (e) {
        break;
      }
    }

    for (int i = 0; i <= listOrder.value.length; i++) {
      try {
        if (product.id ==
            listOrder.value[currentIndexListOrder.value].product.id) {
          var orderUpdate = Order(
              product: product,
              quantity: listOrder.value[currentIndexListOrder.value].quantity +
                  quantity);
          StorageOrder.updateOrder(orderUpdate, currentIndexListOrder.value);
        } else {
          StorageOrder.addOrder(order);
          return;
        }
      } catch (e) {
        StorageOrder.addOrder(order);
        return;
      }
    }
  }

  void getListOrder() {
    var rsListOrder = StorageOrder.getOrder();
    listOrder.value.assignAll(rsListOrder);
  }
}
