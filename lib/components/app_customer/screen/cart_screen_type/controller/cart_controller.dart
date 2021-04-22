import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/order.dart';

class CartController extends GetxController {
  var listOrder = RxList<Order>().obs;

  void getListOrder() {
    var rsListOrder = StorageOrder.getOrder();
    listOrder.value.assignAll(rsListOrder);
  }

  void removeProduct(int index) {
    StorageOrder.removeProductInCart(index);
  }
}
