import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen_type/cart_screen_1.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class ProductController extends GetxController {
  var quantity = 1.obs;
  var listOrder = RxList<Order>();
  var currentIndexListOrder = 0.obs;
  var currentImage = 0.obs;
  var isSeeMore = false.obs;
  var animateAddCart = false.obs;

  void animatedAddCard() {
    animateAddCart.value = true;
    print(animateAddCart.value);
    Future.delayed(Duration(milliseconds: 1000), () {
      animateAddCart.value = false;
      print(animateAddCart.value);
    });
  }

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

    int idCurrent =
        listOrder.indexWhere((element) => element.product.id == product.id);

    print(idCurrent);

    if (idCurrent != -1) {
      var orderUpdate = Order(
          product: product, quantity: listOrder[idCurrent].quantity + quantity);
      StorageOrder.updateOrder(orderUpdate, idCurrent);
      getListOrder();

      /// back sheet
      Get.back();
      Get.to(() => CartScreen1());
    } else {
      StorageOrder.addOrder(order);
      getListOrder();

      /// back sheet
      Get.back();
      Get.to(() => CartScreen1());
    }
  }

  void getListOrder() {
    var rsListOrder = StorageOrder.getOrder();
    listOrder(rsListOrder);
  }
}
