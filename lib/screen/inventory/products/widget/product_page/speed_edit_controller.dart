import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/product.dart';

class SpeedEditController extends GetxController {
  final Product? product;
  TextEditingController textEditingControllerPrice =
      new TextEditingController();
  TextEditingController textEditingControllerQuantityInStock =
      new TextEditingController();

  late ProductRequest productRequest;

  SpeedEditController({this.product}) {
    productRequest = ProductRequest.fromProduct(product!);

    textEditingControllerPrice.text = product!.price.toString();
    textEditingControllerQuantityInStock.text =
    product!.quantityInStock == null || product!.quantityInStock! < 0
        ? ""
        : product!.quantityInStock.toString();
  }

  void updateProduct() async {
    productRequest.quantityInStock =
        int.tryParse(textEditingControllerQuantityInStock.text);
    productRequest.price =
        double.tryParse(textEditingControllerPrice.text) ?? 0;

    var data = await RepositoryManager.productRepository
        .update(product!.id!, productRequest);
    SahaAlert.showSuccess(message: "Cập nhật thành công");
    Navigator.pop(Get.context!, {"update": data});
  }
}
